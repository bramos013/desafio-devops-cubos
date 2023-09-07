resource "docker_image" "cubos-sql" {
  name = "terraform-cubos-sql"

  build {
    context    = "../../sql"
    dockerfile = "Dockerfile"
  }
}

resource "docker_image" "cubos-backend" {
  name = "terraform-cubos-backend"

  build {
    context    = "../../backend"
    dockerfile = "Dockerfile"
  }
}

resource "docker_image" "cubos-frontend" {
  name         = "terraform-cubos-frontend"

  build {
    context    = "../../frontend"
    dockerfile = "Dockerfile"
  }
}
