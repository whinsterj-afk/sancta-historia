import { readFile } from "node:fs/promises";
import path from "node:path";
import { NextResponse } from "next/server";

const ALLOWED_FILE = /^maplibre-gl[\w-]*\.js$/;

export async function GET(
  _request: Request,
  { params }: { params: Promise<{ file: string }> }
) {
  const { file } = await params;

  if (!ALLOWED_FILE.test(file)) {
    return new NextResponse("Not found", { status: 404 });
  }

  const filePath = path.join(process.cwd(), "node_modules/maplibre-gl/dist", file);
  const content = await readFile(filePath, "utf-8");

  return new Response(content, {
    headers: {
      "Content-Type": "text/javascript",
      "Cache-Control": "public, max-age=31536000, immutable",
    },
  });
}
