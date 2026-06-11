"use client";

import { MapContainer, TileLayer, Marker, Popup } from "react-leaflet";
import L from "leaflet";

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

export default function MapView({
  locations,
}: {
  locations: Location[];
}) {
  return (
    <div className="h-[420px] w-full overflow-hidden rounded-xl border">
      <MapContainer
        center={[31.7683, 35.2137]}
        zoom={3}
        scrollWheelZoom={true}
        className="h-full w-full"
      >
        <TileLayer
          attribution='&copy; OpenStreetMap contributors'
          url="https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png"
        />

        {locations.map((location) => (
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
              {location.start_year} - {location.end_year}
              <br />
              {location.description}
            </Popup>
          </Marker>
        ))}
      </MapContainer>
    </div>
  );
}