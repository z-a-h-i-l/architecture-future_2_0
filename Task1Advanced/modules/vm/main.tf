resource "yandex_compute_disk" "additional" {
  name       = "${var.vm_name}-data"
  type       = "network-hdd"
  zone       = var.zone
  size       = var.additional_disk_size
}

resource "yandex_compute_instance" "vm" {
  name        = var.vm_name
  zone        = var.zone
  platform_id = "standard-v2"

  resources {
    cores  = var.cores
    memory = var.memory
  }

  boot_disk {
    initialize_params {
      image_id = var.image_id
      size     = 30
    }
  }

  secondary_disk {
    disk_id = yandex_compute_disk.additional.id
  }

  network_interface {
    subnet_id = var.subnet_id
    nat       = true
  }

  metadata = {
    ssh-keys = "ubuntu:${var.ssh_public_key}"
  }
}