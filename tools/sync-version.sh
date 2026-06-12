#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")/.." && pwd)"
VERSION_FILE="${ROOT_DIR}/VERSION"
PACKAGE_JSON="${ROOT_DIR}/spaghettichef-angular/spangular/package.json"
PACKAGE_LOCK_JSON="${ROOT_DIR}/spaghettichef-angular/spangular/package-lock.json"
PYTHON_BIN="${PYTHON_BIN:-python3}"

if [[ ! -f "${VERSION_FILE}" ]]; then
  echo "Missing VERSION file at ${VERSION_FILE}" >&2
  exit 1
fi

VERSION="$(tr -d '[:space:]' < "${VERSION_FILE}")"

if [[ ! "${VERSION}" =~ ^[0-9]+\.[0-9]+\.[0-9]+([-.][0-9A-Za-z.-]+)?$ ]]; then
  echo "VERSION must contain one semantic version, got: ${VERSION}" >&2
  exit 1
fi

"${PYTHON_BIN}" - "${VERSION}" "${PACKAGE_JSON}" "${PACKAGE_LOCK_JSON}" <<'PY'
import json
import sys
from pathlib import Path

version = sys.argv[1]

for raw_path in sys.argv[2:]:
    path = Path(raw_path)
    data = json.loads(path.read_text(encoding="utf-8"))
    data["version"] = version

    if path.name == "package-lock.json":
        data["packages"][""]["version"] = version

    path.write_text(json.dumps(data, indent=2) + "\n", encoding="utf-8")
PY

"${ROOT_DIR}/tools/check-version.sh"
