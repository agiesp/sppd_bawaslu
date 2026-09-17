import { fileURLToPath, URL } from 'node:url'

import { defineConfig } from 'vite'
import vue from '@vitejs/plugin-vue'
import laravel from 'laravel-vite-plugin'
import vueJsx from '@vitejs/plugin-vue-jsx'

export default defineConfig({
  plugins: [
    laravel({
      input: ['resources/js/app.js'],
      refresh: { paths: ['resources/views/**/*.blade.php'] },
    }),
    vue({
      template: {
        transformAssetUrls: {
          includeAbsolute: false,
        },
      },
    }),
    vueJsx(),
  ],
  resolve: {
    alias: {
      '@': fileURLToPath(new URL('./src', import.meta.url)),
    },
  },
  server: {
    host: '127.0.0.1',
    port: 5173,
    proxy: {
      '/api': {
        target: 'http://127.0.0.1:8000',
        changeOrigin: true,
      },
      '/storage': {
        target: 'http://127.0.0.1:8000',
        changeOrigin: true,
      },
    },
    watch: {
      ignored: [
        '**/storage/**',
        '**/bootstrap/cache/**',
        '**/vendor/**',
        '**/public/build/**',
      ],
    },
  },
  build: {
    copyPublicDir: true,
    outDir: 'public/build',
    emptyOutDir: true,
    chunkSizeWarningLimit: 600,
    rollupOptions: {
      output: {
        manualChunks(id) {
          if (!id.includes('node_modules')) return

          if (id.includes('lucide')) return 'icons'
          if (id.includes('apexcharts')) return 'charts'
          if (id.includes('flatpickr')) return 'flatpickr'

          if (
            id.includes('/vue/') ||
            id.includes('/vue-router/') ||
            id.includes('/@vue/') ||
            id.includes('/@inertiajs/') ||
            id.includes('/axios/')
          ) {
            return 'vue-core'
          }

          return 'vendor'
        },
      },
    },
  },
})