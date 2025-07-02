// @eslint/js は ESLint の基本ルールセットを提供する公式パッケージ
import js from '@eslint/js'
// Vue ファイルの構文解析とルールを提供するプラグイン
import vue from 'eslint-plugin-vue'
// .vue ファイル全体（テンプレート含む）を解析する専用パーサー
import vueParser from 'vue-eslint-parser'
// TypeScript用のパーサーとルールプラグイン
import tsParser from '@typescript-eslint/parser'
import tsPlugin from '@typescript-eslint/eslint-plugin'

export default [
  // JSのベース設定（ESLint公式ルール推奨セット）
  js.configs.recommended,

  // Vueファイル（.vue）専用の設定ブロック
  {
    files: ['**/*.vue'], // 対象ファイル
    languageOptions: {
      parser: vueParser, // vue専用パーサーで .vue ファイルの構文を解釈

      // <script lang="ts"> の中身を TypeScript として解釈する
      parserOptions: {
        parser: tsParser, // scriptブロックをTypeScriptで解析
        project: './tsconfig.json', // 型解決に使うtsconfig
        tsconfigRootDir: process.cwd(), // tsconfigのルートを明示（特にモノレポ対策）
        extraFileExtensions: ['.vue'], // .vue を ts 的に扱う
        ecmaVersion: 'latest', // 最新構文のサポート
        sourceType: 'module', // ESモジュールとして解釈
      },
      globals: {
        ...globals.browser
      }
    },
    plugins: {
      vue,
      '@typescript-eslint': tsPlugin,
    },
    rules: {
      // Component名が1単語でも警告しない（例: "Login.vue"）
      'vue/multi-word-component-names': 'off',

      // 未使用変数を警告（warning）レベルで出す
      '@typescript-eslint/no-unused-vars': ['warn'],

      // コンソールとアラートの許可
      'no-console': 'off',
      'no-alert': 'off',

      // 他、必要に応じてルールを追加
    },
  },

  // 通常の .ts ファイル用設定（.vue 以外の TypeScript）
  {
    files: ['**/*.ts'],
    languageOptions: {
      parser: tsParser,
      parserOptions: {
        project: './tsconfig.json',
        tsconfigRootDir: process.cwd(),
      },
      globals: {
        ...globals.browser
      }
    },
    plugins: {
      '@typescript-eslint': tsPlugin,
    },
    rules: {
      '@typescript-eslint/no-unused-vars': ['warn'],
      // コンソールとアラートの許可
      'no-console': 'off',
      'no-alert': 'off',
    },
  },
]
