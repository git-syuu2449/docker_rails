#!/bin/bash

set -e

# echo "Composer install 開始"
# composer install

echo "bundle install 開始" # dockerfileで実施済みだが再度実施しておく
bundle install

echo "NPM install 開始"
npm install

echo "必要な npm パッケージの追加（開発依存）"
npm install \
  glob@7 \
  vue \
  @vitejs/plugin-vue \
  tailwindcss \
  axios \
  # vite \
  # postcss \
  # autoprefixer

echo " Tailwind 初期設定"
npx tailwindcss init -p

# echo "Rails の初期設定"
# 必要なら追記

echo "セットアップ完了"
