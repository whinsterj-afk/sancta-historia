import { createClient } from "@supabase/supabase-js";

const url = process.env.NEXT_PUBLIC_SUPABASE_URL!;
const key = process.env.NEXT_PUBLIC_SUPABASE_ANON_KEY!;

// Cliente do conteúdo público (mapa, timeline, busca, santo). Não depende
// de sessão, então não deve manter nenhuma: sem estas opções ele cria um
// segundo GoTrueClient sobre o mesmo storage de supabaseBrowserClient.ts e
// passa a enviar o token de sessão daquele cliente no Authorization. Se o
// token estiver a meio de uma renovação, o Supabase responde
// "Invalid API key" e a estrutura eclesiástica some do mapa, de forma
// intermitente e sem relação com esta consulta.
export const supabase = createClient(url, key, {
  auth: {
    storageKey: "sancta-historia-public-content",
    persistSession: false,
    autoRefreshToken: false,
    detectSessionInUrl: false,
  },
});
