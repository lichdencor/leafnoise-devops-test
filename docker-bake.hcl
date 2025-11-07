group "default" {
  targets = ["backend", "frontend"]
}

# Define variables that CI will inject via --set
variable "github_actor" {
  default = "lichdencor"
}

variable "version" {
  default = "latest"
}

target "backend" {
  context = "./backend"
  dockerfile = "Dockerfile"
  tags = [
    "ghcr.io/${github_actor}/leafnoise-backend:${version}"
  ]
}

target "frontend" {
  context = "./frontend"
  dockerfile = "Dockerfile"
  contexts = {
    nginx = "./nginx"
  }
  tags = [
    "ghcr.io/${github_actor}/leafnoise-frontend:${version}"
  ]
}

