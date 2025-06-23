FROM ruby:3.4.2

# UID/GIDを引数(yamlのargs)で受け取る（デフォルト1000）
ARG U_ID=1000
ARG G_ID=1000
ARG USERNAME=appuser
ARG GROUPNAME=appgroup

# 必要なパッケージをインストール（PostgreSQL向け）
RUN apt-get update -qq && apt-get install -y \
  build-essential \
  libpq-dev \
  nodejs \
  yarn \
  bash \
  git \
  curl \
  sudo \
  && rm -rf /var/lib/apt/lists/*


# ユーザー作成 + sudo権限付与
RUN groupadd -g ${U_ID} ${GROUPNAME} \
 && useradd -u ${G_ID} -g ${GROUPNAME} -m ${USERNAME} \
 && echo "${USERNAME} ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

# 作業ディレクトリ(Docker関連がある場所) docker/web/Dockerfile
WORKDIR /app

# ------------------------------

# アプリケーション用ディレクトリが無ければ作成(初回用)
# RUN mkdir rails_app

RUN ls -la # debug

# # GemfileとGemfile.lockを先にコピー(初回用)
COPY rails_app/Gemfile rails_app/Gemfile.lock /app/rails_app/

# アプリケーション用のディレクトリで作業
WORKDIR /app/rails_app

# # bundlerとGemのインストール
RUN gem install bundler && bundle install

# pumaのバインド先のディレクトリを作成
RUN mkdir -p /app/rails_app/tmp/sockets

# # アプリケーションファイル全体をコピー
COPY . .

# ------------------------------

# ポート公開（開発用に3000）
EXPOSE 3000

# 実行ユーザー切替
USER ${USERNAME}

# rails new後に使用可能。初回はsleep infinityする
CMD ["bundle", "exec", "puma", "-C", "config/puma.rb"]
