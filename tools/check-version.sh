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

failures=0

check_equals() {
  local label="$1"
  local actual="$2"

  if [[ "${actual}" != "${VERSION}" ]]; then
    echo "Version mismatch: ${label} is ${actual}, expected ${VERSION}" >&2
    failures=$((failures + 1))
  fi
}

read_json_version() {
  local path="$1"
  local selector="$2"

  "${PYTHON_CMD[@]}" - "${path}" "${selector}" <<'PY'
import json
import sys

with open(sys.argv[1], "r", encoding="utf-8") as f:
    data = json.load(f)

selector = sys.argv[2]
if selector == "root":
    print(data["version"])
elif selector == "package-lock-root":
    print(data["packages"][""]["version"])
else:
    raise SystemExit(f"Unknown selector: {selector}")
PY
}

for json_file in "${PACKAGE_JSON}" "${PACKAGE_LOCK_JSON}"; do
  if [[ ! -f "${json_file}" ]]; then
    echo "Missing Angular package file at ${json_file}" >&2
    exit 1
  fi
done

check_equals "spaghettichef-angular/spangular/package.json version" \
  "$(read_json_version "${PACKAGE_JSON}" root)"
check_equals "spaghettichef-angular/spangular/package-lock.json version" \
  "$(read_json_version "${PACKAGE_LOCK_JSON}" root)"
check_equals "spaghettichef-angular/spangular/package-lock.json packages root version" \
  "$(read_json_version "${PACKAGE_LOCK_JSON}" package-lock-root)"

if [[ "${failures}" -gt 0 ]]; then
  echo "Version check failed. Update VERSION first, then run tools/sync-version.sh." >&2
  exit 1
fi

echo "Version check passed: ${VERSION}"
