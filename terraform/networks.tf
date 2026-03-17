# 1. Creamos la red privada (VPC)
resource "google_compute_network" "vpc_network" {
  name                    = "devops-vpc"
  auto_create_subnetworks = false # Mejor práctica: nosotros controlamos las subredes
  
  # Aseguramos que la API esté habilitada antes de crear la red
  depends_on = [google_project_service.compute_api]
}

# 2. Creamos una subred en la región que elegimos (us-central1)
resource "google_compute_subnetwork" "vpc_subnet" {
  name          = "devops-subnet"
  ip_cidr_range = "10.0.1.0/24" # Un rango de IPs privadas para tus apps
  region        = var.region
  network       = google_compute_network.vpc_network.id
}
