import { defineConfig } from 'vite'
import RubyPlugin from 'vite-plugin-ruby'
import vue from  '@vitejs/plugin-vue'
// import tailwindcss from "@tailwindcss/vite"; // v4用

export default defineConfig({
  resolve: {
    alias: {
      'vue': 'vue/dist/vue.esm-bundler.js',
    },
  },
  plugins: [
    RubyPlugin(),
    vue(),
    // tailwindcss() // v4用
  ],
  base: '/vite-dev/',
  server: {
    host: '0.0.0.0',
    port: 5173,
    strictPort: true,
    hmr: {
      host: 'localhost',
      port: 5173,
      protocol: 'ws'
    }
  }
})
