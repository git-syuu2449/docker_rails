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




# bundle

- bundle add

- bundle install


bundleのパスはBUNDLE_PATHにて管理  
railsインストール時にdockerfileが生成されるのは確認する。  