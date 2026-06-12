"use client";

import { useEffect } from "react";
import {
  MapContainer,
  TileLayer,
  Marker,
  Popup,
  Polyline,
  useMap,
} from "react-leaflet";
import L from "leaflet";
import { formatYearRange } from "@/lib/formatYear";

type Location = {
  id: number;
  location_name: string;
  latitude: number | string;
  longitude: number | string;
  start_year: number;
  end_year: number;
  description: string | null;
  saints?: {
    name: string;
  } | null;
};

const defaultIcon = L.icon({
  iconRetinaUrl:
    "https://unpkg.com/leaflet@1.9.4/dist/images/marker-icon-2x.png",
  iconUrl:
    "https://unpkg.com/leaflet@1.9.4/dist/images/marker-icon.png",
  shadowUrl:
    "https://unpkg.com/leaflet@1.9.4/dist/images/marker-shadow.png",
  iconSize: [25, 41],
  iconAnchor: [12, 41],
  popupAnchor: [1, -34],
  shadowSize: [41, 41],
});

function getValidLocations(locations: Location[]) {
  return locations.filter((location) => {
    const lat = Number(location.latitude);
    const lng = Number(location.longitude);

    return Number.isFinite(lat) && Number.isFinite(lng);
  });
}

function FitMapToLocations({
  locations,
}: {
  locations: Location[];
}) {
  const map = useMap();

  useEffect(() => {
    const validLocations = getValidLocations(locations);

    if (validLocations.length === 0) {
      map.setView([20, 0], 2);
      return;
    }

    if (validLocations.length === 1) {
      const location = validLocations[0];

      map.setView(
        [Number(location.latitude), Number(location.longitude)],
        6
      );

      return;
    }

    const bounds = L.latLngBounds(
      validLocations.map((location) => [
        Number(location.latitude),
        Number(location.longitude),
      ])
    );

    map.fitBounds(bounds, {
      padding: [50, 50],
      maxZoom: 7,
    });
  }, [locations, map]);

  return null;
}

export default function MapView({
  locations,
  showPath = false,
}: {
  locations: Location[];
  showPath?: boolean;
}) {
  const validLocations = getValidLocations(locations);

  const pathLocations = [...validLocations].sort((a, b) => {
    return a.start_year - b.start_year;
  });

  const pathPositions = pathLocations.map((location) => [
    Number(location.latitude),
    Number(location.longitude),
  ]) as [number, number][];

  return (
    <div className="h-[420px] w-full overflow-hidden rounded-xl border">
      <MapContainer
        center={[20, 0]}
        zoom={2}
        scrollWheelZoom={true}
        className="h-full w-full"
      >
        <FitMapToLocations locations={validLocations} />

        <TileLayer
          attribution='&copy; OpenStreetMap contributors'
          url="https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png"
        />

        {showPath && pathPositions.length > 1 && (
          <Polyline
            positions={pathPositions}
            pathOptions={{
              weight: 4,
              opacity: 0.75,
            }}
          />
        )}

        {validLocations.map((location) => (
          <Marker
            key={location.id}
            icon={defaultIcon}
            position={[
              Number(location.latitude),
              Number(location.longitude),
            ]}
          >
            <Popup>
              <strong>{location.location_name}</strong>
              <br />
              {location.saints?.name}
              <br />
              {formatYearRange(location.start_year, location.end_year)}
              <br />
              {location.description}
            </Popup>
          </Marker>
        ))}
      </MapContainer>
    </div>
  );
}