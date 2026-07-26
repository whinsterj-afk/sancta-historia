import { createServerClient } from "@supabase/ssr";
import { NextResponse, type NextRequest } from "next/server";

// Next.js 16 renomeou "Middleware" para "Proxy" (mesma função, novo nome).
// Este arquivo refresca o cookie de sessão do Supabase a cada request,
// seguindo o padrão oficial de SSR do Supabase adaptado para a convenção
// nova (createServerClient + getAll/setAll + getClaims()).
export async function proxy(request: NextRequest) {
  let response = NextResponse.next({ request });

  const supabase = createServerClient(
    process.env.NEXT_PUBLIC_SUPABASE_URL!,
    process.env.NEXT_PUBLIC_SUPABASE_ANON_KEY!,
    {
      cookies: {
        getAll() {
          return request.cookies.getAll();
        },
        setAll(cookiesToSet, headers) {
          cookiesToSet.forEach(({ name, value }) =>
            request.cookies.set(name, value),
          );
          response = NextResponse.next({ request });
          cookiesToSet.forEach(({ name, value, options }) =>
            response.cookies.set(name, value, options),
          );
          Object.entries(headers).forEach(([key, value]) =>
            response.headers.set(key, value),
          );
        },
      },
    },
  );

  // getClaims() dispara o refresh do token quando necessário; o cookie
  // atualizado é escrito na response através do setAll acima. Precisa
  // rodar antes de qualquer outra coisa gerar a response.
  await supabase.auth.getClaims();

  return response;
}

export const config = {
  matcher: [
    "/((?!_next/static|_next/image|favicon.ico|maplibre-worker|.*\\.(?:svg|png|jpg|jpeg|gif|webp)$).*)",
  ],
};
