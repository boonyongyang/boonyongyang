import { mkdir, writeFile } from 'node:fs/promises';
import { dirname } from 'node:path';
import { connect } from 'node:tls';
import { setTimeout as wait } from 'node:timers/promises';

const timeoutMs = 20_000;
const retryCount = 2;
const minimumCertificateDays = 21;
const userAgent = 'boonyongyang-portfolio-production-smoke/2.0';
const reportPath = process.env.PRODUCTION_SMOKE_REPORT ?? 'verification/production-smoke.json';

const routes = [
  ['Landing custom', 'https://boonyongyang.com/'],
  ['Landing fallback', 'https://boonyongyang.web.app/'],
  ['Interactive app custom', 'https://app.boonyongyang.com/'],
  ['Interactive app fallback', 'https://boonyongyang-app.web.app/'],
  ['3D custom', 'https://3d.boonyongyang.com/'],
  ['3D Release Bench', 'https://3d.boonyongyang.com/themes/release-bench/'],
  ['3D Field Manual', 'https://3d.boonyongyang.com/themes/field-manual/'],
  ['3D Store Review Room', 'https://3d.boonyongyang.com/themes/review-room/'],
  ['3D fallback', 'https://boonyongyang-3d.web.app/'],
  ['V4 Release Dossier', 'https://boonyongyang-v4.web.app/']
];

const report = {
  checkedAt: new Date().toISOString(),
  checks: [],
  summary: { passed: 0, failed: 0, total: 0 }
};

const request = async (url, options = {}) => {
  let lastError;
  for (let attempt = 0; attempt <= retryCount; attempt += 1) {
    try {
      const response = await fetch(url, {
        ...options,
        headers: { 'user-agent': userAgent, ...options.headers },
        signal: AbortSignal.timeout(timeoutMs)
      });
      if (response.status < 500 || attempt === retryCount) return response;
      lastError = new Error(`received HTTP ${response.status}`);
    } catch (error) {
      lastError = error;
      if (attempt === retryCount) throw error;
    }
    await wait(500 * (attempt + 1));
  }
  throw lastError;
};

const runCheck = async (type, label, target, check) => {
  const startedAt = Date.now();
  try {
    const detail = await check();
    report.checks.push({
      type,
      label,
      target,
      status: 'passed',
      durationMs: Date.now() - startedAt,
      detail
    });
    report.summary.passed += 1;
    console.log(`PASS ${type} ${label}${detail ? ` (${detail})` : ''}`);
  } catch (error) {
    const message = error instanceof Error ? error.message : String(error);
    report.checks.push({
      type,
      label,
      target,
      status: 'failed',
      durationMs: Date.now() - startedAt,
      error: message
    });
    report.summary.failed += 1;
    console.error(`FAIL ${type} ${label}: ${message}`);
  }
  report.summary.total += 1;
};

const expectStatus = async (url, expected = 200) => {
  const response = await request(url);
  if (response.status !== expected) {
    throw new Error(`expected HTTP ${expected}, received ${response.status}`);
  }
  return `HTTP ${response.status}`;
};

const expectRedirect = async (url) => {
  const response = await request(url, { redirect: 'manual' });
  const location = response.headers.get('location');
  if (response.status !== 301 || location !== 'https://3d.boonyongyang.com') {
    throw new Error(`expected 301 to https://3d.boonyongyang.com, received ${response.status} to ${location}`);
  }
  return 'HTTP 301';
};

const expectContent = async (url, requiredValues) => {
  const response = await request(url);
  if (response.status !== 200) throw new Error(`expected HTTP 200, received ${response.status}`);
  const body = await response.text();
  for (const value of requiredValues) {
    if (!body.includes(value)) throw new Error(`missing ${value}`);
  }
  return `${requiredValues.length} markers`;
};

const certificateDaysRemaining = (host) =>
  new Promise((resolve, reject) => {
    let settled = false;
    const socket = connect({ host, port: 443, servername: host, rejectUnauthorized: true });
    const finish = (error, value) => {
      if (settled) return;
      settled = true;
      socket.destroy();
      if (error) reject(error);
      else resolve(value);
    };
    socket.setTimeout(timeoutMs, () => finish(new Error('TLS connection timed out')));
    socket.once('error', (error) => finish(error));
    socket.once('secureConnect', () => {
      const certificate = socket.getPeerCertificate();
      const expiresAt = Date.parse(certificate.valid_to ?? '');
      if (!Number.isFinite(expiresAt)) return finish(new Error('certificate expiry is unavailable'));
      const days = Math.floor((expiresAt - Date.now()) / 86_400_000);
      if (days < minimumCertificateDays) return finish(new Error(`certificate expires in ${days} days`));
      finish(null, days);
    });
  });

for (const [label, url] of routes) {
  await runCheck('route', label, url, () => expectStatus(url));
}

for (const url of [
  'https://boonyongyang-portfolio-3d.web.app/',
  'https://boonyongyang-portfolio-3d.web.app/unknown-path'
]) {
  await runCheck('redirect', 'Legacy 3D redirect', url, () => expectRedirect(url));
}

const contentContracts = [
  [
    '3D metadata and navigation',
    'https://3d.boonyongyang.com/',
    [
      'https://3d.boonyongyang.com',
      'https://app.boonyongyang.com',
      'Release Bench',
      '/themes/field-manual/',
      '/themes/review-room/'
    ]
  ],
  [
    '3D robots',
    'https://3d.boonyongyang.com/robots.txt',
    ['Host: https://3d.boonyongyang.com', 'Sitemap: https://3d.boonyongyang.com/sitemap.xml']
  ],
  [
    '3D sitemap',
    'https://3d.boonyongyang.com/sitemap.xml',
    [
      'https://3d.boonyongyang.com/themes/release-bench/',
      'https://3d.boonyongyang.com/themes/field-manual/',
      'https://3d.boonyongyang.com/themes/review-room/'
    ]
  ],
  [
    'V4 version navigation',
    'https://boonyongyang-v4.web.app/',
    [
      'https://app.boonyongyang.com',
      'https://3d.boonyongyang.com/themes/release-bench/',
      'https://3d.boonyongyang.com/themes/field-manual/',
      'https://3d.boonyongyang.com/themes/review-room/'
    ]
  ],
  [
    'Landing version navigation',
    'https://boonyongyang.web.app/main.dart.js',
    ['https://app.boonyongyang.com', 'https://3d.boonyongyang.com']
  ],
  [
    'Interactive app version navigation',
    'https://boonyongyang-app.web.app/main.dart.js',
    ['https://app.boonyongyang.com', 'https://3d.boonyongyang.com']
  ]
];

for (const [label, url, markers] of contentContracts) {
  await runCheck('content', label, url, () => expectContent(url, markers));
}

for (const host of ['boonyongyang.com', 'app.boonyongyang.com', '3d.boonyongyang.com']) {
  await runCheck('tls', host, host, async () => `${await certificateDaysRemaining(host)} days remaining`);
}

await mkdir(dirname(reportPath), { recursive: true });
await writeFile(reportPath, `${JSON.stringify(report, null, 2)}\n`);

if (process.env.GITHUB_STEP_SUMMARY) {
  const summary = [
    '## Portfolio production smoke',
    '',
    `- Checked: ${report.checkedAt}`,
    `- Passed: ${report.summary.passed}`,
    `- Failed: ${report.summary.failed}`,
    `- Total: ${report.summary.total}`,
    '',
    report.summary.failed === 0 ? 'All public contracts passed.' : 'See the retained JSON report for failures.'
  ].join('\n');
  await writeFile(process.env.GITHUB_STEP_SUMMARY, `${summary}\n`, { flag: 'a' });
}

if (report.summary.failed > 0) {
  console.error(`Production smoke failed: ${report.summary.failed} of ${report.summary.total} checks failed.`);
  process.exitCode = 1;
} else {
  console.log(`Production smoke passed: ${report.summary.total} checks with retry and TLS coverage.`);
}
