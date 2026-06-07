# envs/dev/main.tf

terraform {
  required_providers {
    yandex = {
      source  = "yandex-cloud/yandex"
      version = "~> 0.95"
    }
  }
  required_version = ">= 1.0"
}

provider "yandex" {
  cloud_id  = var.cloud_id
  folder_id = var.folder_id
  zone      = var.zone

  # Аутентификация сервисным аккаунтом (рекомендовано)
  service_account_key_file = var.service_account_key_file

  # Альтернатива — IAM-токен (для локальной разработки)
  # token = var.token
}

# Вызов переиспользуемого модуля виртуальной машины
module "vm" {
  source = "../../modules/vm"

  vm_name              = var.vm_name
  cores                = var.cores
  memory               = var.memory
  image_id             = var.image_id
  subnet_id            = var.subnet_id
  zone                 = var.zone
  ssh_public_key       = var.ssh_public_key
  additional_disk_size = var.additional_disk_size
}