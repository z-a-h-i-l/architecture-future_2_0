variable "cloud_id" {
  description = "ID облака Yandex Cloud"
  type        = string
}

variable "folder_id" {
  description = "ID каталога"
  type        = string
}

variable "zone" {
  description = "Зона доступности"
  type        = string
  default     = "ru-central1-a"
}

variable "backend_bucket" {
  description = "Имя бакета Object Storage для состояния"
  type        = string
}

variable "network_name" {
  description = "Имя облачной сети"
  type        = string
}

variable "subnet_name" {
  description = "Имя подсети"
  type        = string
}

variable "subnet_cidr" {
  description = "CIDR подсети"
  type        = string
}