"use client";

import { useEffect, useRef } from "react";
import {
  LngLatBounds,
  Map,
  Marker,
  NavigationControl,
  Popup,
  setWorkerUrl,
} from "maplibre-gl";
import "maplibre-gl/dist/maplibre-gl.css";

// maplibre-gl resolves its worker script relative to import.meta.url, which
// Turbopack doesn't preserve. Point it at the static copy in public/ instead.
setWorkerUrl("/maplibre-gl-worker.mjs");

export interface SaintLocation {
  id: number;
  name: string;
  birth_place: string | null;
  birth_lat: number | null;
  birth_lng: number | null;
}

export default function SaintsMap({ saints }: { saints: SaintLocation[] }) {
  const containerRef = useRef<HTMLDivElement>(null);
  const mapRef = useRef<Map | null>(null);
  const markersRef = useRef<Marker[]>([]);

  useEffect(() => {
    if (!containerRef.current || mapRef.current) return;

    mapRef.current = new Map({
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
    const map = mapRef.current;
    if (!map) return;

    markersRef.current.forEach((marker) => marker.remove());
    markersRef.current = [];

    const locatedSaints = saints.flatMap((saint) => {
      const latitude = Number(saint.birth_lat);
      const longitude = Number(saint.birth_lng);

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

      return [{ saint, latitude, longitude }];
    });

    locatedSaints.forEach(({ saint, latitude, longitude }) => {
        const popup = new Popup({ offset: 16 }).setHTML(
          `<strong>${saint.name}</strong>${saint.birth_place ? `<br/>${saint.birth_place}` : ""}`
        );

        const marker = new Marker({ color: "#e8cf9a" })
          .setLngLat([longitude, latitude])
          .setPopup(popup)
          .addTo(map);

        markersRef.current.push(marker);
      });

    if (locatedSaints.length === 0) return;

    const reduceMotion = window.matchMedia("(prefers-reduced-motion: reduce)").matches;
    const compact = window.innerWidth <= 720;
    const { width, height } = map.getContainer().getBoundingClientRect();
    const maxHorizontalPadding = Math.max(24, (width - 160) / 2);
    const maxVerticalPadding = Math.max(24, (height - 160) / 2);
    const padding = compact
      ? {
          top: Math.min(110, maxVerticalPadding * 0.45),
          right: Math.min(48, maxHorizontalPadding),
          bottom: Math.min(190, maxVerticalPadding),
          left: Math.min(48, maxHorizontalPadding),
        }
      : {
          top: Math.min(150, maxVerticalPadding * 0.75),
          right: Math.min(380, width * 0.24, maxHorizontalPadding),
          bottom: Math.min(170, maxVerticalPadding),
          left: Math.min(380, width * 0.24, maxHorizontalPadding),
        };

    if (locatedSaints.length === 1) {
      const { latitude, longitude } = locatedSaints[0];
      map.easeTo({
        center: [longitude, latitude],
        zoom: Math.max(map.getZoom(), 5),
        padding,
        duration: reduceMotion ? 0 : 900,
      });
      return;
    }

    const bounds = new LngLatBounds();
    locatedSaints.forEach(({ latitude, longitude }) => {
      bounds.extend([longitude, latitude]);
    });

    const camera = map.cameraForBounds(bounds, {
      padding,
      maxZoom: 6,
    });

    if (!camera) return;

    map.easeTo({
      ...camera,
      padding,
      duration: reduceMotion ? 0 : 1000,
    });
  }, [saints]);

  return <div ref={containerRef} className="absolute inset-0" />;
}
