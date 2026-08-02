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
import { supabase } from "@/lib/supabase";
import type { RouteLocation } from "./MapContextPanel";

// maplibre-gl resolves its worker script relative to import.meta.url, which
// Turbopack doesn't preserve. Point it at the static copy in public/ instead.
setWorkerUrl("/maplibre-gl-worker.mjs");

type CompletePadding = Required<PaddingOptions>;
type MapCoordinate = [number, number];

const MAP_GUTTER = 24;
const MIN_VISIBLE_MAP_WIDTH = 200;
const MIN_VISIBLE_MAP_HEIGHT = 180;
const LANDMARK_OFFSETS: MapCoordinate[] = [
  [0, -13],
  [12, 7],
  [-12, 7],
];

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

export interface MapFocusTarget {
  id: number;
  latitude: number;
  longitude: number;
}

export type MapLandmarkKind =
  | "important_city"
  | "episcopal_see"
  | "pilgrimage_site";

export interface MapLandmark {
  id: number;
  title: string;
  description: string | null;
  kind: MapLandmarkKind;
  location_name: string;
  latitude: number;
  longitude: number;
  start_year: number | null;
  end_year: number | null;
}

type EcclesiasticalMarkerTier =
  | "holy-see"
  | "metropolitan"
  | "diocese"
  | "parish";

interface EcclesiasticalMapPoint {
  id: number;
  name: string;
  site_type: string;
  canonical_type: string;
  jurisdiction_name: string;
  latitude: number;
  longitude: number;
  address: string | null;
  locality: string | null;
  country_code: string;
  official_url: string | null;
  min_zoom: number;
}

const CANONICAL_TYPE_LABELS: Record<string, string> = {
  holy_see: "Santa Sé",
  metropolitan_archdiocese: "Arquidiocese metropolitana",
  archdiocese: "Arquidiocese",
  metropolitan_archeparchy: "Arquieparquia metropolitana",
  archeparchy: "Arquieparquia",
  diocese: "Diocese",
  eparchy: "Eparquia",
  territorial_prelature: "Prelazia territorial",
  territorial_abbey: "Abadia territorial",
  apostolic_vicariate: "Vicariato apostólico",
  apostolic_prefecture: "Prefeitura apostólica",
  apostolic_administration: "Administração apostólica",
  exarchate: "Exarcado",
  ordinariate: "Ordinariado",
  military_ordinariate: "Ordinariado militar",
  parish: "Paróquia",
  quasi_parish: "Quase-paróquia",
};

function ecclesiasticalMarkerTier(
  point: EcclesiasticalMapPoint,
): EcclesiasticalMarkerTier {
  if (point.canonical_type === "holy_see") return "holy-see";
  if (
    point.canonical_type === "metropolitan_archdiocese" ||
    point.canonical_type === "metropolitan_archeparchy" ||
    point.canonical_type === "patriarchate" ||
    point.canonical_type === "major_archiepiscopal_church"
  ) {
    return "metropolitan";
  }
  if (
    point.canonical_type === "parish" ||
    point.canonical_type === "quasi_parish" ||
    point.site_type === "parish_church" ||
    point.site_type === "chapel" ||
    point.site_type === "mission_station" ||
    point.site_type === "shrine"
  ) {
    return "parish";
  }
  return "diocese";
}

// Falhas de rede chegam como Error, cujos name e message não são
// enumeráveis: console.error as imprime como "{}" e esconde a causa real —
// projeto pausado, offline ou consulta cancelada. Erros do PostgREST, ao
// contrário, são objetos comuns com message/code/details/hint.
function describeQueryError(error: unknown): string {
  if (error instanceof Error) {
    return `${error.name}: ${error.message}`;
  }
  if (error && typeof error === "object") {
    const { message, code, details, hint } = error as Record<string, unknown>;
    const parts = [message, code, details, hint].filter(Boolean);
    if (parts.length > 0) return parts.join(" · ");
  }
  return String(error);
}

export default function SaintsMap({
  saints,
  landmarks = [],
  selectedYear,
  selectedSaintId,
  previewSaintId,
  onSelectSaint,
  timelineLocations,
  routeLocations,
  contextOpen,
  focusTarget,
}: {
  saints: SaintLocation[];
  landmarks?: MapLandmark[];
  selectedYear: number;
  selectedSaintId?: number | null;
  previewSaintId?: number | null;
  onSelectSaint?: (saintId: number) => void;
  timelineLocations?: RouteLocation[];
  routeLocations?: RouteLocation[];
  contextOpen: boolean;
  focusTarget?: MapFocusTarget | null;
}) {
  const containerRef = useRef<HTMLDivElement>(null);
  const mapRef = useRef<MapLibreMap | null>(null);
  const markersRef = useRef<Marker[]>([]);
  const markersBySaintRef = useRef<Map<number, Marker[]>>(new Map());
  const landmarkMarkersRef = useRef<Marker[]>([]);
  const ecclesiasticalMarkersRef = useRef<Marker[]>([]);
  const routeMarkersRef = useRef<Marker[]>([]);
  const refitMapRef = useRef<((duration: number) => void) | null>(null);

  useEffect(() => {
    if (!containerRef.current || mapRef.current) return;

    mapRef.current = new MapLibreMap({
      container: containerRef.current,
      style: `https://api.maptiler.com/maps/019f9748-fef8-71cf-a038-d6a0583942fc/style.json?key=${process.env.NEXT_PUBLIC_MAPTILER_KEY}`,
      center: [15, 40],
      zoom: 2.5,
      renderWorldCopies: false,
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
    if (focusTarget) return;
    refitSaints(
      window.matchMedia("(prefers-reduced-motion: reduce)").matches ? 0 : 1000,
    );
  }, [contextOpen, focusTarget, onSelectSaint, saints, timelineLocations]);

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
    if (!map || !focusTarget) return;

    const latitude = Number(focusTarget.latitude);
    const longitude = Number(focusTarget.longitude);
    if (
      !Number.isFinite(latitude) ||
      !Number.isFinite(longitude) ||
      latitude < -90 ||
      latitude > 90 ||
      longitude < -180 ||
      longitude > 180
    ) {
      return;
    }

    const focus = () => {
      map.easeTo({
        center: [longitude, latitude],
        zoom: Math.max(map.getZoom(), 11.2),
        duration: window.matchMedia("(prefers-reduced-motion: reduce)").matches
          ? 0
          : 800,
      });
    };

    if (map.isStyleLoaded()) {
      focus();
    } else {
      map.once("load", focus);
    }

    return () => {
      map.off("load", focus);
    };
  }, [focusTarget]);

  useEffect(() => {
    const map = mapRef.current;
    if (!map) return;

    landmarkMarkersRef.current.forEach((marker) => marker.remove());
    landmarkMarkersRef.current = [];

    const landmarkCounts = new Map<string, number>();
    landmarks.forEach((landmark) => {
      const key = `${landmark.longitude}:${landmark.latitude}`;
      landmarkCounts.set(key, (landmarkCounts.get(key) ?? 0) + 1);
    });
    const landmarkIndexes = new Map<string, number>();

    landmarks.forEach((landmark) => {
      const latitude = Number(landmark.latitude);
      const longitude = Number(landmark.longitude);
      if (
        !Number.isFinite(latitude) ||
        !Number.isFinite(longitude) ||
        latitude < -90 ||
        latitude > 90 ||
        longitude < -180 ||
        longitude > 180
      ) {
        return;
      }

      const markerElement = document.createElement("button");
      markerElement.type = "button";
      markerElement.className = `landmark-map-marker landmark-map-marker--${landmark.kind.replaceAll("_", "-")}`;
      markerElement.setAttribute(
        "aria-label",
        `${landmark.title}, ${landmark.location_name}`,
      );
      const markerFrame = document.createElement("span");
      markerFrame.className = "landmark-marker-frame";
      const markerSymbol = document.createElement("span");
      markerSymbol.className = `landmark-symbol landmark-symbol--${landmark.kind.replaceAll("_", "-")}`;
      markerSymbol.setAttribute("aria-hidden", "true");
      markerFrame.append(markerSymbol);
      markerElement.append(markerFrame);

      const popupContent = document.createElement("div");
      popupContent.className = "saint-popup landmark-popup";
      const popupTitle = document.createElement("strong");
      popupTitle.textContent = landmark.title;
      popupContent.append(popupTitle);
      const popupPlace = document.createElement("span");
      popupPlace.textContent = landmark.location_name;
      popupContent.append(popupPlace);
      if (landmark.description) {
        const popupDescription = document.createElement("p");
        popupDescription.textContent = landmark.description;
        popupContent.append(popupDescription);
      }

      const coordinateKey = `${landmark.longitude}:${landmark.latitude}`;
      const coordinateIndex = landmarkIndexes.get(coordinateKey) ?? 0;
      landmarkIndexes.set(coordinateKey, coordinateIndex + 1);
      const offset =
        (landmarkCounts.get(coordinateKey) ?? 0) > 1
          ? LANDMARK_OFFSETS[coordinateIndex % LANDMARK_OFFSETS.length]
          : ([0, 0] as MapCoordinate);

      const marker = new Marker({
        element: markerElement,
        anchor: "center",
        offset,
      })
        .setLngLat([longitude, latitude])
        .setPopup(new Popup({ offset: 16 }).setDOMContent(popupContent))
        .addTo(map);
      landmarkMarkersRef.current.push(marker);
    });

    return () => {
      landmarkMarkersRef.current.forEach((marker) => marker.remove());
      landmarkMarkersRef.current = [];
    };
  }, [landmarks]);

  useEffect(() => {
    const map = mapRef.current;
    if (!map) return;

    let disposed = false;
    let latestRequest = 0;
    // Sem isto, uma consulta em voo sobrevive à troca de ano ou ao recarregar
    // e só falha depois, sem ninguém para tratá-la.
    const inFlight = new AbortController();

    function clearEcclesiasticalMarkers() {
      ecclesiasticalMarkersRef.current.forEach((marker) => marker.remove());
      ecclesiasticalMarkersRef.current = [];
    }

    async function loadEcclesiasticalPoints() {
      if (!mapRef.current || contextOpen) {
        clearEcclesiasticalMarkers();
        return;
      }

      const activeMap = mapRef.current;
      const bounds = activeMap.getBounds();
      const requestId = ++latestRequest;
      const { data, error } = await supabase
        .rpc("ecclesiastical_points_in_view", {
          min_long: Math.max(-180, bounds.getWest()),
          min_lat: Math.max(-90, bounds.getSouth()),
          max_long: Math.min(180, bounds.getEast()),
          max_lat: Math.min(90, bounds.getNorth()),
          map_zoom: activeMap.getZoom(),
          selected_year: selectedYear,
        })
        .abortSignal(inFlight.signal);

      if (disposed || requestId !== latestRequest) return;
      if (error) {
        // Cancelar a consulta é o comportamento esperado, não uma falha.
        if (inFlight.signal.aborted) return;
        console.error(
          "Falha ao carregar a estrutura eclesiástica:",
          describeQueryError(error),
        );
        return;
      }

      clearEcclesiasticalMarkers();
      ((data ?? []) as EcclesiasticalMapPoint[]).forEach((point) => {
        const latitude = Number(point.latitude);
        const longitude = Number(point.longitude);
        if (
          !Number.isFinite(latitude) ||
          !Number.isFinite(longitude) ||
          latitude < -90 ||
          latitude > 90 ||
          longitude < -180 ||
          longitude > 180
        ) {
          return;
        }

        const tier = ecclesiasticalMarkerTier(point);
        const element = document.createElement("button");
        element.type = "button";
        element.className =
          `church-structure-map-marker church-structure-map-marker--${tier}`;
        element.setAttribute(
          "aria-label",
          `${CANONICAL_TYPE_LABELS[point.canonical_type] ?? "Estrutura eclesiástica"}: ${point.name}`,
        );
        const frame = document.createElement("span");
        frame.className = "church-structure-marker-frame";
        const symbol = document.createElement("span");
        symbol.className = "church-structure-marker-symbol";
        symbol.setAttribute("aria-hidden", "true");
        frame.append(symbol);
        element.append(frame);

        const popupContent = document.createElement("div");
        popupContent.className = "saint-popup church-structure-popup";
        const title = document.createElement("strong");
        title.textContent = point.name;
        popupContent.append(title);
        const canonicalType = document.createElement("span");
        canonicalType.textContent =
          CANONICAL_TYPE_LABELS[point.canonical_type] ??
          point.jurisdiction_name;
        popupContent.append(canonicalType);
        if (point.address || point.locality) {
          const place = document.createElement("span");
          place.textContent = [point.address, point.locality]
            .filter(Boolean)
            .join(" — ");
          popupContent.append(place);
        }
        if (point.official_url) {
          const source = document.createElement("a");
          source.href = point.official_url;
          source.target = "_blank";
          source.rel = "noreferrer";
          source.textContent = "Fonte oficial";
          popupContent.append(source);
        }

        const marker = new Marker({ element, anchor: "center" })
          .setLngLat([longitude, latitude])
          .setPopup(new Popup({ offset: 14 }).setDOMContent(popupContent))
          .addTo(activeMap);
        ecclesiasticalMarkersRef.current.push(marker);
      });
    }

    function startLoading() {
      void loadEcclesiasticalPoints();
    }

    if (map.isStyleLoaded()) {
      startLoading();
    } else {
      map.once("load", startLoading);
    }
    map.on("moveend", startLoading);

    return () => {
      disposed = true;
      inFlight.abort();
      map.off("load", startLoading);
      map.off("moveend", startLoading);
      clearEcclesiasticalMarkers();
    };
  }, [contextOpen, selectedYear]);

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
            "line-color": "#03131d",
            "line-width": 9,
            "line-opacity": 0.88,
            "line-blur": 1,
          },
        });
        activeMap.addLayer({
          id: lineLayerId,
          type: "line",
          source: sourceId,
          paint: {
            "line-color": "#5cecff",
            "line-width": 4,
            "line-opacity": 1,
            "line-dasharray": [2, 1.2],
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
