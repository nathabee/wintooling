#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")/.." && pwd)"
VERSION_FILE="${ROOT_DIR}/VERSION"
PACKAGE_JSON="${ROOT_DIR}/spaghettichef-angular/spangular/package.json"
PACKAGE_LOCK_JSON="${ROOT_DIR}/spaghettichef-angular/spangular/package-lock.json"

PYTHON_CMD=()

python_works() {
  "$@" -c "import json" >/dev/null 2>&1
}

resolve_python() {
  if [[ -n "${PYTHON_BIN:-}" ]]; then
    PYTHON_CMD=("${PYTHON_BIN}")
    if ! python_works "${PYTHON_CMD[@]}"; then
      echo "PYTHON_BIN does not point to a working Python: ${PYTHON_BIN}" >&2
      exit 1
    fi
    return
  fi

  if command -v python3 >/dev/null 2>&1 && python_works python3; then
    PYTHON_CMD=("python3")
    return
  fi

  if command -v python >/dev/null 2>&1 && python_works python; then
    PYTHON_CMD=("python")
    return
  fi

  if command -v py >/dev/null 2>&1 && python_works py -3; then
    PYTHON_CMD=("py" "-3")
    return
  fi

  echo "Python was not found. Install Python or set PYTHON_BIN." >&2
  exit 1
}

resolve_python

if [[ ! -f "${VERSION_FILE}" ]]; then
  echo "Missing VERSION file at ${VERSION_FILE}" >&2
  exit 1
fi

VERSION="$(tr -d '[:space:]' < "${VERSION_FILE}")"

if [[ ! "${VERSION}" =~ ^[0-9]+\.[0-9]+\.[0-9]+([-.][0-9A-Za-z.-]+)?$ ]]; then
  echo "VERSION must contain one semantic version, got: ${VERSION}" >&2
  exit 1
fi

"${PYTHON_CMD[@]}" - "${VERSION}" "${PACKAGE_JSON}" "${PACKAGE_LOCK_JSON}" <<'PY'
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
