terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "3.0.2"
    }
  }
}

provider "docker" {
  host = "npipe:////./pipe/docker_engine"
}

resource "docker_image" "nginx_demos_image" {
  name = "nginxdemos/hello"

}

resource "docker_container" "container_nginx" {
  name  = "nginx_container"
  image = docker_image.nginx_demos_image.name
  ports {
    external = 8000
    internal = 80
  }
}
