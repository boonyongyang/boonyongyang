import { createReadStream, existsSync, statSync } from 'node:fs';
import { createServer } from 'node:http';
import { extname, resolve, sep } from 'node:path';

const args = new Map();
for (let index = 2; index < process.argv.length; index += 2) {
  args.set(process.argv[index], process.argv[index + 1]);
}

const root = resolve(args.get('--root') ?? '.');
const port = Number.parseInt(args.get('--port') ?? '4174', 10);
const mimeTypes = new Map([
  ['.css', 'text/css; charset=utf-8'],
  ['.html', 'text/html; charset=utf-8'],
  ['.ico', 'image/x-icon'],
  ['.js', 'text/javascript; charset=utf-8'],
  ['.json', 'application/json; charset=utf-8'],
  ['.png', 'image/png'],
  ['.svg', 'image/svg+xml'],
  ['.wasm', 'application/wasm'],
  ['.webp', 'image/webp']
]);

createServer((request, response) => {
  const pathname = decodeURIComponent(new URL(request.url ?? '/', 'http://127.0.0.1').pathname);
  const candidate = resolve(root, `.${pathname}`);
  const isContained = candidate === root || candidate.startsWith(`${root}${sep}`);
  let file = isContained && existsSync(candidate) && statSync(candidate).isFile() ? candidate : resolve(root, 'index.html');

  if (!existsSync(file)) {
    response.writeHead(404).end('Not found');
    return;
  }

  response.writeHead(200, {
    'Cache-Control': 'no-store',
    'Content-Type': mimeTypes.get(extname(file)) ?? 'application/octet-stream'
  });
  createReadStream(file).pipe(response);
}).listen(port, '127.0.0.1');
