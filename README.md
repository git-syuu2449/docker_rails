# Rails Docker

RailsをDocker環境で構築する。
Nginx + PUMA + PostgreSQL + PGAdmin

## install

```bash

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
docker compose exec web bash

```

## .env設定例

```

# ---  UID/GID ---
U_ID=1000
G_ID=1000

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
APP_PORT=8300
POSTGRES_PORT=5432
NGINX_PORT=9300
PGA_PORT=8081


RAILS_ENV=development


```
