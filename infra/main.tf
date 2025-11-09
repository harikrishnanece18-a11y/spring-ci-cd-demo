terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 3.0"
    }
  }
}

provider "docker" {}

resource "docker_image" "spring_app" {
  name = "spring-demo:latest"
  build {
    context = "../"  # Adjust if needed
  }
}

resource "docker_container" "spring_container" {
  name  = "spring-demo-container"
  image = docker_image.spring_app.name
  ports {
    internal = 8080
    external = 8080
  }
}

output "app_url" {
  value = "http://localhost:8080"
}