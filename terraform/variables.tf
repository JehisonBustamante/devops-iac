variable "project_id" {
  description = "El ID único de tu proyecto en Google Cloud"
  type        = string
}

variable "region" {
  description = "Región donde se desplegarán los servicios"
  type        = string
  default     = "us-central1"
}

variable "repository_id" {
  description = "Nombre del repositorio en Artifact Registry"
  type        = string
  default     = "devops-repo"
}

variable "services" {
  description = "Lista de microservicios definidos en el ecosistema"
  type        = map(string)
  default     = {
    nanoledger-api      = "nanoledger-api"
    eventhub-backend    = "eventhub-backend"
    eventhub-frontend   = "eventhub-frontend"
    cryptowatch-frontend = "cryptowatch-frontend"
  }
}
