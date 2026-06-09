```mermaid
graph TD
    subgraph "Медицинские услуги (Clinic Context)"
        MedCore[Ядро клиники]
        MedEHR[Электронные медкарты]
        MedInventory[Инвентаризация]
    end

    subgraph "Финансовые услуги (Fintech Context)"
        FinCore[Банковские продукты]
        FinCredit[Кредитование]
        FinAccounts[Счета и платежи]
    end

    subgraph "ИИ-сервисы (AI Context)"
        AIInference[Инференс моделей]
        AITraining[Обучение моделей]
        AIResults[Результаты анализов]
    end

    subgraph "Фармацевтика (Pharma Context)"
        PharmSupply[Поставки лекарств]
        PharmRecipes[Электронные рецепты]
    end

    subgraph "Электроника (Device Context)"
        DeviceMgmt[Управление устройствами]
        DeviceData[Телеметрия]
    end

    subgraph "Аналитика и отчётность (Analytics Context)"
        AnalyticsPortal[Портал самообслуживания]
        AnalyticsOLAP[OLAP-хранилище]
        AnalyticsLake[Data Lake]
    end

    MedCore -->|события| EventBus{{Event Bus - Kafka}}
    MedEHR -->|события| EventBus
    FinCore -->|события| EventBus
    AIResults -->|события| EventBus
    PharmSupply -->|события| EventBus
    DeviceData -->|события| EventBus

    EventBus --> AnalyticsLake
    EventBus --> AnalyticsOLAP
    AnalyticsOLAP --> AnalyticsPortal
```

**Описание границ:**
- **Clinic Context** – все аспекты медицинского обслуживания, включая приемы, истории болезней и инвентаризацию клиник. Не включает ИИ-обработку (только отправляет задания и получает результаты).
- **Fintech Context** – банковские услуги: счета, кредиты, финансовые операции клиентов.
- **AI Context** – независимый домен, предоставляющий услуги ИИ-анализа медицинских данных (снимки, диагностика). Получает задания через события, публикует результаты.
- **Pharma Context** – интеграция с фармацевтическими партнёрами, учёт рецептов и поставок.
- **Device Context** – производитель и поставщик медицинского оборудования; передаёт телеметрию и события о состоянии устройств.
- **Analytics Context** – потребитель всех событий, строит отчёты и витрины данных, обеспечивает self-service аналитику без доступа к чувствительным медицинским записям.
