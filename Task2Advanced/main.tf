terraform {
  required_providers {
    yandex = {
      source  = "yandex-cloud/yandex"
      version = "~> 0.95"
    }
  }

  # Удалённое состояние в Yandex Object Storage (S3-совместимый API)
  backend "s3" {
    endpoint                    = "https://storage.yandexcloud.net"
    bucket                      = var.backend_bucket
    key                         = "terraform/state/terraform.tfstate"
    region                      = "ru-central1"
    skip_region_validation      = true
    skip_credentials_validation = true
    skip_metadata_api_check     = true
    # Ключи доступа передаются при инициализации через -backend-config
  }
}

provider "yandex" {
  cloud_id  = var.cloud_id
  folder_id = var.folder_id
  zone      = var.zone
  # Аутентификация через сервисный аккаунт (файл ключа задаётся переменной окружения)
}

# Пример создаваемых ресурсов
resource "yandex_vpc_network" "this" {
  name = var.network_name
}

resource "yandex_vpc_subnet" "this" {
  name           = var.subnet_name
  v4_cidr_blocks = [var.subnet_cidr]
  zone           = var.zone
  network_id     = yandex_vpc_network.this.id
}