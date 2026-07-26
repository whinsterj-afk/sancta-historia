import { type EmailOtpType } from "@supabase/supabase-js";
import { NextResponse, type NextRequest } from "next/server";
import { createSupabaseServerClient } from "@/lib/supabaseServerClient";

// Alvo do link de confirmação de e-mail (cadastro por senha). O template
// "Confirm signup" no Supabase Dashboard precisa apontar para cá com
// token_hash={{ .TokenHash }}&type=email&next={{ .RedirectTo }} — isso é
// configuração manual no dashboard, não neste repositório.
export async function GET(request: NextRequest) {
  const { searchParams } = new URL(request.url);
  const tokenHash = searchParams.get("token_hash");
  const type = searchParams.get("type") as EmailOtpType | null;
  const next = searchParams.get("next") ?? "/";

  // `next` pode chegar como caminho relativo ("/") ou como URL completa
  // (o Supabase preenche {{ .RedirectTo }} com o valor exato passado em
  // emailRedirectTo no signUp, que aqui é a origem inteira). Tratar os
  // dois casos evita colar uma URL absoluta dentro do pathname de outra.
  function resolveRedirect(target: string) {
    try {
      return new URL(target);
    } catch {
      const url = request.nextUrl.clone();
      url.pathname = target;
      url.search = "";
      return url;
    }
  }

  if (tokenHash && type) {
    const supabase = await createSupabaseServerClient();
    const { error } = await supabase.auth.verifyOtp({
      type,
      token_hash: tokenHash,
    });

    if (!error) {
      return NextResponse.redirect(resolveRedirect(next));
    }
  }

  return NextResponse.redirect(resolveRedirect("/"));
}
