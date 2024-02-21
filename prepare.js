import fs from 'fs/promises';

await fs.mkdir('dist', { recursive: true });
await fs.cp('js/main.mjs', 'dist/main.mjs');
