# Este bloque descarga el "traductor" de Google Cloud
terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 4.0"
    }
  }
}

# Este bloque configura a qué "bodega" (proyecto) vamos a entrar
provider "google" {
  project = var.project_id # Usando la variable definida en variables.tf
  region  = var.region     # Usando la variable definida en variables.tf
}
