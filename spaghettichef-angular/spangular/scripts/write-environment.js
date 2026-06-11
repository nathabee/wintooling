const fs = require('fs');
const path = require('path');

const projectRoot = path.resolve(__dirname, '..');
const envPath = path.join(projectRoot, '.env');
const environmentDir = path.join(projectRoot, 'src', 'environments');
const environmentPath = path.join(environmentDir, 'environment.ts');
const fallbackApiBaseUrl = 'http://localhost:18080';

function readEnvFile(filePath) {
  if (!fs.existsSync(filePath)) {
    return {};
  }

  return fs
    .readFileSync(filePath, 'utf8')
    .split(/\r?\n/)
    .map((line) => line.trim())
    .filter((line) => line && !line.startsWith('#'))
    .reduce((values, line) => {
      const separatorIndex = line.indexOf('=');

      if (separatorIndex === -1) {
        return values;
      }

      const key = line.slice(0, separatorIndex).trim();
      const value = line.slice(separatorIndex + 1).trim().replace(/^["']|["']$/g, '');

      values[key] = value;
      return values;
    }, {});
}

const envValues = readEnvFile(envPath);
const apiBaseUrl =
  process.env.SPAGHETTICHEF_API_BASE_URL ||
  envValues.SPAGHETTICHEF_API_BASE_URL ||
  fallbackApiBaseUrl;

fs.mkdirSync(environmentDir, { recursive: true });
fs.writeFileSync(
  environmentPath,
  `export const environment = {\n  spaghettichefApiBaseUrl: ${JSON.stringify(apiBaseUrl)}\n};\n`
);

console.log(`Wrote src/environments/environment.ts with API base URL: ${apiBaseUrl}`);
