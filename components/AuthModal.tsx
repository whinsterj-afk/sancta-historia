"use client";

import { useState } from "react";
import { createSupabaseBrowserClient } from "@/lib/supabaseBrowserClient";

type Mode = "sign-in" | "sign-up";

export default function AuthModal({ onClose }: { onClose: () => void }) {
  const [mode, setMode] = useState<Mode>("sign-in");
  const [email, setEmail] = useState("");
  const [password, setPassword] = useState("");
  const [googlePending, setGooglePending] = useState(false);
  const [submitting, setSubmitting] = useState(false);
  const [error, setError] = useState<string | null>(null);
  const [confirmationSent, setConfirmationSent] = useState(false);

  async function signInWithGoogle() {
    setError(null);
    setGooglePending(true);

    const supabase = createSupabaseBrowserClient();
    const { error: signInError } = await supabase.auth.signInWithOAuth({
      provider: "google",
      options: {
        redirectTo: `${window.location.origin}/auth/callback`,
      },
    });

    if (signInError) {
      setError("Não foi possível iniciar o login. Tente novamente.");
      setGooglePending(false);
    }
  }

  async function handleSubmit(event: React.FormEvent) {
    event.preventDefault();
    setError(null);
    setSubmitting(true);

    const supabase = createSupabaseBrowserClient();

    if (mode === "sign-in") {
      const { error: signInError } = await supabase.auth.signInWithPassword({
        email,
        password,
      });

      setSubmitting(false);

      if (signInError) {
        setError("E-mail ou senha incorretos.");
        return;
      }

      onClose();
      return;
    }

    const { data, error: signUpError } = await supabase.auth.signUp({
      email,
      password,
      options: {
        emailRedirectTo: window.location.origin,
      },
    });

    setSubmitting(false);

    if (signUpError) {
      setError(
        signUpError.message.includes("already registered")
          ? "Este e-mail já tem uma conta. Tente entrar."
          : "Não foi possível criar a conta. Verifique os dados e tente novamente.",
      );
      return;
    }

    if (data.session) {
      onClose();
      return;
    }

    setConfirmationSent(true);
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
          {mode === "sign-in" ? "ENTRAR" : "CRIAR CONTA"}
        </h2>
        <p className="text-sm text-parchment-dim mb-5 leading-relaxed">
          Entre para escolher seu santo de devoção e contar como devoto dele.
        </p>

        {confirmationSent ? (
          <p className="text-sm text-gold-300 leading-relaxed">
            Enviamos um link de confirmação para {email}. Abra seu e-mail e
            confirme a conta para poder entrar.
          </p>
        ) : (
          <>
            <button
              type="button"
              onClick={signInWithGoogle}
              disabled={googlePending || submitting}
              className="w-full rounded-full border border-gold-500/40 px-4 py-2.5 text-sm text-parchment hover:bg-gold-500/10 transition disabled:opacity-60"
            >
              {googlePending ? "Abrindo o Google…" : "Continuar com Google"}
            </button>

            <div className="my-4 flex items-center gap-3 text-[10px] tracking-[0.15em] text-parchment-dim">
              <span className="h-px flex-1 bg-gold-500/25" />
              OU
              <span className="h-px flex-1 bg-gold-500/25" />
            </div>

            <form onSubmit={handleSubmit} className="flex flex-col gap-3">
              <label className="flex flex-col gap-1 text-xs text-gold-400">
                E-mail
                <input
                  type="email"
                  required
                  value={email}
                  onChange={(event) => setEmail(event.target.value)}
                  className="rounded-md border border-gold-500/30 bg-ink-900 px-3 py-2 text-sm text-parchment outline-none focus:border-gold-300"
                />
              </label>
              <label className="flex flex-col gap-1 text-xs text-gold-400">
                Senha
                <input
                  type="password"
                  required
                  minLength={6}
                  value={password}
                  onChange={(event) => setPassword(event.target.value)}
                  className="rounded-md border border-gold-500/30 bg-ink-900 px-3 py-2 text-sm text-parchment outline-none focus:border-gold-300"
                />
              </label>

              <button
                type="submit"
                disabled={submitting || googlePending}
                className="mt-1 rounded-full border border-gold-500 bg-gold-500 px-4 py-2.5 text-sm text-ink-950 transition disabled:opacity-60"
              >
                {submitting
                  ? "Enviando…"
                  : mode === "sign-in"
                    ? "Entrar"
                    : "Criar conta"}
              </button>
            </form>

            <button
              type="button"
              onClick={() => {
                setMode(mode === "sign-in" ? "sign-up" : "sign-in");
                setError(null);
              }}
              className="mt-3 text-xs text-parchment-dim underline hover:text-gold-300"
            >
              {mode === "sign-in"
                ? "Não tem conta? Criar uma."
                : "Já tem conta? Entrar."}
            </button>
          </>
        )}

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
