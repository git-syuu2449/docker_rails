# Rails Docker

RailsをDocker環境で構築する。  
Nginx + PUMA + PostgreSQL + PGAdmin

## 前提

ホストにdocker,gitが導入済みであること

## 機能概要

追記

## 環境概要

本アプリケーションは、以下の技術スタックおよびDockerを用いた仮想環境で構築されています。

### アプリケーション構成

- ruby 3.4.2
- Rails 8.0.2
- postgres 17.5
- PGA 9.4
- Bundler version 2.6.9
- puma version 6.6.0
- node.js v18.19.0
- nginx version: nginx/1.27.5

追記

### ディレクトリ構成（抜粋）

追記

## サイト遷移図

追記

## 環境構築について

```bash
git clone git@github.com:git-syuu2449/docker_rails.git

# 初回かつdocker compose up後（gitにrailsが含まれていない場合）
# gitの多重構造になるのでnewした先の.gitはつくらない。
rails new アプリ名 --skip-git 

```


## docker起動

先に.envの配置をする  
下記.envの設定例を参照

```bash
# compose.yamlがいる階層に移動
cd ../
# docker compose up -d --build
docker compose --env-file .env up -d --build
# アタッチ
# web
docker compose exec rails_web bash
# nginx
docker compose exec rails_nginx bash

```

## ブラウザアクセス先

- web
http://localhost:3000/
- PGAdimin
http://localhost:8081/browser/

## .env設定例

```

# ---  UID/GID ---
U_ID=1000
G_ID=1000
USERNAME=appuser
GROUPNAME=appgroup

# --- POSTGRES ---
POSTGRES_USER=root
POSTGRES_PASSWORD=password
POSTGRES_DB=rails_db

PG_TEST_DATABASE=test_db

# --- PGAdmin ---
PGA_USER=root
PGA_EMAIL=admin@test.com
PGA_PASSWORD=password

# --- PORT設定 ---
APP_PORT=3000
POSTGRES_PORT=5432
NGINX_PORT=9300
PGA_PORT=8081


RAILS_ENV=development


```

## 導入

### gem

- dotenv-rails
- rspec-rails
- factory_bot_rails
- faker
- pry-rails
- pry-byebug
- pry-nav
- rubocop
- bullet
- rack-mini-profiler
- annotate


### VSCode

Ruby用に入れたもの

- Ruby LSP
- Rails
- Rails DB Schema
- vscode-gemfile



## トラブルシューティング

- webが立ち上がらない

webのdocker logsを参照する  
docker compose logs rails_web

  - サービスの確認

  docker compose ps  
  docker compose ps -a


- 環境変数が反映されない

webをrestart

- bundle installでエラー

permissionエラーなら一度インストール先のディレクトリを削除の上bundle installし直すか、chown -Rで権限を変える。  
→rootでbundle installし、作業用ユーザーでbundle installした時に発生する。  
　→どちらに統一すべきかは調査して追記