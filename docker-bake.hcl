group "default" {
  targets = ["backend", "frontend"]
}

target "backend" {
  context = "./backend"
  dockerfile = "Dockerfile"
  tags = ["leafnoise-backend:latest"]
}

target "frontend" {
  context = "./frontend"
  dockerfile = "Dockerfile"
  contexts = {
    nginx = "./nginx"
  }
  tags = ["leafnoise-frontend:latest"]
}

