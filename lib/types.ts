export type YearValue = number | null | undefined;

export type SaintReference = {
  id: number;
  name: string;
};

export type Saint = {
  id: number;
  name: string;
  birth_year: number | null;
  death_year: number | null;
  birth_year_note?: string | null;
  death_year_note?: string | null;
  birth_place?: string | null;
  death_place?: string | null;
  short_description?: string | null;
  biography?: string | null;
  feast_day?: string | null;
  canonization_year?: number | null;
  canonization_note?: string | null;
  patron_of?: string | null;
  image_url?: string | null;
  religious_order?: string | null;
  category?: string | null;
  famous_quote?: string | null;
  historical_importance?: string | null;
  sources?: string | null;
};

export type Pope = {
  id: number;
  name: string;
  start_year: number | null;
  end_year: number | null;
  nationality?: string | null;
  description?: string | null;
};

export type HistoricalEvent = {
  id: number;
  title: string;
  year: number | null;
  category?: string | null;
  description?: string | null;
};

export type Location = {
  id: number;
  saint_id?: number | null;
  location_name: string;
  latitude: number | string | null;
  longitude: number | string | null;
  start_year: number | null;
  end_year: number | null;
  description?: string | null;
  saints?: SaintReference | null;
};

export type TimelineMapMode = "year" | "journey";

export type TimelineData = {
  saints: Saint[];
  popes: Pope[];
  events: HistoricalEvent[];
  locations: Location[];
};

export type SiteStats = {
  saints: number;
  popes: number;
  events: number;
  locations: number;
};
