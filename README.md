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

Выбран движок  CI/CD - GitLab.
- Отраслевой стандарт
- [Личное мнение] Я не очень люблю GitHub Actions
- Более удобный (на мой взгляд) и функциональный, чем Jenkins

## Предварительные требования
- Yandex Cloud: облако, каталог, сервисный аккаунт с ролями `editor` и `storage.uploader`.
- Object Storage: бакет для tfstate (рекомендуется включить версионирование).
- GitLab репозиторий.

## Переменные GitLab CI/CD

| Имя переменной            | Тип       | Описание |
|---------------------------|-----------|----------|
| `YC_SERVICE_ACCOUNT_KEY`  | Variable  | JSON-содержимое ключа сервисного аккаунта Yandex Cloud. |
| `BACKEND_ACCESS_KEY`      | Variable  | Статический ключ доступа Object Storage (access_key). |
| `BACKEND_SECRET_KEY`      | Variable  | Секретный ключ (secret_key). |
| `CLOUD_ID`                | Variable  | ID облака. |
| `FOLDER_ID`               | Variable  | ID каталога. |
| `BACKEND_BUCKET`          | Variable  | Имя бакета Object Storage. |

Рекомендуется пометить переменные `BACKEND_SECRET_KEY` и `YC_SERVICE_ACCOUNT_KEY` как **protected** и **masked**.

## Работа пайплайна
- **init** – инициализация Terraform с подключением к удалённому состоянию.
- **plan** – формирование плана изменений и сохранение артефакта `tfplan`.
- **apply** – ручной шаг (кнопка «Run» в пайплайне), выполняется только на ветке `main`. Применяет ранее созданный план.

## Локальный запуск (для отладки)
Создайте файл `terraform.tfvars` по образцу `terraform.tfvars.example`.  
Установите переменные окружения:
```bash
export YC_SERVICE_ACCOUNT_KEY_FILE=путь_к_ключу.json
export BACKEND_ACCESS_KEY=...
export BACKEND_SECRET_KEY=...