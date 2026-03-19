resource "google_compute_network" "vpc" {
    name = "tp-gcp-vpc"
    auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "subnet" {
    name = "tp-gcp-subnet"
    region = var.region
    ip_cidr_range = "10.0.1.0/24"
    network = google_compute_network.vpc.id
}

resource "google_compute_firewall" "allow_ssh"{
    name = "tp-gcp-ssh"
    network = google_compute_network.vpc.name
    
    allow{
        protocol = "tcp"
        ports = ["22"]
    }
    source_ranges = ["0.0.0.0/0"]
    target_tags   = ["tp-gcp-ssh"]
}

resource "google_compute_firewall" "allow_web"{
    name = "tp-gcp-nginx"
    network = google_compute_network.vpc.name

    allow{
        protocol = "tcp"
        ports = ["80"]
    }
    source_ranges = ["0.0.0.0/0"]
    target_tags   = ["tp-gcp-web"]
}
