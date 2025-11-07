# LeafNoise - DevOps Jr Challenge

Solución del desafío técnico de DevOps Jr para LeafNoise: dockerización y orquestación de aplicaciones Flask y Angular.

## Estructura del Proyecto

Este proyecto utiliza Git submodules para organizar los componentes:

```
leafnoise-devops-test/
├── backend/  → https://github.com/lichdencor/Flask-Example
├── frontend/ → https://github.com/lichdencor/angular-realworld-example-app
├── docker-bake.hcl
├── docker-compose.yml
└── .github/workflows/docker-publish.yml
```

Los Dockerfiles están definidos en cada submódulo fork:
- Backend: https://github.com/lichdencor/Flask-Example
- Frontend: https://github.com/lichdencor/angular-realworld-example-app

## Detalles de Implementación

### Docker Bake

El proyecto usa `docker-bake.hcl` para manejar el build con contextos múltiples. Esto permite leer archivos como `nginx.conf` desde dentro del submódulo frontend.

```bash
docker buildx bake
```

### CI/CD

El workflow de GitHub Actions hace checkout completo del repositorio parent pero usa shallow checkout para los submódulos. Los repos base tienen histories extensas que no son necesarias para el build, esto reduce el tiempo de clonado.

El pipeline usa `docker/bake-action` para construir las imágenes y las publica en GitHub Container Registry (GHCR).

### Docker Compose

Los servicios están expuestos en:
- Frontend: `localhost:4200`
- Backend: `localhost:6969`

## Instalación

### Opción 1: Usar Imágenes Pre-construidas (Recomendado)

```bash
# Clonar solo el parent (sin submódulos)
git clone https://github.com/lichdencor/leafnoise-devops-test.git
cd leafnoise-devops-test

# Levantar servicios usando imágenes de GHCR
docker compose up
```

Las imágenes se descargan automáticamente desde GitHub Container Registry.

### Opción 2: Build Local

Si necesitás modificar los Dockerfiles o trabajar en desarrollo:

```bash
# Clonar con submódulos
git clone --recurse-submodules https://github.com/lichdencor/leafnoise-devops-test.git
cd leafnoise-devops-test

# Levantar servicios con build
docker compose up --build
```

Si ya clonaste sin submódulos:
```bash
git submodule update --init --recursive
```

## Uso de Imágenes Pre-construidas

Las imágenes están disponibles en GHCR y se usan automáticamente con `docker compose up`:

- `ghcr.io/lichdencor/leafnoise-frontend:latest`
- `ghcr.io/lichdencor/leafnoise-backend:latest`

Para descargarlas manualmente:
```bash
docker pull ghcr.io/lichdencor/leafnoise-frontend:latest
docker pull ghcr.io/lichdencor/leafnoise-backend:latest
```

## Comandos Útiles

### Submódulos

```bash
# Actualizar submódulos
git submodule update --remote

# Ver estado
git submodule status
```

### Docker Compose

```bash
# Ver logs
docker compose logs -f

# Reiniciar servicio
docker compose restart frontend

# Limpiar
docker compose down -v
```

### Docker Bake

```bash
# Build específico
docker buildx bake frontend
docker buildx bake backend

# Ver configuración
docker buildx bake --print
```

## Troubleshooting

**Los contenedores no inician:**
```bash
docker compose logs
```

**Puerto ocupado:**
Modificar los puertos en `docker-compose.yml`

**Problemas con submódulos:**
```bash
git submodule update --init --recursive --force
```

## Estado de Implementación

| Componente | Estado |
|------------|--------|
| Dockerfile backend | ✅ |
| Dockerfile frontend | ✅ |
| Docker Bake | ✅ |
| CI/CD + GHCR | ✅ |
| Docker Compose | ✅ |
| Kubernetes | Pendiente |

## Enlaces

- Parent: https://github.com/lichdencor/leafnoise-devops-test
- Backend: https://github.com/lichdencor/Flask-Example
- Frontend: https://github.com/lichdencor/angular-realworld-example-app
- Registry: https://github.com/lichdencor?tab=packages

## Notas

### Por qué Bake
Permite configurar contextos complejos de forma declarativa. Útil para leer archivos desde submódulos sin copiar o modificar estructura.

### Por qué Shallow Checkout
Los repos base tienen 200+ commits. El shallow checkout reduce tiempo de clone sin afectar el build.

### Por qué Submódulos
Mantiene separación de componentes y permite trackear los repos originales para updates.
