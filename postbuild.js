import fs from 'fs/promises';

await fs.mkdir('dist', { recursive: true });
await fs.cp('js/public', 'dist', { recursive: true });
