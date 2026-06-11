"use client";

import dynamic from "next/dynamic";

const MapView = dynamic(() => import("./MapView"), {
  ssr: false,
});

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

export default function SaintLocationsMap({
  locations,
}: {
  locations: Location[];
}) {
  if (!locations.length) {
    return (
      <div className="bg-[#fffaf0] border border-[#c9b895] rounded-2xl p-6 shadow-sm">
        <h2 className="text-2xl font-bold mb-4 text-[#2b1b10]">
          Mapa da vida do santo
        </h2>

        <p className="text-[#4b3a2a]">
          Nenhum local cadastrado para exibição no mapa.
        </p>
      </div>
    );
  }

  return (
    <div className="bg-[#fffaf0] border border-[#c9b895] rounded-2xl p-6 shadow-sm">
      <h2 className="text-2xl font-bold mb-4 text-[#2b1b10]">
        Mapa da vida do santo
      </h2>

      <p className="text-sm text-[#4b3a2a] mb-4">
        Lugares historicamente associados à vida, missão, atuação ou morte deste santo.
      </p>

      <MapView locations={locations} />
    </div>
  );
}