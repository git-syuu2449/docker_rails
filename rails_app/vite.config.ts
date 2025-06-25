import { defineConfig } from 'vite'
import RubyPlugin from 'vite-plugin-ruby'
// import tailwindcss from "@tailwindcss/vite"; // v4用

export default defineConfig({
  server: {
    host: '0.0.0.0',
    port: 3036,
    strictPort: true,
    allowedHosts: ['rails_app', 'rails_nginx', 'localhost', 'localhost:3000'], // 許可するコンテナ名
  },
  plugins: [
    RubyPlugin(),
    // tailwindcss() // v4用
  ],
})
