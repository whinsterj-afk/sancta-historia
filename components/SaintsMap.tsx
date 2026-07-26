"use client";

import { useEffect, useRef } from "react";
import {
  LngLatBounds,
  Map as MapLibreMap,
  Marker,
  NavigationControl,
  type PaddingOptions,
  Popup,
  setWorkerUrl,
} from "maplibre-gl";
import "maplibre-gl/dist/maplibre-gl.css";
import type { RouteLocation } from "./MapContextPanel";

// maplibre-gl resolves its worker script relative to import.meta.url, which
// Turbopack doesn't preserve. Point it at the static copy in public/ instead.
setWorkerUrl("/maplibre-gl-worker.mjs");

type CompletePadding = Required<PaddingOptions>;
type MapCoordinate = [number, number];

const MAP_GUTTER = 24;
const MIN_VISIBLE_MAP_WIDTH = 200;
const MIN_VISIBLE_MAP_HEIGHT = 180;

function elementBounds(selector: string) {
  return document.querySelector<HTMLElement>(selector)?.getBoundingClientRect();
}

function constrainPaddingPair(
  start: number,
  end: number,
  size: number,
  minimumVisibleSize: number,
) {
  const maximumPadding = Math.max(0, size - minimumVisibleSize);
  const totalPadding = start + end;

  if (totalPadding <= maximumPadding || totalPadding === 0) {
    return [start, end] as const;
  }

  const scale = maximumPadding / totalPadding;
  return [start * scale, end * scale] as const;
}

function getMapPadding(
  map: MapLibreMap,
  contextOpen: boolean,
): CompletePadding {
  const containerBounds = map.getContainer().getBoundingClientRect();
  const { width, height } = containerBounds;
  const compact = width <= 720;
  const logoBounds = elementBounds(".hero-logo");
  const timelineBounds = elementBounds("[data-map-timeline]");

  let top = logoBounds
    ? logoBounds.bottom - containerBounds.top + MAP_GUTTER
    : compact
      ? 160
      : 150;
  let right = compact ? 20 : MAP_GUTTER;
  let bottom =
    !contextOpen && timelineBounds
      ? containerBounds.bottom - timelineBounds.top + MAP_GUTTER
      : compact
        ? 28
        : 40;
  let left = compact ? 20 : MAP_GUTTER;

  if (!compact && contextOpen) {
    const contextBounds = elementBounds("[data-map-context-panel]");
    if (contextBounds) {
      left = contextBounds.right - containerBounds.left + MAP_GUTTER;
    }
  } else if (!compact) {
    const leftPanelBounds = elementBounds("[data-map-left-panel]");
    const rightPanelBounds = elementBounds("[data-map-right-panel]");

    if (leftPanelBounds) {
      left = leftPanelBounds.right - containerBounds.left + MAP_GUTTER;
    }
    if (rightPanelBounds) {
      right = containerBounds.right - rightPanelBounds.left + MAP_GUTTER;
    }
  }

  [left, right] = constrainPaddingPair(
    Math.max(MAP_GUTTER, left),
    Math.max(MAP_GUTTER, right),
    width,
    compact ? 120 : MIN_VISIBLE_MAP_WIDTH,
  );
  [top, bottom] = constrainPaddingPair(
    Math.max(MAP_GUTTER, top),
    Math.max(MAP_GUTTER, bottom),
    height,
    MIN_VISIBLE_MAP_HEIGHT,
  );

  return { top, right, bottom, left };
}

function fitCoordinates(
  map: MapLibreMap,
  coordinates: MapCoordinate[],
  {
    contextOpen,
    duration,
    maxZoom,
    singlePointZoom,
  }: {
    contextOpen: boolean;
    duration: number;
    maxZoom: number;
    singlePointZoom: number;
  },
) {
  if (coordinates.length === 0) return;

  const padding = getMapPadding(map, contextOpen);
  if (coordinates.length === 1) {
    map.easeTo({
      center: coordinates[0],
      zoom: singlePointZoom,
      padding,
      duration,
    });
    return;
  }

  const bounds = new LngLatBounds();
  coordinates.forEach((coordinate) => bounds.extend(coordinate));
  const camera = map.cameraForBounds(bounds, { padding, maxZoom });

  if (!camera) return;
  map.easeTo({ ...camera, padding, duration });
}

export interface SaintLocation {
  id: number;
  name: string;
}

export default function SaintsMap({
  saints,
  selectedSaintId,
  previewSaintId,
  onSelectSaint,
  timelineLocations,
  routeLocations,
  contextOpen,
}: {
  saints: SaintLocation[];
  selectedSaintId?: number | null;
  previewSaintId?: number | null;
  onSelectSaint?: (saintId: number) => void;
  timelineLocations?: RouteLocation[];
  routeLocations?: RouteLocation[];
  contextOpen: boolean;
}) {
  const containerRef = useRef<HTMLDivElement>(null);
  const mapRef = useRef<MapLibreMap | null>(null);
  const markersRef = useRef<Marker[]>([]);
  const markersBySaintRef = useRef<Map<number, Marker[]>>(new Map());
  const routeMarkersRef = useRef<Marker[]>([]);
  const refitMapRef = useRef<((duration: number) => void) | null>(null);

  useEffect(() => {
    if (!containerRef.current || mapRef.current) return;

    mapRef.current = new MapLibreMap({
      container: containerRef.current,
      style:
        "https://api.maptiler.com/maps/019f9748-fef8-71cf-a038-d6a0583942fc/style.json?key=kdSeGcKZzX2dbBiw5pOr",
      center: [15, 40],
      zoom: 2.5,
    });

    mapRef.current.addControl(new NavigationControl(), "bottom-right");

    return () => {
      mapRef.current?.remove();
      mapRef.current = null;
    };
  }, []);

  useEffect(() => {
    let animationFrame = 0;

    function resizeAndRefit() {
      window.cancelAnimationFrame(animationFrame);
      animationFrame = window.requestAnimationFrame(() => {
        mapRef.current?.resize();
        refitMapRef.current?.(0);
      });
    }

    window.addEventListener("resize", resizeAndRefit);
    return () => {
      window.removeEventListener("resize", resizeAndRefit);
      window.cancelAnimationFrame(animationFrame);
    };
  }, []);

  useEffect(() => {
    const map = mapRef.current;
    if (!map) return;

    markersRef.current.forEach((marker) => marker.remove());
    markersRef.current = [];
    markersBySaintRef.current.clear();

    const saintsById = new Map(saints.map((saint) => [saint.id, saint]));
    const timelinePoints = (timelineLocations ?? []).flatMap((location) => {
      const saint = saintsById.get(location.saint_id);
      if (
        !saint ||
        location.latitude == null ||
        location.longitude == null
      ) {
        return [];
      }

      const latitude = Number(location.latitude);
      const longitude = Number(location.longitude);

      if (
        !Number.isFinite(latitude) ||
        !Number.isFinite(longitude) ||
        latitude < -90 ||
        latitude > 90 ||
        longitude < -180 ||
        longitude > 180
      ) {
        return [];
      }

      return [{ saint, location, latitude, longitude }];
    });

    timelinePoints.forEach(({ saint, location, latitude, longitude }) => {
        const popupContent = document.createElement("div");
        popupContent.className = "saint-popup";
        const popupTitle = document.createElement("strong");
        popupTitle.textContent = saint.name;
        popupContent.append(popupTitle);
        const popupPlace = document.createElement("span");
        popupPlace.textContent = location.location_name;
        popupContent.append(popupPlace);

        const popup = new Popup({ offset: 18 }).setDOMContent(popupContent);
        const markerElement = document.createElement("button");
        markerElement.type = "button";
        markerElement.className = "saint-map-marker";
        markerElement.setAttribute("aria-label", `Selecionar ${saint.name}`);
        const markerLabel = document.createElement("span");
        markerLabel.textContent = saint.name
          .replace(/^(São|Santa|Santo)\s+/i, "")
          .split(" ")
          .slice(0, 2)
          .map((word) => word[0])
          .join("")
          .toUpperCase();
        markerElement.append(markerLabel);
        markerElement.addEventListener("click", () => onSelectSaint?.(saint.id));

        const marker = new Marker({ element: markerElement, anchor: "bottom" })
          .setLngLat([longitude, latitude])
          .setPopup(popup)
          .addTo(map);

        markersRef.current.push(marker);
        const saintMarkers = markersBySaintRef.current.get(saint.id) ?? [];
        saintMarkers.push(marker);
        markersBySaintRef.current.set(saint.id, saintMarkers);
      });

    if (timelinePoints.length === 0) {
      refitMapRef.current = null;
      return;
    }

    const coordinates: MapCoordinate[] = timelinePoints.map(
      ({ longitude, latitude }) => [longitude, latitude],
    );
    const refitSaints = (duration: number) =>
      fitCoordinates(map, coordinates, {
        contextOpen,
        duration,
        maxZoom: 6,
        singlePointZoom: Math.max(map.getZoom(), 5),
      });

    refitMapRef.current = refitSaints;
    refitSaints(
      window.matchMedia("(prefers-reduced-motion: reduce)").matches ? 0 : 1000,
    );
  }, [contextOpen, onSelectSaint, saints, timelineLocations]);

  useEffect(() => {
    const activeId = previewSaintId ?? selectedSaintId;

    markersBySaintRef.current.forEach((markers, saintId) => {
      markers.forEach((marker) => {
        const element = marker.getElement();
        element.classList.toggle("is-selected", saintId === selectedSaintId);
        element.classList.toggle("is-previewed", saintId === activeId);
        element.style.zIndex =
          saintId === selectedSaintId ? "20" : saintId === activeId ? "10" : "1";
      });
    });

    if (!selectedSaintId) return;
    const marker = markersBySaintRef.current.get(selectedSaintId)?.[0];
    const map = mapRef.current;
    if (!marker || !map) return;

    map.easeTo({
      center: marker.getLngLat(),
      zoom: Math.max(map.getZoom(), 5.2),
      duration: window.matchMedia("(prefers-reduced-motion: reduce)").matches ? 0 : 650,
    });
  }, [previewSaintId, selectedSaintId]);

  useEffect(() => {
    const map = mapRef.current;
    if (!map) return;

    const lineLayerId = "saint-route-line";
    const glowLayerId = "saint-route-glow";
    const sourceId = "saint-route";

    function clearRoute() {
      routeMarkersRef.current.forEach((marker) => marker.remove());
      routeMarkersRef.current = [];

      if (!mapRef.current) return;
      if (mapRef.current.getLayer(lineLayerId)) mapRef.current.removeLayer(lineLayerId);
      if (mapRef.current.getLayer(glowLayerId)) mapRef.current.removeLayer(glowLayerId);
      if (mapRef.current.getSource(sourceId)) mapRef.current.removeSource(sourceId);
    }

    const validLocations = (routeLocations ?? []).filter((location) => {
      if (location.latitude == null || location.longitude == null) {
        return false;
      }

      const latitude = Number(location.latitude);
      const longitude = Number(location.longitude);
      return (
        Number.isFinite(latitude) &&
        Number.isFinite(longitude) &&
        latitude >= -90 &&
        latitude <= 90 &&
        longitude >= -180 &&
        longitude <= 180
      );
    });

    function renderRoute() {
      clearRoute();
      if (!validLocations.length || !mapRef.current) return;

      const activeMap = mapRef.current;
      const coordinates = validLocations.map((location) => [
        Number(location.longitude),
        Number(location.latitude),
      ]);

      if (coordinates.length > 1) {
        activeMap.addSource(sourceId, {
          type: "geojson",
          data: {
            type: "Feature",
            properties: {},
            geometry: {
              type: "LineString",
              coordinates,
            },
          },
        });
        activeMap.addLayer({
          id: glowLayerId,
          type: "line",
          source: sourceId,
          paint: {
            "line-color": "#d8b876",
            "line-width": 10,
            "line-opacity": 0.16,
            "line-blur": 4,
          },
        });
        activeMap.addLayer({
          id: lineLayerId,
          type: "line",
          source: sourceId,
          paint: {
            "line-color": "#e8cf9a",
            "line-width": 3,
            "line-opacity": 0.92,
            "line-dasharray": [1.5, 1.2],
          },
        });
      }

      validLocations.forEach((location, index) => {
        const longitude = Number(location.longitude);
        const latitude = Number(location.latitude);
        const element = document.createElement("button");
        element.type = "button";
        element.className = "route-map-marker";
        element.setAttribute(
          "aria-label",
          `${index + 1}. ${location.location_name}`
        );
        const label = document.createElement("span");
        label.textContent = String(index + 1);
        element.append(label);

        const popupContent = document.createElement("div");
        popupContent.className = "saint-popup";
        const title = document.createElement("strong");
        title.textContent = location.location_name;
        popupContent.append(title);
        if (location.description) {
          const description = document.createElement("span");
          description.textContent = location.description;
          popupContent.append(description);
        }

        const marker = new Marker({ element, anchor: "bottom" })
          .setLngLat([longitude, latitude])
          .setPopup(new Popup({ offset: 16 }).setDOMContent(popupContent))
          .addTo(activeMap);
        routeMarkersRef.current.push(marker);
      });

      const refitRoute = (duration: number) =>
        fitCoordinates(activeMap, coordinates as MapCoordinate[], {
          contextOpen: true,
          duration,
          maxZoom: 7,
          singlePointZoom: 6,
        });

      refitMapRef.current = refitRoute;
      refitRoute(
        window.matchMedia("(prefers-reduced-motion: reduce)").matches ? 0 : 1050,
      );
    }

    if (map.isStyleLoaded()) {
      renderRoute();
    } else {
      map.once("load", renderRoute);
    }

    return () => {
      map.off("load", renderRoute);
      clearRoute();
    };
  }, [routeLocations]);

  return <div ref={containerRef} className="absolute inset-0" />;
}
