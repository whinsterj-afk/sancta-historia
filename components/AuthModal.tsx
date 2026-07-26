"use client";

import { useState } from "react";
import { createSupabaseBrowserClient } from "@/lib/supabaseBrowserClient";

export default function AuthModal({ onClose }: { onClose: () => void }) {
  const [pendingProvider, setPendingProvider] = useState<
    "google" | "azure" | null
  >(null);
  const [error, setError] = useState<string | null>(null);

  async function signInWith(provider: "google" | "azure") {
    setError(null);
    setPendingProvider(provider);

    const supabase = createSupabaseBrowserClient();
    const { error: signInError } = await supabase.auth.signInWithOAuth({
      provider,
      options: {
        redirectTo: `${window.location.origin}/auth/callback`,
      },
    });

    if (signInError) {
      setError("Não foi possível iniciar o login. Tente novamente.");
      setPendingProvider(null);
    }
  }

  return (
    <div
      className="pointer-events-auto fixed inset-0 z-50 flex items-center justify-center bg-black/60 p-4"
      onClick={onClose}
    >
      <div
        className="panel-glass border rounded-xl max-w-sm w-full p-6"
        onClick={(event) => event.stopPropagation()}
      >
        <h2 className="font-display text-lg tracking-[0.1em] text-gold-200 mb-2">
          ENTRAR
        </h2>
        <p className="text-sm text-parchment-dim mb-5 leading-relaxed">
          Entre para escolher seu santo de devoção e contar como devoto dele.
        </p>

        <div className="flex flex-col gap-3">
          <button
            type="button"
            onClick={() => signInWith("google")}
            disabled={pendingProvider !== null}
            className="rounded-full border border-gold-500/40 px-4 py-2.5 text-sm text-parchment hover:bg-gold-500/10 transition disabled:opacity-60"
          >
            {pendingProvider === "google"
              ? "Abrindo o Google…"
              : "Continuar com Google"}
          </button>
          <button
            type="button"
            onClick={() => signInWith("azure")}
            disabled={pendingProvider !== null}
            className="rounded-full border border-gold-500/40 px-4 py-2.5 text-sm text-parchment hover:bg-gold-500/10 transition disabled:opacity-60"
          >
            {pendingProvider === "azure"
              ? "Abrindo a Microsoft…"
              : "Continuar com Microsoft"}
          </button>
        </div>

        {error && (
          <p className="mt-4 text-sm text-[#ffd9ca]" role="alert">
            {error}
          </p>
        )}

        <button
          type="button"
          onClick={onClose}
          className="mt-6 rounded-full border border-gold-500/40 px-4 py-2 text-xs tracking-[0.15em] text-gold-300 hover:bg-gold-500/10 transition"
        >
          FECHAR
        </button>
      </div>
    </div>
  );
}
