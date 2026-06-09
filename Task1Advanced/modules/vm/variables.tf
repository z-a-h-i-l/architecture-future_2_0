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
  description = "Идентификатор образа загрузочного диска"
  type        = string
}

variable "subnet_id" {
  description = "Идентификатор подсети"
  type        = string
}

variable "zone" {
  description = "Зона доступности"
  type        = string
}

variable "ssh_public_key" {
  description = "Публичный SSH-ключ для доступа к ВМ"
  type        = string
}

variable "additional_disk_size" {
  description = "Размер подключаемого дополнительного диска (ГБ)"
  type        = number
  default     = 10
}