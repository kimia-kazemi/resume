#!/usr/bin/env bash
# Installs the latest stable Flutter SDK (outside the repo) and builds the web app.
set -euo pipefail

FLUTTER_DIR="${FLUTTER_DIR:-$HOME/flutter-sdk}"
RELEASES_URL="https://storage.googleapis.com/flutter_infra_release/releases"

if [ ! -x "$FLUTTER_DIR/bin/flutter" ]; then
  RELEASE_JSON=$(curl -fsSL "$RELEASES_URL/releases_linux.json" | node -e '
    let d = "";
    process.stdin.on("data", (c) => (d += c)).on("end", () => {
      const j = JSON.parse(d);
      const hash = j.current_release.stable;
      console.log(JSON.stringify(j.releases.find((r) => r.hash === hash)));
    });
  ')
  ARCHIVE=$(node -p 'JSON.parse(process.argv[1]).archive' "$RELEASE_JSON")
  echo "Downloading Flutter SDK: $ARCHIVE"
  rm -rf "$FLUTTER_DIR"
  mkdir -p "$FLUTTER_DIR"
  curl -fsSL "$RELEASES_URL/$ARCHIVE" | tar -xJ -C "$FLUTTER_DIR" --strip-components=1
  echo "$RELEASE_JSON" > "$FLUTTER_DIR/.release.json"
fi

# Write the SDK version manifest from the release metadata so the Flutter tool
# doesn't need to derive its version from git (which may be restricted).
node - "$FLUTTER_DIR" <<'JS'
const fs = require("fs");
const path = require("path");
const root = process.argv[2];
const release = JSON.parse(fs.readFileSync(path.join(root, ".release.json"), "utf8"));
const read = (...p) => fs.readFileSync(path.join(root, ...p), "utf8").trim();
let devToolsVersion = "0.0.0";
try {
  devToolsVersion = JSON.parse(
    read("bin", "cache", "dart-sdk", "bin", "resources", "devtools", "version.json")
  ).version;
} catch {}
const manifest = {
  frameworkVersion: release.version,
  channel: release.channel,
  repositoryUrl: "https://github.com/flutter/flutter.git",
  frameworkRevision: release.hash,
  frameworkCommitDate: release.release_date.replace("T", " ").replace(/\.\d+Z$/, ".000"),
  engineRevision: read("bin", "internal", "engine.version"),
  dartSdkVersion: read("bin", "cache", "dart-sdk", "version"),
  devToolsVersion,
  flutterVersion: release.version,
};
fs.mkdirSync(path.join(root, "bin", "cache"), { recursive: true });
fs.writeFileSync(path.join(root, "bin", "cache", "flutter.version.json"), JSON.stringify(manifest, null, 2));
JS

FLUTTER="$FLUTTER_DIR/bin/flutter"
"$FLUTTER" config --no-analytics --enable-web
"$FLUTTER" pub get
"$FLUTTER" build web --release
