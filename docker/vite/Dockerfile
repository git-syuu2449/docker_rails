FROM node:20

WORKDIR /app/rails_app

COPY ./rails_app/package*.json ./
RUN npm install

# ソースはvolumeでbindされるのでCOPY不要
