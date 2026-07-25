import { copyFileSync } from "node:fs";
import { fileURLToPath } from "node:url";
import path from "node:path";

const root = path.dirname(path.dirname(fileURLToPath(import.meta.url)));
const distDir = path.join(root, "node_modules/maplibre-gl/dist");
const publicDir = path.join(root, "public");

// The worker imports maplibre-gl-shared.mjs as a sibling module, so both
// files must be copied together and stay next to each other in public/.
for (const file of ["maplibre-gl-worker.mjs", "maplibre-gl-shared.mjs"]) {
  copyFileSync(path.join(distDir, file), path.join(publicDir, file));
}
console.log("Copied maplibre-gl worker scripts to public/");
