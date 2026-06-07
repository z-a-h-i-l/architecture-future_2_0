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