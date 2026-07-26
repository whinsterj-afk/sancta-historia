"use client";

import { useEffect, useRef, useState } from "react";
import type { User } from "@supabase/supabase-js";
import { createSupabaseBrowserClient } from "@/lib/supabaseBrowserClient";
import { normalizeSearchTerm } from "@/lib/searchText";

interface SaintOption {
  id: number;
  name: string;
  birth_year: number;
  death_year: number;
}

interface ParishOption {
  id: number;
  name: string;
  country_code: string | null;
}

const PARISH_CANONICAL_TYPES = ["parish", "quasi_parish"];

export default function ProfileModal({
  user,
  onClose,
}: {
  user: User;
  onClose: () => void;
}) {
  const [supabase] = useState(() => createSupabaseBrowserClient());
  const fileInputRef = useRef<HTMLInputElement>(null);
  const saintFieldRef = useRef<HTMLDivElement>(null);
  const parishFieldRef = useRef<HTMLDivElement>(null);

  const [loading, setLoading] = useState(true);
  const [saving, setSaving] = useState(false);
  const [uploadingAvatar, setUploadingAvatar] = useState(false);
  const [error, setError] = useState<string | null>(null);
  const [saved, setSaved] = useState(false);

  const [displayName, setDisplayName] = useState("");
  const [city, setCity] = useState("");
  const [country, setCountry] = useState("");
  const [avatarUrl, setAvatarUrl] = useState<string | null>(null);

  const [favoriteSaintId, setFavoriteSaintId] = useState<number | null>(null);
  const [saintQuery, setSaintQuery] = useState("");
  const [saintResults, setSaintResults] = useState<SaintOption[]>([]);
  const [saintDropdownOpen, setSaintDropdownOpen] = useState(false);

  const [favoriteParishId, setFavoriteParishId] = useState<number | null>(null);
  const [parishQuery, setParishQuery] = useState("");
  const [parishResults, setParishResults] = useState<ParishOption[]>([]);
  const [parishDropdownOpen, setParishDropdownOpen] = useState(false);

  useEffect(() => {
    let active = true;

    async function loadProfile() {
      const { data, error: loadError } = await supabase
        .from("profiles")
        .select(
          "display_name, avatar_url, city, country, favorite_saint_id, favorite_parish_id",
        )
        .eq("id", user.id)
        .maybeSingle();

      if (!active) return;

      if (loadError) {
        setError("Não foi possível carregar seu perfil.");
        setLoading(false);
        return;
      }

      if (data) {
        setDisplayName(data.display_name ?? "");
        setAvatarUrl(data.avatar_url);
        setCity(data.city ?? "");
        setCountry(data.country ?? "");
        setFavoriteSaintId(data.favorite_saint_id);

        if (data.favorite_saint_id) {
          const { data: saint } = await supabase
            .from("saints_catalog")
            .select("name")
            .eq("id", data.favorite_saint_id)
            .maybeSingle();
          if (active && saint) setSaintQuery(saint.name);
        }

        setFavoriteParishId(data.favorite_parish_id);
        if (data.favorite_parish_id) {
          const { data: parish } = await supabase
            .from("ecclesiastical_jurisdictions")
            .select("name")
            .eq("id", data.favorite_parish_id)
            .maybeSingle();
          if (active && parish) setParishQuery(parish.name);
        }
      }

      setLoading(false);
    }

    void loadProfile();
    return () => {
      active = false;
    };
  }, [supabase, user.id]);

  useEffect(() => {
    if (!saintDropdownOpen) return;

    function handlePointerDown(event: MouseEvent) {
      if (!saintFieldRef.current?.contains(event.target as Node)) {
        setSaintDropdownOpen(false);
      }
    }

    document.addEventListener("mousedown", handlePointerDown);
    return () => document.removeEventListener("mousedown", handlePointerDown);
  }, [saintDropdownOpen]);

  useEffect(() => {
    if (!parishDropdownOpen) return;

    function handlePointerDown(event: MouseEvent) {
      if (!parishFieldRef.current?.contains(event.target as Node)) {
        setParishDropdownOpen(false);
      }
    }

    document.addEventListener("mousedown", handlePointerDown);
    return () => document.removeEventListener("mousedown", handlePointerDown);
  }, [parishDropdownOpen]);

  useEffect(() => {
    const term = saintQuery.trim();
    if (!saintDropdownOpen || term.length < 2) {
      return;
    }

    let active = true;
    const timer = window.setTimeout(async () => {
      const normalized = normalizeSearchTerm(term);
      const { data } = await supabase
        .from("saint_search_catalog")
        .select("id,name,birth_year,death_year")
        .ilike("search_text", `%${normalized}%`)
        .order("name")
        .limit(6);

      if (active) setSaintResults(data ?? []);
    }, 250);

    return () => {
      active = false;
      window.clearTimeout(timer);
    };
  }, [saintQuery, saintDropdownOpen, supabase]);

  useEffect(() => {
    const term = parishQuery.trim();
    if (!parishDropdownOpen || term.length < 2) {
      return;
    }

    let active = true;
    const timer = window.setTimeout(async () => {
      const { data } = await supabase
        .from("ecclesiastical_jurisdictions")
        .select("id,name,country_code")
        .in("canonical_type", PARISH_CANONICAL_TYPES)
        .ilike("name", `%${term}%`)
        .order("name")
        .limit(6);

      if (active) setParishResults(data ?? []);
    }, 250);

    return () => {
      active = false;
      window.clearTimeout(timer);
    };
  }, [parishQuery, parishDropdownOpen, supabase]);

  async function handleAvatarChange(event: React.ChangeEvent<HTMLInputElement>) {
    const file = event.target.files?.[0];
    event.target.value = "";
    if (!file) return;

    setUploadingAvatar(true);
    setError(null);

    const extension = file.name.split(".").pop() || "jpg";
    const path = `${user.id}/avatar.${extension}`;

    const { error: uploadError } = await supabase.storage
      .from("avatars")
      .upload(path, file, { upsert: true, cacheControl: "3600" });

    if (uploadError) {
      setError("Não foi possível enviar a foto.");
      setUploadingAvatar(false);
      return;
    }

    const { data } = supabase.storage.from("avatars").getPublicUrl(path);
    setAvatarUrl(`${data.publicUrl}?t=${Date.now()}`);
    setUploadingAvatar(false);
  }

  async function handleSave() {
    setSaving(true);
    setError(null);
    setSaved(false);

    const { error: saveError } = await supabase.from("profiles").upsert({
      id: user.id,
      display_name: displayName.trim() || null,
      avatar_url: avatarUrl,
      city: city.trim() || null,
      country: country.trim() || null,
      favorite_saint_id: favoriteSaintId,
      favorite_parish_id: favoriteParishId,
    });

    setSaving(false);

    if (saveError) {
      setError("Não foi possível salvar o perfil.");
      return;
    }

    setSaved(true);
  }

  async function handleSignOut() {
    await supabase.auth.signOut();
    onClose();
  }

  return (
    <div
      className="pointer-events-auto fixed inset-0 z-50 flex items-center justify-center bg-black/60 p-4"
      onClick={onClose}
    >
      <div
        className="panel-glass thin-scroll border rounded-xl max-w-md w-full max-h-[85vh] overflow-y-auto p-6"
        onClick={(event) => event.stopPropagation()}
      >
        <h2 className="font-display text-lg tracking-[0.1em] text-gold-200 mb-4">
          MEU PERFIL
        </h2>

        {loading ? (
          <p className="text-sm text-parchment-dim">Carregando…</p>
        ) : (
          <div className="flex flex-col gap-4">
            <div className="flex items-center gap-4">
              <button
                type="button"
                onClick={() => fileInputRef.current?.click()}
                className="saint-avatar flex h-16 w-16 shrink-0 items-center justify-center overflow-hidden rounded-full border-2 border-gold-500/60 bg-ink-800 text-gold-300"
                aria-label="Alterar foto de perfil"
              >
                {avatarUrl ? (
                  // eslint-disable-next-line @next/next/no-img-element
                  <img
                    src={avatarUrl}
                    alt=""
                    className="h-full w-full object-cover"
                  />
                ) : (
                  <span className="text-xs">
                    {uploadingAvatar ? "…" : "Foto"}
                  </span>
                )}
              </button>
              <input
                ref={fileInputRef}
                type="file"
                accept="image/*"
                className="hidden"
                onChange={handleAvatarChange}
              />
              <p className="text-xs text-parchment-dim">
                Clique na foto para trocar.
              </p>
            </div>

            <label className="flex flex-col gap-1 text-xs text-gold-400">
              Nome
              <input
                value={displayName}
                onChange={(event) => setDisplayName(event.target.value)}
                className="rounded-md border border-gold-500/30 bg-ink-900 px-3 py-2 text-sm text-parchment outline-none focus:border-gold-300"
              />
            </label>

            <div className="grid grid-cols-2 gap-3">
              <label className="flex flex-col gap-1 text-xs text-gold-400">
                Cidade
                <input
                  value={city}
                  onChange={(event) => setCity(event.target.value)}
                  className="rounded-md border border-gold-500/30 bg-ink-900 px-3 py-2 text-sm text-parchment outline-none focus:border-gold-300"
                />
              </label>
              <label className="flex flex-col gap-1 text-xs text-gold-400">
                País
                <input
                  value={country}
                  onChange={(event) => setCountry(event.target.value)}
                  className="rounded-md border border-gold-500/30 bg-ink-900 px-3 py-2 text-sm text-parchment outline-none focus:border-gold-300"
                />
              </label>
            </div>

            <div ref={saintFieldRef} className="relative flex flex-col gap-1 text-xs text-gold-400">
              Santo de devoção
              <input
                value={saintQuery}
                onFocus={() => setSaintDropdownOpen(true)}
                onChange={(event) => {
                  const value = event.target.value;
                  setSaintQuery(value);
                  setSaintDropdownOpen(true);
                  if (value.trim().length < 2) setSaintResults([]);
                }}
                placeholder="Buscar um santo…"
                className="rounded-md border border-gold-500/30 bg-ink-900 px-3 py-2 text-sm text-parchment outline-none focus:border-gold-300"
              />
              {saintDropdownOpen && saintResults.length > 0 && (
                <div
                  className="search-results"
                  style={{ position: "absolute", top: "100%", left: 0, right: 0, width: "auto" }}
                >
                  {saintResults.map((saint) => (
                    <button
                      key={saint.id}
                      type="button"
                      className="search-result"
                      onClick={() => {
                        setFavoriteSaintId(saint.id);
                        setSaintQuery(saint.name);
                        setSaintDropdownOpen(false);
                      }}
                    >
                      <span className="search-result-type">Santo</span>
                      <span className="search-result-copy">
                        <strong>{saint.name}</strong>
                        <small>
                          {saint.birth_year}–{saint.death_year}
                        </small>
                      </span>
                    </button>
                  ))}
                </div>
              )}
              {favoriteSaintId && (
                <button
                  type="button"
                  onClick={() => {
                    setFavoriteSaintId(null);
                    setSaintQuery("");
                  }}
                  className="self-start text-[11px] text-parchment-dim underline hover:text-gold-300"
                >
                  Remover santo de devoção
                </button>
              )}
            </div>

            <div ref={parishFieldRef} className="relative flex flex-col gap-1 text-xs text-gold-400">
              Paróquia
              <input
                value={parishQuery}
                onFocus={() => setParishDropdownOpen(true)}
                onChange={(event) => {
                  const value = event.target.value;
                  setParishQuery(value);
                  setParishDropdownOpen(true);
                  if (value.trim().length < 2) setParishResults([]);
                }}
                placeholder="Buscar uma paróquia…"
                className="rounded-md border border-gold-500/30 bg-ink-900 px-3 py-2 text-sm text-parchment outline-none focus:border-gold-300"
              />
              {parishDropdownOpen && parishQuery.trim().length >= 2 && (
                <div
                  className="search-results"
                  style={{ position: "absolute", top: "100%", left: 0, right: 0, width: "auto" }}
                >
                  {parishResults.length === 0 ? (
                    <p className="search-empty">
                      Nenhuma paróquia cadastrada com esse nome ainda.
                    </p>
                  ) : (
                    parishResults.map((parish) => (
                      <button
                        key={parish.id}
                        type="button"
                        className="search-result"
                        onClick={() => {
                          setFavoriteParishId(parish.id);
                          setParishQuery(parish.name);
                          setParishDropdownOpen(false);
                        }}
                      >
                        <span className="search-result-type">Paróquia</span>
                        <span className="search-result-copy">
                          <strong>{parish.name}</strong>
                          {parish.country_code && (
                            <small>{parish.country_code}</small>
                          )}
                        </span>
                      </button>
                    ))
                  )}
                </div>
              )}
              {favoriteParishId && (
                <button
                  type="button"
                  onClick={() => {
                    setFavoriteParishId(null);
                    setParishQuery("");
                  }}
                  className="self-start text-[11px] text-parchment-dim underline hover:text-gold-300"
                >
                  Remover paróquia
                </button>
              )}
            </div>

            {error && (
              <p className="text-sm text-[#ffd9ca]" role="alert">
                {error}
              </p>
            )}
            {saved && !error && (
              <p className="text-sm text-gold-300">Perfil salvo.</p>
            )}

            <div className="mt-2 flex items-center justify-between">
              <button
                type="button"
                onClick={handleSignOut}
                className="text-xs text-parchment-dim underline hover:text-gold-300"
              >
                Sair
              </button>
              <div className="flex gap-2">
                <button
                  type="button"
                  onClick={onClose}
                  className="rounded-full border border-gold-500/40 px-4 py-2 text-xs tracking-[0.15em] text-gold-300 hover:bg-gold-500/10 transition"
                >
                  FECHAR
                </button>
                <button
                  type="button"
                  onClick={handleSave}
                  disabled={saving}
                  className="rounded-full border border-gold-500 bg-gold-500 px-4 py-2 text-xs tracking-[0.15em] text-ink-950 transition disabled:opacity-60"
                >
                  {saving ? "Salvando…" : "SALVAR"}
                </button>
              </div>
            </div>
          </div>
        )}
      </div>
    </div>
  );
}
