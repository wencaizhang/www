FROM node:8-slim

RUN apt-get update \
  && apt-get install -y nginx \
  && npm install -g cnpm pm2 --registry=https://registry.npm.taobao.org

WORKDIR /app

COPY package.json /app/package.json

RUN cnpm install 

COPY . /app/

RUN rm /var/www/html/* -rf \
  && npm run build \
  && mkdir /var/www/html -p \
  && cp -r public/* /var/www/html

COPY ./nginx.conf /etc/nginx/

ENTRYPOINT pm2 start /app/run.js && nginx
