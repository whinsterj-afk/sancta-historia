export function formatYear(
  year: number | null | undefined,
  note?: string | null
) {
  if (note && note.trim() !== "") {
    return note;
  }

  if (year === null || year === undefined) {
    return "Não confirmado";
  }

  if (year < 0) {
    return `${Math.abs(year)} a.C.`;
  }

  return `${year} d.C.`;
}

export function formatYearRange(
  startYear: number | null | undefined,
  endYear: number | null | undefined,
  startNote?: string | null,
  endNote?: string | null
) {
  return `${formatYear(startYear, startNote)} — ${formatYear(
    endYear,
    endNote
  )}`;
}

export function formatYearShort(
  year: number | null | undefined,
  note?: string | null
) {
  if (year === null || year === undefined) {
    return "Não confirmado";
  }

  const isApproximate = note && note.trim() !== "";
  const prefix = isApproximate ? "c. " : "";

  if (year < 0) {
    return `${prefix}${Math.abs(year)} a.C.`;
  }

  return `${prefix}${year} d.C.`;
}

export function formatYearRangeShort(
  startYear: number | null | undefined,
  endYear: number | null | undefined,
  startNote?: string | null,
  endNote?: string | null
) {
  return `${formatYearShort(startYear, startNote)} — ${formatYearShort(
    endYear,
    endNote
  )}`;
}