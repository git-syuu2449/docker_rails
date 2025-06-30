import { defineConfig } from 'vite'
import RubyPlugin from 'vite-plugin-ruby'
import vue from '@vitejs/plugin-vue'
// import tailwindcss from "@tailwindcss/vite"; // v4用
import fs from 'fs'
import path from 'path'


// 再帰的にエントリポイントを取得
function getEntrypoints(dir) {
  const entries = {}
  const walk = (currentPath) => {
    fs.readdirSync(currentPath).forEach(file => {
      const fullPath = path.join(currentPath, file)
      const stat = fs.statSync(fullPath)
      if (stat.isDirectory()) {
        walk(fullPath)
      } else if (/\.(js|css|ts|tsx)$/.test(file)) {
        const relativePath = path.relative(dir, fullPath).replace(/\\/g, '/')
        entries[relativePath.replace(/\.(js|css)$/, '')] = fullPath
      }
    })
  }
  walk(dir)
  return entries
}



export default defineConfig({
  server: {
    // host: '0.0.0.0',
    host: true,
    port: 3036,
    strictPort: true,
    // allowedHosts: ['rails_app', 'rails_nginx', 'localhost', 'localhost:3000'], // 許可するコンテナ名
    // hmr: {
    //   // host: 'nginx',
    //   host: 'localhost',
    //   protocol: 'ws',
    //   port: 3036,
    // },
  },
  // js,css,imagesで切り分ける場合自動でパスが入らない為、明示的に記載する
  build: {
    rollupOptions: {
      input: getEntrypoints(path.resolve(__dirname, 'app/frontend'))
    }
  },
  plugins: [
    RubyPlugin(),
    vue()
    // tailwindcss() // v4用
  ],
})
