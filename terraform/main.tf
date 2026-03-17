# Habilitar la API de Cloud Run
resource "google_project_service" "run_api" {
  project = var.project_id
  service = "run.googleapis.com"
  disable_on_destroy = false
}

# Habilitar Artifact Registry (donde se guardarán tus imágenes de Docker)
resource "google_project_service" "registry_api" {
  project = var.project_id
  service = "artifactregistry.googleapis.com"
  disable_on_destroy = false
}

# Habilitar la API de Compute Engine (necesaria para la red VPC)
resource "google_project_service" "compute_api" {
  project = var.project_id
  service = "compute.googleapis.com"
  disable_on_destroy = false
}

# Crear el repositorio en Artifact Registry para tus imágenes
resource "google_artifact_registry_repository" "repo" {
  location      = var.region
  repository_id = var.repository_id
  description   = "Docker repository for DevOps ecosystem"
  format        = "DOCKER"

  depends_on = [google_project_service.registry_api]
}
