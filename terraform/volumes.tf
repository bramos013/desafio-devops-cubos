resource "docker_volume" "sql-data" {
    name = "cubos-sql-volume-data"
    driver = "local"
}

resource "docker_volume" "sql-logs" {
  name = "cubos-sql-volume-logs"
  driver = "local"
}

resource "docker_volume" "sql-init" {
    name = "cubos-sql-volume-init"
    driver = "local"
}

resource "docker_volume" "prometheus-data" {
    name = "cubos-prometheus-volume-data"
    driver = "local"
}
