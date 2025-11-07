group "default" {
  targets = ["backend", "frontend"]
}

variable "VERSION" {
  default = "latest"
}

# --- Backend ---
target "backend" {
  context = "./backend"
  dockerfile = "Dockerfile"
  tags = [
    "ghcr.io/${GITHUB_ACTOR}/leafnoise-backend:${VERSION}"
  ]
}

# --- Frontend ---
target "frontend" {
  context = "./frontend"
  dockerfile = "Dockerfile"
  contexts = {
    nginx = "./nginx"
  }
  tags = [
    "ghcr.io/${GITHUB_ACTOR}/leafnoise-frontend:${VERSION}"
  ]
}
