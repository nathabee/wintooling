pipeline {
    agent any

    parameters {
        string(
            name: 'GIT_BRANCH',
            defaultValue: 'main',
            description: 'Git branch to build.'
        )
        string(
            name: 'PYTHON_BIN',
            defaultValue: 'python3',
            description: 'Python executable used for release packaging.'
        )
        string(
            name: 'NODE_HOME_OVERRIDE',
            defaultValue: '',
            description: 'Optional Node.js home. Leave empty to use the agent default.'
        )
        string(
            name: 'RELEASE_NAME',
            defaultValue: '',
            description: 'Release name, for example 0.1.0 or 0.1.0-lan-test. Leave empty to use VERSION.'
        )
        booleanParam(
            name: 'PUBLISH_GITHUB_RELEASE',
            defaultValue: false,
            description: 'Publish release assets to GitHub Releases. Requires Jenkins credential github-token.'
        )
    }

    options {
        timestamps()
        disableConcurrentBuilds()
        buildDiscarder(logRotator(numToKeepStr: '10', artifactNumToKeepStr: '10'))
    }

    environment {
        GITHUB_REPO = 'nathabee/wintooling'
        ANGULAR_DIR = 'spaghettichef-angular/spangular'
    }

    stages {
        stage('Checkout Selected Branch') {
            steps {
                checkout([
                    $class: 'GitSCM',
                    branches: [[name: "*/${params.GIT_BRANCH ?: 'main'}"]],
                    userRemoteConfigs: [[
                        url: 'https://github.com/nathabee/wintooling.git'
                    ]]
                ])
            }
        }

        stage('Environment') {
            steps {
                script {
                    if (params.NODE_HOME_OVERRIDE?.trim()) {
                        env.PATH = "${params.NODE_HOME_OVERRIDE.trim()}/bin:${env.PATH}"
                    }
                }

                sh '''
                    set -eu
                    echo "PATH=${PATH}"
                    which "${PYTHON_BIN}"
                    which node
                    which npm
                    which git || true
                    which curl || true
                    "${PYTHON_BIN}" --version
                    node --version
                    npm --version
                '''
            }
        }

        stage('Resolve Release Name') {
            steps {
                sh '''
                    set -eu

                    VERSION_VALUE="$(tr -d '[:space:]' < VERSION)"
                    RELEASE_NAME_VALUE="${RELEASE_NAME:-}"

                    if [ -z "${RELEASE_NAME_VALUE}" ]; then
                      RELEASE_NAME_VALUE="${VERSION_VALUE}"
                    fi

                    bash ./tools/check-version.sh

                    SAFE_RELEASE_NAME="$(printf '%s' "${RELEASE_NAME_VALUE}" | tr -c 'A-Za-z0-9._-' '-')"

                    printf '%s\n' "${RELEASE_NAME_VALUE}" > .jenkins-release-name
                    printf '%s\n' "${SAFE_RELEASE_NAME}" > .jenkins-release-safe-name

                    echo "SpaghettiChef Angular release: ${RELEASE_NAME_VALUE}"
                '''
            }
        }

        stage('Install And Build Angular') {
            steps {
                sh '''
                    set -eu

                    cd "${ANGULAR_DIR}"

                    if [ -f package-lock.json ]; then
                      npm ci
                    else
                      npm install
                    fi

                    cp .env.example .env
                    npm run build -- --configuration production
                '''
            }
        }

        stage('Package Release Assets') {
            steps {
                sh '''
                    set -eu

                    SAFE_RELEASE_NAME="$(cat .jenkins-release-safe-name)"
                    WINDOWS_PACKAGE="spaghettichef-angular-${SAFE_RELEASE_NAME}-windows-production.zip"
                    LINUX_PACKAGE="spaghettichef-angular-${SAFE_RELEASE_NAME}-linux-production.tar.gz"

                    rm -rf package dist
                    mkdir -p package/windows package/linux dist

                    "${PYTHON_BIN}" - <<'PY'
import json
import pathlib
import shutil

browser_dist = pathlib.Path("spaghettichef-angular/spangular/dist/spangular/browser")
docs = pathlib.Path("spaghettichef-angular/docs")
readme = pathlib.Path("spaghettichef-angular/README.md")
env_example = pathlib.Path("spaghettichef-angular/spangular/.env.example")
destinations = [
    pathlib.Path("package/windows/spaghettichef-angular"),
    pathlib.Path("package/linux/spaghettichef-angular"),
]

if not browser_dist.exists():
    raise SystemExit(f"Missing Angular production output: {browser_dist}")

for destination in destinations:
    if destination.exists():
        shutil.rmtree(destination)
    (destination / "public").mkdir(parents=True)
    shutil.copytree(browser_dist, destination / "public", dirs_exist_ok=True)

    if docs.exists():
        shutil.copytree(docs, destination / "docs", dirs_exist_ok=True)

    if readme.exists():
        shutil.copy2(readme, destination / "README.md")

    config_dir = destination / "config"
    config_dir.mkdir(exist_ok=True)
    api_base_url = ""
    if env_example.exists():
        for line in env_example.read_text(encoding="utf-8").splitlines():
            if line.startswith("SPAGHETTICHEF_API_BASE_URL="):
                api_base_url = line.split("=", 1)[1]
                break

    (config_dir / "app-config.example.json").write_text(
        json.dumps({"apiBaseUrl": api_base_url}, indent=2) + "\n",
        encoding="utf-8",
    )
PY

                    tar -C package/linux -czf "dist/${LINUX_PACKAGE}" spaghettichef-angular

                    "${PYTHON_BIN}" - <<PY
import pathlib
import zipfile

source_path = pathlib.Path("package/windows/spaghettichef-angular")
target = pathlib.Path("dist/${WINDOWS_PACKAGE}")
archive_root = pathlib.Path("spaghettichef-angular")

with zipfile.ZipFile(target, "w", zipfile.ZIP_DEFLATED) as zf:
    for path in source_path.rglob("*"):
        if path.is_file():
            zf.write(path, archive_root / path.relative_to(source_path))
PY

                    ls -lh dist
                '''
            }
        }

        stage('Build Windows Installer') {
            steps {
                sh '''
                    set -eu

                    RELEASE_NAME_VALUE="$(cat .jenkins-release-name)"

                    docker build \
                      -t spaghettichef-inno-setup:local \
                      docker/inno-setup

                    docker run --rm \
                      -v "${PWD}:/work" \
                      spaghettichef-inno-setup:local \
                      "/DAppVersion=${RELEASE_NAME_VALUE}" \
                      "/DSourceDir=package/windows/spaghettichef-angular" \
                      "/DOutputDir=dist" \
                      installer/spaghettichef-angular.iss

                    test -f "dist/SpaghettiChefAngularSetup-${RELEASE_NAME_VALUE}.exe"
                '''
            }
        }

        stage('Finalize Release Artifacts') {
            steps {
                sh '''
                    set -eu

                    rm -f dist/SHA256SUMS.txt
                    sha256sum dist/* > dist/SHA256SUMS.txt
                    ls -lh dist
                '''

                archiveArtifacts artifacts: 'dist/*', fingerprint: true
            }
        }

        stage('Publish GitHub Release') {
            when {
                expression {
                    return params.PUBLISH_GITHUB_RELEASE
                }
            }
            steps {
                withCredentials([string(credentialsId: 'github-token', variable: 'GITHUB_TOKEN')]) {
                    sh '''
                        set -eu

                        RELEASE_NAME_VALUE="$(cat .jenkins-release-name)"
                        SAFE_RELEASE_NAME="$(cat .jenkins-release-safe-name)"
                        TAG_NAME="spaghettichef-angular-${SAFE_RELEASE_NAME}"
                        TITLE="SpaghettiChef Angular ${RELEASE_NAME_VALUE}"

                        API_JSON="$(mktemp)"
                        cat > "${API_JSON}" <<EOF
{
  "tag_name": "${TAG_NAME}",
  "name": "${TITLE}",
  "draft": false,
  "prerelease": false,
  "generate_release_notes": true
}
EOF

                        curl -sS -X POST \
                          -H "Accept: application/vnd.github+json" \
                          -H "Authorization: Bearer ${GITHUB_TOKEN}" \
                          "https://api.github.com/repos/${GITHUB_REPO}/releases" \
                          -d @"${API_JSON}" \
                          > github-release-response.json

                        UPLOAD_URL="$("${PYTHON_BIN}" - <<'PY'
import json

with open("github-release-response.json", "r", encoding="utf-8") as f:
    data = json.load(f)

print(data.get("upload_url", "").split("{")[0])
PY
)"

                        if [ -z "${UPLOAD_URL}" ]; then
                          echo "GitHub release creation did not return an upload URL." >&2
                          cat github-release-response.json >&2
                          exit 1
                        fi

                        for ARTIFACT in dist/*; do
                          CONTENT_TYPE="application/octet-stream"
                          case "${ARTIFACT}" in
                            *.tar.gz) CONTENT_TYPE="application/gzip" ;;
                            *.zip) CONTENT_TYPE="application/zip" ;;
                            *.txt) CONTENT_TYPE="text/plain" ;;
                          esac

                          ARTIFACT_NAME="$(basename "${ARTIFACT}")"
                          curl -sS -X POST \
                            -H "Accept: application/vnd.github+json" \
                            -H "Authorization: Bearer ${GITHUB_TOKEN}" \
                            -H "Content-Type: ${CONTENT_TYPE}" \
                            "${UPLOAD_URL}?name=${ARTIFACT_NAME}" \
                            --data-binary @"${ARTIFACT}"
                        done
                    '''
                }
            }
        }
    }

    post {
        success {
            echo 'SpaghettiChef Angular release pipeline completed successfully.'
        }
        failure {
            echo 'SpaghettiChef Angular release pipeline failed. Check Angular install, build, and packaging logs.'
        }
    }
}
