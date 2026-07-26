export function normalizeSearchTerm(value: string) {
  return value
    .normalize("NFD")
    .replace(/\p{Diacritic}/gu, "")
    .toLocaleLowerCase("pt-BR")
    .replace(/[^\p{Letter}\p{Number}]+/gu, " ")
    .trim();
}
