import { defineConfig } from 'vite';
import laravel from 'laravel-vite-plugin';

export default defineConfig({
  base: '/build/', // <--- essentiel
  plugins: [
    laravel({
      input: ['resources/js/app.js', 'resources/sass/styles.scss'],
      refresh: true,
    }),
  ],
});
