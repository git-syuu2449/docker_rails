import { defineConfig } from 'vite'
import RubyPlugin from 'vite-plugin-ruby'
import vue from  '@vitejs/plugin-vue'
// import tailwindcss from "@tailwindcss/vite"; // v4用

export default defineConfig({
  server: {
    host: '0.0.0.0',
    port: 3036,
    strictPort: true,
    allowedHosts: ['rails_app', 'rails_nginx', 'localhost', 'localhost:3000'], // 許可するコンテナ名
  },
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
})
