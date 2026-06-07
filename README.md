# Задание 1

## Создана папка Task1Advanced
```bash
Task1Advanced/
├── envs
│   ├── dev
│   │   ├── main.tf
│   │   ├── terraform.tfvars
│   │   └── variables.tf
│   ├── prod
│   │   ├── main.tf
│   │   ├── terraform.tfvars
│   │   └── variables.tf
│   └── stage
│       ├── main.tf
│       ├── terraform.tfvars
│       └── variables.tf
├── modules
│   └── vm
│       ├── main.tf
│       ├── outputs.tf
│       └── variables.tf
└── README.md
```

## Модуль виртуальной машины (vm_module)

Универсальный Terraform-модуль для создания виртуальной машины с дополнительным диском в Yandex Cloud.  
Поддерживает параметризацию ресурсов и конфигурацию через `.tfvars` для разных окружений (dev, stage, prod).

## Параметры модуля

| Переменная            | Тип    | Описание                                      | По умолчанию |
|-----------------------|--------|-----------------------------------------------|--------------|
| vm_name               | string | Имя ВМ                                        | —            |
| cores                 | number | Количество vCPU                               | —            |
| memory                | number | Объём RAM (ГБ)                                | —            |
| image_id              | string | ID образа загрузочного диска                  | —            |
| subnet_id             | string | ID подсети                                    | —            |
| zone                  | string | Зона доступности                              | —            |
| ssh_public_key        | string | Публичный SSH-ключ                            | —            |
| additional_disk_size  | number | Размер дополнительного диска (ГБ)             | 10           |

## Выходные переменные (outputs)

- `instance_id` – ID виртуальной машины.
- `instance_name` – Имя виртуальной машины.
- `external_ip` – Внешний IP-адрес (NAT).
- `additional_disk_id` – ID дополнительного диска данных.

## Как использовать

### Подготовка

1. Установите Terraform (>= 1.0).
2. Настройте аутентификацию Yandex Cloud (через `YC_TOKEN` или сервисный аккаунт).
3. Подставьте актуальные `image_id`, `subnet_id`, `zone` и SSH-ключ в файлы `.tfvars`.

### Запуск для конкретного окружения (dev)

```bash
cd envs/dev
terraform init
terraform plan -var-file="terraform.tfvars"
terraform apply -var-file="terraform.tfvars"
```

# Задание 2

