# Railsについて

## 変更点

7→8.0.2にかけての変更点を抜粋

- Kamalが追加
- generateに認証機能が追加
- Bulk insert fixtures 対応
- クエリキャッシング対応
- スクリプトジェネレータ
- Hotwire標準化
- 設定から非推奨設定の削除


他は追記


### 認証について

- ログイン／パスワードリセット機能搭載
- 軽量
- APIには使用できない
- 2FA,登録,メール確認などの拡張の際には自前実装が必須

結論：実務には不向き。
従来どおりDevise,jwtを使用したほうがいいと思われる。


他は適宜追記




## bundle

- bundle add

- bundle install

- bundle update


bundleのパスはBUNDLE_PATHにて管理  
railsインストール時にdockerfileが生成されるのは確認する。  




## rails generate

生成できる内容を追加するタイミングでまとめる
使用できるオプションも記載する。

基本：  
rails generate [ジェネレータ] [名前] [属性]  

ヘルプ：

以下のように段階で確認可能

rails g --help  
rails g controller --help  

生成されるテンプレートは以下で上書きが可能(スタブ)  
lib/templates/以下  

- コントローラ
  lib/templates/rails/controller/controller.rb.tt  
- モデル  
  lib/templates/active_record/model/model.rb.tt  
  
  など



#### controller

- web  
rails g controller コントローラ名 アクション名

- api  
rails g controller api/コントローラ名 アクション名 --no-helper --no-assets --no-view-specs --skip-template-engine

###### 生成されるファイル

- コントローラ  
  app/controllers/<コントローラ名>_controller.rb

- ビュー  
  app/views/<コントローラ名>/<アクション>.html.erb

- ルーティング  
  config/routes.rbに追記

- テスト
  rspecを入れている場合はrspecがデフォルト

- helper
  ヘルパー

- assets
  css,js

###### オプション

よく使うもののみ。以下項目のオプションも同様

- --skip-routes  
  ルーティングをスキップ
- 



#### model

rails g model モデル名 カラム名:型

生成されるファイル

- モデル
app/models/<モデル名>.rb

- マイグレーション  
db/migrate/<timestamp>_create_<テーブル名>.rb

- テスト  
test/models/..._test.rb

#### scaffold


#### migration

rails g migration 名前 カラム名:型


#### job


#### channel


#### mailer


など



## rails new

プロジェクトを作成する。  
オプションでcssやDB周りの設定も可能。





## vite導入

これらの導入は`setup.sh`にて行う。

1. gem追加  
Gemfileに`vite_rails`を追加  
```bash
bundle install
```

2. vite初期化  
```bash
bundle exec vite install
bundle exec vite install vue # vue
bundle exec vite install react # react
```

3. パッケージインストール  
```bash
npm install
# npm install --save-dev @vitejs/plugin-vue
```

4. Rails側でJS読み込み設定（レイアウト修正）

5. 開発サーバ起動  
```bash
npm run dev
# もしくは以下
bin/vite dev
bin/rails server
```

# tailscss導入

1. gem追加
Gemfileに`tailwindcss-rails`を追加
```bash
bundle install
```

2. パッケージインストール
```bash
npm install -D tailwindcss postcss autoprefixer
```

3. 初期化
```bash
npx tailwindcss init
```

## vite導入後の注意点

これはvite+vue+tailwindの項を別途作って切り出すか。

1. 階層の変更

Railsのデフォルトは app/assets以下にstyleseets,images, app以下にjavascriptが存在する。  
viteを使用する場合のパスは `config/vite.json`で定義している`entrypointsDir`のパスになる。  
erbでvite_stylesheet_tagを使用すると/vite/entrypoints/のパスが生成される。
これは、config/vite.json と vite-plugin-ruby の仕様に基づいて生成される。
/vite/entrypoints/... は仮想パスで、初期設定の場合は上のパスになる。


## devise導入

gemfileに追加後、以下手順を行う
```bash
bundle install

# deviseの設定ファイルを作成する
rails g devise:install

# モデル、マイグレーション作成
rails g devise User

# マイグレーション実施(rakeでも可)
rails db:migrate

# コントローラの作成が行われないのでする
rails g devise:controllers users

# viewファイルの作成をする
rails g devise:views users

# ルーティングを確認して追加されていることを確認
> http://localhost:3000/rails/info/routes

# DBを確認(それぞれの環境に合わせる)

```

複数のロールが必要な場合はテーブルを分けてログイン画面も分ける。  
usersと書いてあるところをadminsに変更して実施する。  

## devise-jwt導入

Apiでの認証に使用する

## Pundit導入

認可用に使用する。  
他候補としてcancancanがあるが、簡単な認可であればcancancanでもいい。

gemfileに追加後、以下手順を行う  
```bash
bundle install

rails g pundit:install

# app/policies/application_policy.rb が作成される

# policyを追加する場合
rails g pundit:policy ポリシー名
```

### 注意点

app/models/user.rbで
undefined method 'devise' for class User
が発生する。

1. gem追加漏れ
2. Spring（アプリロ−ダー）でキャッシュされている
3. 他のキャッシュが残っている

などが考えられる。

1. はbundle installし直す。
2. は`DISABLE_SPRING=1`をコンソールで行う。
3. はサーバー自体を再起動する。

キャッシュされていると不具合が出やすいのでキャッシュは無効にしておくほうがいい。
3のエラーはundefined method 'devise'と、routes周りのエラーがランダムに発生する現象が起きる。
もしくはロード順の関係。

明確な対応方法  
config/initializers/にdeviseを明示的にdeviseの読み込みをするファイルを追加する  
```rb
# rails_app/config/initializers/devise_load_fix.rb
require 'devise'
```

`config/initializers/`は配置してあるとアプリ起動時に一度だけ読み込む。  
別途設定等は不要。（と思う）


## 

## サーバー再起動

Puma+Nginx構成で以下の方法をとる

1. Pumaの「ホットリスタート」機能  
ダウンタイムなしで再起動
```bash
docker compose exec rails_app pkill -USR2 -f puma
# コンテナ内
pkill -USR2 -f puma
```

2. Pumaを開発モードで実施  
```bash
# config/environments/development.rb
config.cache_classes = false
config.reload_classes_only_on_change = true

```
Puma設定変更時やGemfile変更時は効かない為、1を推奨

3. dockerでリスタート  
そのまま。アタッチが解除されるので面倒  
```bash
docker compose restart rails_app
```


## config/application.rb

- config.time_zone	タイムゾーンの設定	config.time_zone = 'Tokyo'
- config.i18n.default_locale	デフォルトの言語	config.i18n.default_locale = :ja
- config.i18n.available_locales	使用可能なロケール一覧	config.i18n.available_locales = [:ja, :en]
- config.eager_load_paths	本番環境で読み込むパス追加	config.eager_load_paths << Rails.root.join("lib")
- config.autoload_paths	開発中に自動読み込み対象にする	config.autoload_paths << Rails.root.join("lib")
- config.load_defaults	バージョンごとの初期設定ロード	config.load_defaults 7.1
- config.api_only	APIモードで生成されたかどうか	config.api_only = true（falseなら通常）
- config.generators	rails g の挙動制御	`config.generators do
- config.active_record.schema_format	スキーマの出力形式	:ruby（デフォ） or :sql
- config.active_job.queue_adapter	ジョブのバックエンド設定	config.active_job.queue_adapter = :sidekiq
- config.assets.enabled	Sprockets有効化（APIモードではfalse）	config.assets.enabled = true
- config.middleware.use	ミドルウェアの追加	config.middleware.use Rack::Attack

## セキュリティ

| 対策内容                         | Rails標準対応                             |
| ---------------------------- | ------------------------------------- |
| CSRF対策                       | `protect_from_forgery`（デフォルトON）       |
| SQLインジェクション対策                | ActiveRecordがバインド変数ベースで自動対応           |
| XSS対策                        | ERBの自動エスケープ（`<%=` はhtml\_safeでない限り）   |
| パスワードハッシュ                    | Devise + bcryptで自動対応                  |
| セッション固定攻撃対策                  | Railsが自動でセッションIDをログイン時に再生成            |
| レート制限                        | なし（Rack::Attackで強化できる）                |
| Content Security Policy(CSP) | Rails 6.0以降は `secure_headers` 相当が標準搭載 |
| クエリの正規表現DoS対策                | Rails 8では `Regexp.timeout` が標準設定      |

### セキュリティ系gem

| Gem名             | 用途                     | 導入判断の目安                       |
| ---------------- | ---------------------- | ----------------------------- |
| `rack-attack`    | レート制限、IPブロックなど         | API提供あり or 不特定多数がアクセスするなら◎    |
| `secure_headers` | CSP/iframe制御/HSTSなどの強化 | 標準のCSPが物足りなければ                |
| `brakeman`       | 静的セキュリティスキャンツール        | 開発初期やCIに組み込みたい時に◎（gemではなく別実行） |
| `sentry-rails`   | エラー監視（セキュリティではないが重要）   | 本番環境で障害検知強化したい時               |


## ミドルウェア

RailsではRack  
処理のイメージは以下  
Webサーバー→ Rackミドルウェア（複数挟める）→ RailsのController

### 登録方法

例）アクセスログを出力する

1. ミドルウェアの作成

lib/middleware以下にクラスを作成し、def call(env)の中に処理を記載する

2. 登録

config/application.rbに登録をする。  
```rb
# 読み込み順を明示的に指定する場合
config.middleware.insert_before 0, "AccessLogger"
# もしくは以下。読み込み順が不要であれば以下でもいい。
config.middleware.use AccessLogger

# autoload設定
config.autoload_paths << Rails.root.join('lib/middleware')
```

## 開発時

本番では使用しない。(してはいけない)

- DBリセット  

```bash
rails db:migrate:reset
```

- seed

```bash
# migrate + seed
rails db:reset
# seed load
rails db:seed
# seed reset
rails db:seed:replant 
```

- viteサーバ起動

```bash
npm run dev
# or
bin/vite dev
```

## リリース時の注意

configでアセットを圧縮している場合、
css,jsはプリコンパイルが必要(圧縮はほぼ必須)  
```bash
rails assets:precompile
```

viteを使ってる場合はvite buildが別途必要
```bash
npm run build
```

アセットの削除
```bash
assets:clobber
```


> 参考  
https://railsguides.jp/
https://www.sejuku.net/blog/13378