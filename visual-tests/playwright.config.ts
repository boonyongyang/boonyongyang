import { defineConfig } from '@playwright/test';

export default defineConfig({
  testDir: './tests',
  outputDir: './verification/playwright',
  fullyParallel: false,
  workers: 1,
  forbidOnly: Boolean(process.env.CI),
  retries: 0,
  reporter: [['list'], ['json', { outputFile: 'verification/results.json' }]],
  snapshotPathTemplate: '{testDir}/__screenshots__/{projectName}/{arg}{ext}',
  expect: {
    timeout: 15_000,
    toHaveScreenshot: {
      animations: 'disabled',
      caret: 'hide',
      maxDiffPixelRatio: 0.015,
      scale: 'css',
      threshold: 0.2
    }
  },
  use: {
    screenshot: 'only-on-failure',
    trace: 'retain-on-failure',
    reducedMotion: 'reduce'
  },
  webServer: [
    {
      command: 'node server.mjs --root ../build/landing --port 4174',
      url: 'http://127.0.0.1:4174',
      reuseExistingServer: false
    },
    {
      command: 'node server.mjs --root ../build/app --port 4175',
      url: 'http://127.0.0.1:4175',
      reuseExistingServer: false
    }
  ],
  projects: [
    {
      name: 'desktop',
      use: { viewport: { width: 1440, height: 900 } }
    },
    {
      name: 'mobile',
      use: {
        viewport: { width: 390, height: 844 },
        deviceScaleFactor: 1,
        hasTouch: true,
        isMobile: true
      }
    }
  ]
});
