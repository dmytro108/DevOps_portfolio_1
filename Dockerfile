FROM nginx
  # COPY ./src/index.html /usr/share/nginx/html
  COPY ./src/weather*.* /usr/share/nginx/html/weatherapicom/*
  COPY ./nginx/default.conf /etc/nginx/conf.d/*
