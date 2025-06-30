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
  yarn \
  bash \
  git \
  curl \
  sudo \
  && rm -rf /var/lib/apt/lists/*

# nodejsを別途インストール(apt-getは古い為)
RUN curl -fsSL https://deb.nodesource.com/setup_20.x | bash - \
 && apt-get install -y nodejs \
 && npm install -g npm vite vue


# ユーザー作成 + sudo権限付与
RUN groupadd -g ${U_ID} ${GROUPNAME} \
 && useradd -u ${G_ID} -g ${GROUPNAME} -m ${USERNAME} \
 && echo "${USERNAME} ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

 # ------------------------------

# 作業ディレクトリ(Docker関連がある場所) docker/web/Dockerfile
WORKDIR /app

# pumaのバインド先のディレクトリを作成
RUN mkdir -p /app/rails_app/tmp/sockets

# アプリケーション用のディレクトリで作業
WORKDIR /app/rails_app

# ------------------------------

# ポート公開（開発用に3000）
EXPOSE 3000

# 実行ユーザー切替
USER ${USERNAME}

# rails new後に使用可能。初回はsleep infinityする
CMD ["bash", "-c", "bundle install && bundle exec puma -C config/puma.rb"]
# CMD ["bash", "-c", "bundle install && rails s -b 0.0.0.0"]
