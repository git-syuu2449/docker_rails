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

# 作業ディレクトリ
WORKDIR /app

# GemfileとGemfile.lockを先にコピー # new後に有効化
COPY ./Gemfile ./Gemfile.lock ./

# bundlerとGemのインストール # new後に有効化
RUN gem install bundler && bundle install

# アプリケーションファイル全体をコピー
COPY . .

# ポート公開（開発用に3000）
EXPOSE 3000

# 実行ユーザー切替
USER ${USERNAME}

CMD ["bundle", "exec", "puma", "-C", "config/puma.rb"]
