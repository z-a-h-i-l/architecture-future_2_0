output "instance_id" {
  description = "Идентификатор виртуальной машины"
  value       = yandex_compute_instance.vm.id
}

output "instance_name" {
  description = "Имя виртуальной машины"
  value       = yandex_compute_instance.vm.name
}

output "external_ip" {
  description = "Внешний IP-адрес ВМ"
  value       = yandex_compute_instance.vm.network_interface.0.nat_ip_address
}

output "additional_disk_id" {
  description = "Идентификатор дополнительного диска"
  value       = yandex_compute_disk.additional.id
}