resource "docker_volume" "sql-data" {
    name = "terraform-cubos-sql-volume-data"
    driver = "local"
}

resource "docker_volume" "sql-logs" {
  name = "terraform-cubos-sql-volume-logs"
  driver = "local"
}

resource "docker_volume" "sql-init" {
    name = "terraform-cubos-sql-volume-init"
    driver = "local"
}

