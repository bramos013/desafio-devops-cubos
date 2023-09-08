resource "docker_container" "cubos-sql" {
  image = docker_image.cubos-sql.image_id
  name  = "cubos-sql"
  restart = "on-failure"

  env = [
    "POSTGRES_USER=admin",
    "POSTGRES_PASSWORD=secure_p4$$w0rd",
    "POSTGRES_DB=cubos"
  ]

  networks_advanced {
    name = docker_network.sql-network.name
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
    docker_container.cubos-sql
  ]

  env = [
    "user=admin",
    "pass=secure_p4$$w0rd",
    "host=cubos-sql",
    "db_port=5432",
    "database=cubos"
  ]

  networks_advanced {
    name = docker_network.frontend-network.name
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
    docker_container.cubos-sql,
    docker_container.cubos-backend
  ]

  networks_advanced {
    name = docker_network.frontend-network.name
  }

  networks_advanced {
    name = docker_network.sql-network.name
  }

  ports {
    internal = 80
    external = 80
  }

  volumes {
    volume_name = "cubos-frontend-volume"
    container_path = "/usr/src/app"
    host_path = "/frontend"
  }
}

