terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 3.0.2"
    }
  }
}

provider "docker" {
  host = "unix:///var/run/docker.sock"
}

resource "docker_image" "node_image" {
  name = "siri1419/terraform-node-app"
  build {
    context    = "."
    dockerfile = "Dockerfile"
  }
}

resource "docker_container" "node_app" {
  name  = "terraform-node-container"
  image = docker_image.node_image.name

  ports {
    internal = 3000
    external = 3000
  }
}

