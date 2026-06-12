import TimelineExplorer from "@/app/components/TimelineExplorer";
import {
  DEFAULT_YEAR,
  MAX_YEAR,
  MIN_YEAR,
  SIGNIFICANT_YEARS,
  getSiteStats,
  getTimelineData,
  parseTimelineMapMode,
  parseYear,
} from "@/lib/data";

export default async function Home({
  searchParams,
}: {
  searchParams: Promise<{
    year?: string;
    mode?: string;
  }>;
}) {
  const params = await searchParams;
  const year = parseYear(params.year || String(DEFAULT_YEAR));
  const mapMode = parseTimelineMapMode(params.mode);

  const [stats, timeline] = await Promise.all([
    getSiteStats(),
    getTimelineData(year, mapMode),
  ]);

  return (
    <TimelineExplorer
      key={`${year}-${mapMode}`}
      year={year}
      minYear={MIN_YEAR}
      maxYear={MAX_YEAR}
      significantYears={SIGNIFICANT_YEARS}
      mapMode={mapMode}
      stats={stats}
      saints={timeline.saints}
      popes={timeline.popes}
      events={timeline.events}
      locations={timeline.locations}
    />
  );
}
