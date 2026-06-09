# envs/dev/variables.tf

# ---- Переменные для провайдера ----
variable "cloud_id" {
  description = "Идентификатор облака Yandex Cloud"
  type        = string
}

variable "folder_id" {
  description = "Идентификатор каталога в облаке"
  type        = string
}

variable "service_account_key_file" {
  description = "Путь к файлу авторизованного ключа сервисного аккаунта (JSON)"
  type        = string
  default     = null
}

variable "token" {
  description = "IAM-токен (если не используется сервисный аккаунт)"
  type        = string
  default     = null
  sensitive   = true
}

# ---- Переменные для модуля виртуальной машины ----
variable "vm_name" {
  description = "Имя виртуальной машины"
  type        = string
}

variable "cores" {
  description = "Количество vCPU"
  type        = number
}

variable "memory" {
  description = "Объём RAM (ГБ)"
  type        = number
}

variable "image_id" {
  description = "Идентификатор загрузочного образа (Ubuntu, CentOS и т.д.)"
  type        = string
}

variable "subnet_id" {
  description = "Идентификатор подсети, к которой подключится ВМ"
  type        = string
}

variable "zone" {
  description = "Зона доступности (например, ru-central1-a)"
  type        = string
}

variable "ssh_public_key" {
  description = "Публичный SSH-ключ для доступа к ВМ"
  type        = string
}

variable "additional_disk_size" {
  description = "Размер дополнительного диска (ГБ)"
  type        = number
  default     = 10
}