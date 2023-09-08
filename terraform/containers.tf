resource "docker_container" "cubos-prometheus" {
  image = docker_image.cubos-prometheus.image_id
  name  = "cubos-prometheus"
  restart = "always"

  networks_advanced {
    name = docker_network.monitoring-network.name
  }

  ports {
    internal = 9090
    external = 9090
  }

  volumes {
    volume_name = "cubos-prometheus-volume"
    container_path = "/etc/prometheus/"
    host_path = "/prometheus"
  }
}

resource "docker_container" "grafana" {
  image      = "grafana/grafana:latest"
  name       = "grafana"
  restart    = "always"
  depends_on = [
    docker_container.cubos-prometheus
  ]

  ports {
    internal = 3000
    external = 3000
  }
  networks_advanced {
    name = docker_network.monitoring-network.name
  }
}

resource "docker_container" "cubos-sql" {
  image = docker_image.cubos-sql.image_id
  name  = "cubos-sql"
  restart = "on-failure"
  depends_on = [
    docker_container.cubos-prometheus
  ]

  env = [
    "POSTGRES_USER=${var.POSTGRES_USER}",
    "POSTGRES_PASSWORD=${var.POSTGRES_PASSWORD}",
    "POSTGRES_DB=${var.POSTGRES_DB}"
  ]

  networks_advanced {
    name = docker_network.sql-network.name
  }

  networks_advanced {
    name = docker_network.monitoring-network.name
  }

  volumes {
    volume_name = "cubos-sql-volume-logs"
    container_path = "/var/log/postgresql"
    host_path = "/sql/log"
  }

  volumes {
    volume_name = "cubos-sql-volume-data"
    container_path = "/var/lib/postgresql/data"
    host_path = "/sql/data"
  }
}

resource "docker_container" "cubos-backend" {
  image = docker_image.cubos-backend.image_id
  name  = "cubos-backend"
  restart = "on-failure"
  depends_on = [
    docker_container.cubos-prometheus,
    docker_container.cubos-sql
  ]

  env = [

    "user=${var.user}",
    "pass=${var.pass}",
    "host=${var.host}",
    "db_port=${var.db_port}",
    "database=${var.database}"
  ]

  networks_advanced {
    name = docker_network.frontend-network.name
  }

  networks_advanced {
    name = docker_network.monitoring-network.name
  }

  volumes {
    volume_name = "cubos-backend-volume"
    container_path = "/usr/src/app"
    host_path = "/backend"
  }
}

resource "docker_container" "cubos-frontend" {
  image = docker_image.cubos-frontend.image_id
  name  = "cubos-frontend"
  restart = "on-failure"
  depends_on = [
    docker_container.cubos-prometheus,
    docker_container.cubos-sql,
    docker_container.cubos-backend
  ]

  networks_advanced {
    name = docker_network.frontend-network.name
  }

  networks_advanced {
    name = docker_network.sql-network.name
  }

  networks_advanced {
    name = docker_network.monitoring-network.name
  }

  ports {
    internal = var.frontend_port
    external = var.frontend_port
  }

  volumes {
    volume_name = "cubos-frontend-volume"
    container_path = "/usr/src/app"
    host_path = "/frontend"
  }
}
