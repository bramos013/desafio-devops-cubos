FROM prom/prometheus:latest
LABEL authors="bruno"

COPY prometheus.yml /etc/prometheus/prometheus.yml
WORKDIR /etc/prometheus

CMD [ "--config.file=/etc/prometheus/prometheus.yml" ]
