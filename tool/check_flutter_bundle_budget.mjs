import { readFile, readdir, stat } from 'node:fs/promises';
import { join } from 'node:path';
import { gzipSync } from 'node:zlib';

const budget = JSON.parse(await readFile('flutter-bundle-budget.json', 'utf8'));

async function directoryBytes(path) {
  let total = 0;
  for (const entry of await readdir(path, { withFileTypes: true })) {
    const child = join(path, entry.name);
    total += entry.isDirectory() ? await directoryBytes(child) : (await stat(child)).size;
  }
  return total;
}

for (const [surface, limits] of Object.entries(budget)) {
  const output = `build/${surface}`;
  const mainJavaScript = await readFile(`${output}/main.dart.js`);
  const actual = {
    totalBytes: await directoryBytes(output),
    mainJavaScriptBytes: mainJavaScript.length,
    mainJavaScriptGzipBytes: gzipSync(mainJavaScript).length
  };

  for (const [metric, maximum] of Object.entries(limits)) {
    if (actual[metric] > maximum) {
      throw new Error(`${surface} ${metric} is ${actual[metric]} bytes; budget is ${maximum}.`);
    }
  }
  console.log(
    `${surface}: ${(actual.totalBytes / 1_048_576).toFixed(2)} MiB total, ` +
      `${(actual.mainJavaScriptBytes / 1_048_576).toFixed(2)} MiB JS, ` +
      `${(actual.mainJavaScriptGzipBytes / 1024).toFixed(1)} KiB JS gzip.`
  );
}

console.log('Flutter production bundle budgets passed.');
