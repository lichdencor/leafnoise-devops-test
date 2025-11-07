group "default" {
  targets = ["backend", "frontend"]
}

target "backend" {
  context = "./backend"
  dockerfile = "Dockerfile"
  args = {
    GITHUB_ACTOR = "${GITHUB_ACTOR}"
  }
  tags = ["leafnoise-backend:latest"]
}

target "frontend" {
  context = "./frontend"
  dockerfile = "Dockerfile"
  contexts = {
    nginx = "./nginx"
  }
  args = {
    GITHUB_ACTOR = "${GITHUB_ACTOR}"
  }
  tags = ["leafnoise-frontend:latest"]
}

