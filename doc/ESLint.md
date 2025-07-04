
# ESLint v9 + Vue 3 + TypeScript + Volar + Docker開発環境構築メモ

## 📦 必要パッケージ（Dockerコンテナ内）

```bash
# Railsのコンテナ内（例: rails_web）で実行
npm install -D \
  eslint@9 \
  @eslint/js \
  eslint-plugin-vue \
  vue-eslint-parser \
  @typescript-eslint/parser \
  @typescript-eslint/eslint-plugin \
  typescript
````

---

## ⚙️ VSCode 側の設定（settings.json）

`.vscode/settings.json` に以下を保存（プロジェクトローカルでもグローバルでも可）

```json
{
  "eslint.validate": ["vue", "typescript", "javascript"],
  "eslint.experimental.useFlatConfig": true,

  "typescript.tsdk": "node_modules/typescript/lib",
  "volar.validation.script": true,
  "volar.validation.template": true,

  "editor.formatOnSave": false
}
```

> 💡 Volarを使っている場合は、Veturはアンインストール or 無効化すること

---

## 📁 `eslint.config.js`（プロジェクトルート直下に配置）

```js
import js from '@eslint/js'
import vue from 'eslint-plugin-vue'
import vueParser from 'vue-eslint-parser'
import tsParser from '@typescript-eslint/parser'
import tsPlugin from '@typescript-eslint/eslint-plugin'

export default [
  js.configs.recommended,

  // Vueファイル（.vue）の解析設定
  {
    files: ['**/*.vue'],
    languageOptions: {
      parser: vueParser,
      parserOptions: {
        parser: tsParser,
        project: './tsconfig.json',
        tsconfigRootDir: process.cwd(),
        extraFileExtensions: ['.vue'],
        ecmaVersion: 'latest',
        sourceType: 'module',
      },
    },
    plugins: {
      vue,
      '@typescript-eslint': tsPlugin,
    },
    rules: {
      'vue/multi-word-component-names': 'off',
      '@typescript-eslint/no-unused-vars': ['warn'],
    },
  },

  // 通常の TypeScript ファイル用設定
  {
    files: ['**/*.ts'],
    languageOptions: {
      parser: tsParser,
      parserOptions: {
        project: './tsconfig.json',
        tsconfigRootDir: process.cwd(),
      },
    },
    plugins: {
      '@typescript-eslint': tsPlugin,
    },
    rules: {
      '@typescript-eslint/no-unused-vars': ['warn'],
    },
  },
]
```

---

## 📘 `tsconfig.json`（TypeScript + `.vue` 対応）

```json
{
  "compilerOptions": {
    "target": "ESNext",
    "module": "ESNext",
    "moduleResolution": "Node",
    "baseUrl": ".",
    "paths": {
      "@/*": ["app/frontend/js/*"],
      "@components/*": ["app/frontend/js/components/*"]
    },
    "strict": true,
    "jsx": "preserve",
    "esModuleInterop": true,
    "forceConsistentCasingInFileNames": true,
    "skipLibCheck": true,
    "allowJs": true,
    "resolveJsonModule": true
  },
  "include": ["app/frontend/**/*"],
  "exclude": ["node_modules"]
}
```

---

## ✅ 動作確認コマンド（Dockerコンテナ内）

```bash
npx eslint app/frontend/js/components/Samples/Area.vue
```

→ エラー表示 or 通過すれば設定OK

---

## ❌ よくあるエラーと対処

| エラー内容                                   | 対処法                                              |
| --------------------------------------- | ------------------------------------------------ |
| Parsing error: Type expected            | `tsconfig.json` に `.vue` を含める                    |
| ESLint couldn't find `eslint.config.js` | v9以降は `.eslintrc.js` ではなく `eslint.config.js` を使う |
| no-unused-vars など型系ルールが効かない             | `parserOptions.project` を指定する必要あり                |
| VSCodeで警告が出ない                           | 拡張が死んでる or 再起動必要（Outputタブで ESLintログ確認）           |

---

## 🏁 最後に

* VSCodeの拡張：**ESLint + Volar**
* コンテナ：`node_modules` はプロジェクト内で完結（ホストは不要）
* `eslint.config.js` が唯一の設定ファイル（v9以降）

```
