# Rails + Vite における View 構成ガイド

## 概要

本ドキュメントでは、Rails 7以降の `vite` を使用した構成において、共通テンプレートやページごとのCSS/JSの読み込み方法、Vueコンポーネントとの連携など、View構築のベース方針を記載します。

---

## 1. 共通テンプレート構成

共通のHTML構造（`<html>`, `<head>`, `<body>`）、共通のヘッダー/フッターなどは `app/views/layouts/application.html.erb` に定義し、パーシャルとして分離します。

### `app/views/layouts/application.html.erb`

```erb
<!DOCTYPE html>
<html>
  <head>
    <title>MyApp</title>
    <%= csrf_meta_tags %>
    <%= csp_meta_tag %>
    <%= vite_client_tag %>

    <%= yield :head %>

    <%= vite_stylesheet_tag 'application' %>
  </head>
  <body>
    <%= render 'shared/header' %>

    <main>
      <%= yield %>
    </main>

    <%= render 'shared/footer' %>

    <%= vite_javascript_tag 'application' %>
    <%= yield :scripts %>
  </body>
</html>
````

### ヘッダー・フッターの例

`app/views/shared/_header.html.erb`

```erb
<header>
  <nav>
    <%= link_to 'Home', root_path %>
    <%= link_to 'Users', users_path %>
  </nav>
</header>
```

`app/views/shared/_footer.html.erb`

```erb
<footer>
  <p>&copy; 2025 MyApp</p>
</footer>
```

---

## 2. ページごとのCSS / JSの読み込み

### headタグへの追加

```erb
<% content_for :head do %>
  <meta name="robots" content="noindex">
  <%= vite_stylesheet_tag 'pages/user' %>
<% end %>
```

### body終端でのJS追加

```erb
<% content_for :scripts do %>
  <%= vite_javascript_tag 'pages/user' %>
<% end %>
```

---

## 3. Viteのエントリポイント構成（例）

```plaintext
app/
└── frontend/
    ├── entrypoints/
    │   ├── application.js         # 共通JS
    │   └── pages/
    │       ├── user.js            # ユーザー用ページJS
    │       └── admin.js
    └── components/
        └── UserCard.vue
```

### ユーザーページ用 JS（例：`user.js`）

```js
import { createApp } from 'vue'
import UserCard from '../components/UserCard.vue'

document.querySelectorAll('[data-component="user-card"]').forEach((el) => {
  const user = JSON.parse(el.dataset.user)
  createApp(UserCard, { user }).mount(el)
})
```

---

## 4. Rails側ViewからVueコンポーネントを呼び出す構成

`app/views/users/show.html.erb`

```erb
<div data-component="user-card" data-user="<%= user.to_json %>"></div>

<% content_for :scripts do %>
  <%= vite_javascript_tag 'pages/user' %>
<% end %>
```

---

## 5. レイアウトの分岐（オプション）

ログイン前後や管理画面でレイアウトを変える場合は、controller側で `layout` を切り替えます。

```ruby
class Admin::BaseController < ApplicationController
  layout 'admin'
end
```

```erb
<!-- app/views/layouts/admin.html.erb -->
<html>
  ...
</html>
```

---

## 6. その他、必要に応じて記載すべき項目（追記候補）

* `vite-plugin-stimulus` や `vite-plugin-vue2/3` の導入方法（必要に応じて）
* production環境での asset precompilation 方法（`bin/vite build`）
* `vite-dev-server` の起動とポート設定
* Vue・ViteのHMRとRailsのホットリロードの併用注意点
* モジュールキャッシュ回避のための `?v=#{timestamp}` クエリ付加（必要時）

---

## まとめ

* 共通の大枠は `layouts/application.html.erb` に配置し、共通パーツは `shared/` に分離。
* ページ固有のCSS/JSは `content_for :head / :scripts` 経由で埋め込み。
* Vueコンポーネントは `data-component` 属性ベースでマウント。
* 拡張性が必要な画面にはレイアウト切り替えやViewComponent活用も検討。

```
