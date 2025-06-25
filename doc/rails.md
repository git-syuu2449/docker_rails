# Railsについて

## 変更点

7→8.0.2にかけての変更点を抜粋

- Kamalが追加
- generateに認証機能が追加
- Bulk insert fixtures 対応
- クエリキャッシング対応
- スクリプトジェネレータ
- Hotwire標準化


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

これはviteの項を別途作って切り出すか。

1. 階層の変更

Railsのデフォルトは app/assets以下にstyleseets,images, app以下にjavascriptが存在する。  
viteを使用する場合のパスはapp/frontend/entrypoints/になる。  
erbでvite_stylesheet_tagを使用すると/vite/entrypoints/のパスが生成される。
これは、config/vite.json と vite-plugin-ruby の仕様に基づいて生成される。
/vite/entrypoints/... は仮想パスで、初期設定の場合は上のパスになる。

config/vite.json

entrypointsDir



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
