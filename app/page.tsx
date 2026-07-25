"use client";

import { useEffect, useState } from "react";
import { supabase } from "@/lib/supabase";
import SaintsMap, { SaintLocation } from "@/components/SaintsMap";
import TopBar from "@/components/TopBar";
import Timeline from "@/components/Timeline";
import FactsPanel, { HistoricalEvent } from "@/components/FactsPanel";
import SaintsPanel, { SaintSummary } from "@/components/SaintsPanel";
import styles from "./page.module.css";

type Saint = SaintLocation & SaintSummary;

interface Pope {
  id: number;
  name: string;
  start_year: number;
  end_year: number;
  description: string | null;
}

export default function Home() {
  const [year, setYear] = useState(1220);

  const [saints, setSaints] = useState<Saint[]>([]);
  const [popes, setPopes] = useState<Pope[]>([]);
  const [events, setEvents] = useState<HistoricalEvent[]>([]);

  useEffect(() => {
    let active = true;

    async function loadData() {
      const [{ data: saintsData }, { data: popeData }, { data: eventData }] =
        await Promise.all([
          supabase
            .from("saints")
            .select("*")
            .lte("birth_year", year)
            .gte("death_year", year)
            .order("birth_year"),
          supabase
            .from("popes")
            .select("*")
            .lte("start_year", year)
            .gte("end_year", year),
          supabase
            .from("historical_events")
            .select("*")
            .lte("year", year)
            .order("year", { ascending: false })
            .limit(5),
        ]);

      if (!active) return;
      setSaints(saintsData || []);
      setPopes(popeData || []);
      setEvents(eventData || []);
    }

    void loadData();
    return () => {
      active = false;
    };
  }, [year]);

  return (
    <main className={styles.page}>
      <SaintsMap saints={saints} />
      <div className={styles.goldWash} aria-hidden="true" />

      <div className={styles.interface}>
        <TopBar />

        <div className={styles.leftPanel}>
          <FactsPanel events={events} />
        </div>

        <div className={styles.rightPanel}>
          <SaintsPanel saints={saints} />
        </div>

        <div className={styles.timelineArea}>
          <Timeline year={year} onChange={setYear} pope={popes[0] ?? null} />
        </div>
      </div>
    </main>
  );
}
