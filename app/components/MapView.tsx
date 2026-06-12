"use client";

import { useEffect, useMemo, useRef, useState } from "react";
import Map, {
  FullscreenControl,
  Layer,
  Marker,
  NavigationControl,
  Popup,
  ScaleControl,
  Source,
  type MapRef,
} from "react-map-gl/mapbox";
import { formatYearRange } from "@/lib/formatYear";
import type { Location } from "@/lib/types";

const MAPBOX_TOKEN = process.env.NEXT_PUBLIC_MAPBOX_TOKEN || "";

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
}: {
  locations: Location[];
  showPath?: boolean;
}) {
  const mapRef = useRef<MapRef>(null);
  const [selected, setSelected] = useState<Location | null>(null);
  const [loaded, setLoaded] = useState(false);

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

  if (!MAPBOX_TOKEN) {
    return (
      <div className="flex h-[420px] w-full items-center justify-center rounded-xl border border-[#c9b895] bg-[#fffaf0] p-6 text-center text-[#4b3a2a]">
        Configure <code className="mx-1 rounded bg-white px-1">NEXT_PUBLIC_MAPBOX_TOKEN</code>
        para exibir o mapa Mapbox.
      </div>
    );
  }

  return (
    <div className="h-[500px] w-full overflow-hidden rounded-xl border border-[#c9b895] shadow-sm">
      <Map
        ref={mapRef}
        mapboxAccessToken={MAPBOX_TOKEN}
        initialViewState={{
          latitude: 40,
          longitude: 25,
          zoom: 2.5,
        }}
        mapStyle="mapbox://styles/mapbox/light-v11"
        onClick={() => setSelected(null)}
        onLoad={() => setLoaded(true)}
        style={{ height: "100%", width: "100%" }}
      >
        <NavigationControl position="bottom-right" />
        <FullscreenControl position="bottom-right" />
        <ScaleControl position="bottom-left" unit="metric" />

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
