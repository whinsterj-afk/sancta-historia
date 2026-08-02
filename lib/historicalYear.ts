export function formatHistoricalYear(year: number) {
  if (year < 0) return `${Math.abs(year)} a.C.`;
  if (year > 0) return `${year} d.C.`;
  return "Transição a.C./d.C.";
}

export function formatHistoricalPeriod(
  startYear: number | null,
  endYear: number | null,
) {
  if (startYear === null && endYear === null) return null;
  if (startYear === null) return `até ${formatHistoricalYear(endYear!)}`;
  if (endYear === null) return `desde ${formatHistoricalYear(startYear)}`;
  if (startYear === endYear) return formatHistoricalYear(startYear);

  if (startYear < 0 && endYear < 0) {
    return `${Math.abs(startYear)}–${Math.abs(endYear)} a.C.`;
  }

  if (startYear > 0 && endYear > 0) {
    return `${startYear}–${endYear} d.C.`;
  }

  return `${formatHistoricalYear(startYear)}–${formatHistoricalYear(endYear)}`;
}

export function formatLifeSpan(
  birthYear: number | null,
  deathYear: number | null,
) {
  if (birthYear === null && deathYear === null) {
    return "datas desconhecidas";
  }
  if (birthYear === null) {
    return `data desconhecida–${formatHistoricalYear(deathYear!)}`;
  }
  if (deathYear === null) {
    return `${formatHistoricalYear(birthYear)}–data desconhecida`;
  }

  return formatHistoricalPeriod(birthYear, deathYear);
}

export function historicalYearToScale(year: number) {
  return year > 0 ? year - 1 : year;
}

export function scaleToHistoricalYear(value: number) {
  return value >= 0 ? value + 1 : value;
}
