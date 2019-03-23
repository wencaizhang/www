#!/usr/bin/env sh

# 确保脚本抛出遇到的错误
set -e

git submodule update --remote

# 替换主题配置文件
cp ./_config-theme.yml themes/hexo-theme/_config.yml -f


docker build -t hexo-site:v1 . 
docker stop hexo-site
docker rm hexo-site
docker run -d -p 4000:80 -p 4001:4000 --name="hexo-site" hexo-site:v1 

echo "docker 部署成功！"
