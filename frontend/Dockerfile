FROM nginx:latest
LABEL authors="Bruno Ramos"

COPY index.html /usr/share/nginx/html/index.html
COPY conf/cubos.conf /etc/nginx/conf.d/cubos.conf

CMD ["nginx", "-g", "daemon off;"]
