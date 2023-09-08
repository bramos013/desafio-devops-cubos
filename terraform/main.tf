terraform {
  required_version = "1.5.6"
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "3.0.2"
    }
  }
}

provider "docker" {
  host = "unix:///var/run/docker.sock"
}

resource "null_resource" "create-aliases" {
  depends_on = [
    docker_container.cubos-backend,
    docker_container.cubos-frontend,
  ]

  provisioner "local-exec" {
    command = "docker network connect --alias cubos-backend sql-network ${docker_container.cubos-backend.name}"
  }
}
