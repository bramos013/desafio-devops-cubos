resource "docker_image" "cubos-sql" {
  name = "cubos-sql"

  build {
    context    = "../sql"
    dockerfile = "Dockerfile"
  }
}

resource "docker_image" "cubos-backend" {
  name = "cubos-backend"

  build {
    context    = "../backend"
    dockerfile = "Dockerfile"
  }
}

resource "docker_image" "cubos-frontend" {
  name = "cubos-frontend"

  build {
    context    = "../frontend"
    dockerfile = "Dockerfile"
  }
}

resource "docker_image" "cubos-prometheus" {
  name = "cubos-prometheus"

    build {
        context    = "../prometheus"
        dockerfile = "Dockerfile"
    }
}
