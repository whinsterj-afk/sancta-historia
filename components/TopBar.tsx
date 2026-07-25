"use client";

import Image from "next/image";
import { MenuIcon, SearchIcon, UserIcon } from "./icons";

export default function TopBar() {
  return (
    <header className="hero-header">
      <div className="hero-actions">
        <button type="button" aria-label="Abrir menu" className="hero-icon-button">
          <MenuIcon className="h-8 w-8" />
        </button>
        <button type="button" aria-label="Abrir perfil" className="hero-icon-button">
          <UserIcon className="h-9 w-9" />
        </button>
      </div>

      <div className="hero-logo" aria-label="Sancta Historia">
        <Image
          src="/sancta-historia-crest.png"
          alt="Brasão Sancta Historia"
          width={371}
          height={397}
          priority
        />
      </div>

      <label className="hero-search">
        <SearchIcon className="h-5 w-5" />
        <input aria-label="Buscar" placeholder="Buscar santo ou evento" />
      </label>
    </header>
  );
}
