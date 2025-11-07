group "default" {
  targets = ["backend", "frontend"]
}

# contexto Backend
target "backend" {
  context = "./backend"
  dockerfile = "Dockerfile"
  tags = ["leafnoise-backend:latest"]
}

# contexto Frontend
target "frontend" {
  context = "./frontend"
  dockerfile = "Dockerfile"
  contexts = {
    nginx = "./nginx"    # nginx/ como contexto adicional
  }
  tags = ["leafnoise-frontend:latest"]
}

