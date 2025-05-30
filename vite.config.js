import { defineConfig } from 'vite';
import laravel from 'laravel-vite-plugin';

export default defineConfig({
  base: '/build/', // <--- essentiel
  plugins: [
    laravel({
      input: [
        'resources/js/app.js', 
        'resources/sass/styles.scss',
        'resources/css/app.css',
        'resources/js/intersectionObserver.js',
        'resources/js/script.js',],
      refresh: true,
    }),
  ],
});
