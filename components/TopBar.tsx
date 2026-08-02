"use client";

import Image from "next/image";
import { useEffect, useRef, useState } from "react";
import { InfoIcon, SearchIcon, UserIcon } from "./icons";
import AboutModal from "./AboutModal";
import AuthModal from "./AuthModal";
import ProfileModal from "./ProfileModal";
import { useSupabaseSession } from "@/lib/useSupabaseSession";

export interface SearchSuggestion {
  id: number;
  kind: "saint" | "event" | "parish";
  title: string;
  subtitle: string;
  year: number;
  latitude?: number;
  longitude?: number;
}

export default function TopBar({
  query,
  suggestions,
  searching,
  onQueryChange,
  onSelectSuggestion,
}: {
  query: string;
  suggestions: SearchSuggestion[];
  searching: boolean;
  onQueryChange: (value: string) => void;
  onSelectSuggestion: (suggestion: SearchSuggestion) => void;
}) {
  const [searchOpen, setSearchOpen] = useState(false);
  const [aboutOpen, setAboutOpen] = useState(true);
  const [accountOpen, setAccountOpen] = useState(false);
  const searchWrapRef = useRef<HTMLDivElement>(null);
  const { user } = useSupabaseSession();

  useEffect(() => {
    if (!searchOpen) return;

    function handlePointerDown(event: MouseEvent) {
      if (!searchWrapRef.current?.contains(event.target as Node)) {
        setSearchOpen(false);
      }
    }

    document.addEventListener("mousedown", handlePointerDown);
    return () => document.removeEventListener("mousedown", handlePointerDown);
  }, [searchOpen]);

  return (
    <header className="hero-header">
      <div className="hero-actions">
        <button
          type="button"
          aria-label="Sobre o projeto"
          title="Sobre o projeto"
          className="hero-icon-button"
          onClick={() => setAboutOpen(true)}
        >
          <InfoIcon className="h-8 w-8" />
        </button>
        <button
          type="button"
          aria-label={user ? "Meu perfil" : "Entrar"}
          title={user ? "Meu perfil" : "Entrar"}
          className="hero-icon-button"
          onClick={() => setAccountOpen(true)}
        >
          <UserIcon className="h-9 w-9" />
        </button>
      </div>

      <div
        className="hero-logo"
        aria-label="Sancta Historia"
        style={{
          width: 170,
          height: 188,
          overflow: "hidden",
          position: "relative",
        }}
      >
        <Image
          src="/sancta-historia-logo.png"
          alt="Logo oficial Sancta Historia"
          width={2121}
          height={3000}
          priority
          style={{
            width: 225,
            maxWidth: "none",
            height: "auto",
            transform: "translate(-31.4px, -28.9px)",
          }}
        />
      </div>

      <div className="hero-search-wrap" ref={searchWrapRef}>
        <label className="hero-search">
          <SearchIcon className="h-5 w-5 shrink-0" />
          <input
            aria-label="Buscar santo, evento ou paróquia"
            role="combobox"
            aria-expanded={searchOpen}
            aria-controls="historical-search-results"
            autoComplete="off"
            placeholder="Buscar santo, evento ou paróquia"
            value={query}
            onChange={(event) => {
              onQueryChange(event.target.value);
              setSearchOpen(true);
            }}
            onFocus={() => setSearchOpen(true)}
            onKeyDown={(event) => {
              if (event.key === "Escape") setSearchOpen(false);
            }}
          />
          {searching && <span className="search-spinner" aria-label="Buscando" />}
        </label>

        {searchOpen && query.trim().length >= 2 && (
          <div
            id="historical-search-results"
            className="search-results"
            role="listbox"
            aria-label="Resultados da busca"
          >
            {!searching && suggestions.length === 0 && (
              <p className="search-empty">Nenhum registro encontrado.</p>
            )}

            {suggestions.map((suggestion) => (
              <button
                key={`${suggestion.kind}-${suggestion.id}`}
                type="button"
                role="option"
                aria-selected="false"
                className="search-result"
                onClick={() => {
                  onSelectSuggestion(suggestion);
                  setSearchOpen(false);
                }}
              >
                <span className="search-result-type">
                  {suggestion.kind === "saint"
                    ? "Santo"
                    : suggestion.kind === "event"
                      ? "Evento"
                      : "Paróquia"}
                </span>
                <span className="search-result-copy">
                  <strong>{suggestion.title}</strong>
                  <small>{suggestion.subtitle}</small>
                </span>
              </button>
            ))}
          </div>
        )}
      </div>

      {aboutOpen && <AboutModal onClose={() => setAboutOpen(false)} />}
      {accountOpen &&
        (user ? (
          <ProfileModal user={user} onClose={() => setAccountOpen(false)} />
        ) : (
          <AuthModal onClose={() => setAccountOpen(false)} />
        ))}
    </header>
  );
}
