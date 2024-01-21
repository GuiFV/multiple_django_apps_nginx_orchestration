FROM nginx:latest

WORKDIR /app

COPY conf.d/website_1.conf /etc/nginx/conf.d/
COPY conf.d/website_2.conf /etc/nginx/conf.d/