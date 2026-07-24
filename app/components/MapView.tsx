"use client";

import { useEffect, useMemo, useRef, useState } from "react";
import { setWorkerUrl } from "maplibre-gl";
import Map, {
  FullscreenControl,
  Layer,
  Marker,
  NavigationControl,
  Popup,
  ScaleControl,
  Source,
  type MapRef,
} from "react-map-gl/maplibre";
import { formatYearRange } from "@/lib/formatYear";
import type { Location } from "@/lib/types";

// Turbopack não resolve o worker que o maplibre-gl cria dinamicamente via
// Blob + import.meta.url em tempo de execução (o carregamento de tiles trava
// em silêncio). Servimos o worker CSP-safe (autocontido) via rota própria.
setWorkerUrl("/maplibre-worker/maplibre-gl-csp-worker.js");

const MAPTILER_KEY = process.env.NEXT_PUBLIC_MAPTILER_KEY || "";
const MAP_STYLE = `https://api.maptiler.com/maps/basic-v2/style.json?key=${MAPTILER_KEY}`;

function getValidLocations(locations: Location[]) {
  return locations.filter((location) => {
    const lat = Number(location.latitude);
    const lng = Number(location.longitude);

    return Number.isFinite(lat) && Number.isFinite(lng) && lat !== 0 && lng !== 0;
  });
}

export default function MapView({
  locations,
  showPath = false,
  variant = "panel",
}: {
  locations: Location[];
  showPath?: boolean;
  variant?: "panel" | "background";
}) {
  const mapRef = useRef<MapRef>(null);
  const [selected, setSelected] = useState<Location | null>(null);
  const [loaded, setLoaded] = useState(false);
  const [mapError, setMapError] = useState(false);

  const validLocations = useMemo(() => getValidLocations(locations), [locations]);

  const pathLocations = useMemo(() => {
    return [...validLocations].sort(
      (a, b) => (a.start_year || 0) - (b.start_year || 0)
    );
  }, [validLocations]);

  const pathGeoJson = useMemo(
    () => ({
      type: "FeatureCollection" as const,
      features:
        showPath && pathLocations.length > 1
          ? [
              {
                type: "Feature" as const,
                properties: {},
                geometry: {
                  type: "LineString" as const,
                  coordinates: pathLocations.map((location) => [
                    Number(location.longitude),
                    Number(location.latitude),
                  ]),
                },
              },
            ]
          : [],
    }),
    [pathLocations, showPath]
  );

  useEffect(() => {
    if (!loaded || !mapRef.current || validLocations.length === 0) {
      return;
    }

    if (validLocations.length === 1) {
      const location = validLocations[0];
      mapRef.current.flyTo({
        center: [Number(location.longitude), Number(location.latitude)],
        duration: 700,
        zoom: 6,
      });
      return;
    }

    const lngs = validLocations.map((location) => Number(location.longitude));
    const lats = validLocations.map((location) => Number(location.latitude));

    mapRef.current.fitBounds(
      [
        [Math.min(...lngs), Math.min(...lats)],
        [Math.max(...lngs), Math.max(...lats)],
      ],
      {
        duration: 700,
        maxZoom: 7,
        padding: 60,
      }
    );
  }, [loaded, validLocations]);

  if (!MAPTILER_KEY || mapError) {
    return (
      <MapFallback variant={variant} mapError={mapError} />
    );
  }

  return (
    <div
      className={
        variant === "background"
          ? "h-full w-full overflow-hidden"
          : "h-[500px] w-full overflow-hidden rounded-xl border border-[#c9b895] shadow-sm"
      }
    >
      <Map
        ref={mapRef}
        initialViewState={{
          latitude: 40,
          longitude: 25,
          zoom: 2.5,
        }}
        mapStyle={MAP_STYLE}
        onClick={() => setSelected(null)}
        onError={() => setMapError(true)}
        onLoad={() => setLoaded(true)}
        style={{ height: "100%", width: "100%" }}
      >
        {variant === "panel" && (
          <>
            <NavigationControl position="bottom-right" />
            <FullscreenControl position="bottom-right" />
            <ScaleControl position="bottom-left" unit="metric" />
          </>
        )}

        {pathGeoJson.features.length > 0 && (
          <Source id="saint-journey" type="geojson" data={pathGeoJson}>
            <Layer
              id="saint-journey-line"
              type="line"
              paint={{
                "line-color": "#8b5e24",
                "line-dasharray": [2, 1.5],
                "line-opacity": 0.82,
                "line-width": 3,
              }}
            />
          </Source>
        )}

        {validLocations.map((location) => (
          <Marker
            key={location.id}
            latitude={Number(location.latitude)}
            longitude={Number(location.longitude)}
            anchor="bottom"
            onClick={(event) => {
              event.originalEvent.stopPropagation();
              setSelected(location);
            }}
          >
            <button
              type="button"
              aria-label={location.location_name}
              className="grid h-8 w-8 place-items-center rounded-full border-2 border-[#fffaf0] bg-[#8b5e24] text-[#fffaf0] shadow-md transition hover:scale-110"
            >
              +
            </button>
          </Marker>
        ))}

        {selected && (
          <Popup
            latitude={Number(selected.latitude)}
            longitude={Number(selected.longitude)}
            anchor="top"
            closeOnClick={false}
            maxWidth="320px"
            onClose={() => setSelected(null)}
          >
            <div className="text-[#4b3a2a]">
              <strong className="block text-sm text-[#2b1b10]">
                {selected.location_name}
              </strong>
              {selected.saints?.name && (
                <span className="mt-1 block text-xs font-semibold text-[#8b5e24]">
                  {selected.saints.name}
                </span>
              )}
              <span className="mt-1 block text-xs text-[#6b543d]">
                {formatYearRange(selected.start_year, selected.end_year)}
              </span>
              {selected.description && (
                <p className="mt-2 border-t border-[#eadfcb] pt-2 text-xs leading-relaxed">
                  {selected.description}
                </p>
              )}
            </div>
          </Popup>
        )}
      </Map>
    </div>
  );
}

function MapFallback({
  mapError,
  variant,
}: {
  mapError: boolean;
  variant: "panel" | "background";
}) {
  return (
    <div
      className={`relative flex w-full items-center justify-center overflow-hidden p-6 text-center ${
        variant === "background"
          ? "h-full bg-[#d8c7aa] text-[#2d2119]"
          : "h-[420px] rounded-xl border border-[#c9b895] bg-[#fffaf0] text-[#4b3a2a]"
      }`}
    >
      <div className="absolute inset-0 opacity-55 [background-image:linear-gradient(30deg,rgba(71,55,38,.18)_12%,transparent_12.5%,transparent_87%,rgba(71,55,38,.18)_87.5%,rgba(71,55,38,.18)),linear-gradient(150deg,rgba(71,55,38,.18)_12%,transparent_12.5%,transparent_87%,rgba(71,55,38,.18)_87.5%,rgba(71,55,38,.18)),linear-gradient(30deg,rgba(71,55,38,.18)_12%,transparent_12.5%,transparent_87%,rgba(71,55,38,.18)_87.5%,rgba(71,55,38,.18)),linear-gradient(150deg,rgba(71,55,38,.18)_12%,transparent_12.5%,transparent_87%,rgba(71,55,38,.18)_87.5%,rgba(71,55,38,.18))] [background-position:0_0,0_0,34px_60px,34px_60px] [background-size:68px_120px]" />
      <div className="relative max-w-sm rounded-lg border border-[#6e5535]/20 bg-[#fffaf0]/82 p-4 shadow-[0_18px_50px_rgba(0,0,0,0.18)] backdrop-blur">
        <p className="text-sm font-semibold">
          {mapError ? "Mapa indisponivel neste dispositivo." : "Configure a chave do MapTiler."}
        </p>
        <p className="mt-2 text-xs leading-5 opacity-80">
          Verifique a chave <code>NEXT_PUBLIC_MAPTILER_KEY</code> e os
          domínios permitidos no MapTiler.
        </p>
      </div>
    </div>
  );
}
