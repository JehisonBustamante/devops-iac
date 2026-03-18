
# Definición del servicio de Cloud Run para el Backend
resource "google_cloud_run_service" "eventhub_backend" {
  name     = "eventhub-backend-service"
  location = var.region

  template {
    spec {
      containers {
        # Usamos la imagen que acabas de subir al Registry
        image = "${var.region}-docker.pkg.dev/${var.project_id}/${var.repository_id}/eventhub-backend:v2"

        ports {
          container_port = 3000
        }

        # ... dentro de containers ...
        env {
          name  = "DB_HOST"
          value = var.db_host
        }
        env {
          name  = "DB_PORT"
          value = "6543" # Este es fijo, no pasa nada si se queda así
        }
        env {
          name  = "DB_USERNAME"
          value = var.db_username
        }
        env {
          name  = "DB_PASSWORD"
          value = var.db_password
        }
        env {
          name  = "DB_DATABASE"
          value = "postgres"
        }
        env {
          name  = "JWT_SECRET"
          value = var.jwt_secret
        }
      }
    }
  }

  traffic {
    percent         = 100
    latest_revision = true
  }

  # Aseguramos que el repositorio exista antes de intentar desplegar
  depends_on = [google_artifact_registry_repository.repo]
}

# Hacer que el servicio sea público (puedes comentarlo si prefieres privado)
resource "google_cloud_run_service_iam_member" "public_access" {
  service  = google_cloud_run_service.eventhub_backend.name
  location = google_cloud_run_service.eventhub_backend.location
  role     = "roles/run.invoker"
  member   = "allUsers"
}

# Output para obtener la URL al finalizar
output "eventhub_backend_url" {
  value = google_cloud_run_service.eventhub_backend.status[0].url
}