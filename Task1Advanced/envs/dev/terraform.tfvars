# ---- Аутентификация и размещение ----
cloud_id                 = "b1g1a2b3c4d5e6f7g8h9"
folder_id                = "b1g9h8f7e6d5c4b3a2i1"
zone                     = "ru-central1-a"

# Используем сервисный аккаунт (укажите путь к вашему JSON-ключу)
service_account_key_file = "./keys/dev-sa-key.json"
# token можно не задавать, если применяется сервисный аккаунт

# ---- Параметры виртуальной машины ----
vm_name              = "dev-vm-01"
cores                = 2
memory               = 4
image_id             = "fd8q4t0q5f6g7h8i9j0k"   # ID образа, например Ubuntu 24.04 LTS
subnet_id            = "e9b2h3b4c5d6e7f8g9h0"   # ID вашей подсети
ssh_public_key       = "my_public_key" # сознательно не указываю свой публичный ключ
additional_disk_size = 10