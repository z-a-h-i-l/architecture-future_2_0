| Событие | Контекст-источник | Семантика | Минимальный контракт (ключевые поля) | Подписчики |
|---------|-------------------|-----------|-------------------------------------|-----------|
| `PatientRegistered` | Clinic Context | Новый пациент зарегистрирован в системе. | `patientId`, `fullName`, `birthDate`, `registrationDate` | Analytics, Fintech (для создания финансового профиля) |
| `AppointmentScheduled` | Clinic Context | Пациенту назначен приём. | `appointmentId`, `patientId`, `doctorId`, `scheduledTime` | Analytics, AI (если требуется предобработка) |
| `DiagnosisCreated` | Clinic Context | Врач поставил диагноз (после приёма или ИИ-ассистента). | `diagnosisId`, `patientId`, `doctorId`, `icdCode`, `description` | Analytics, Fintech (для страховых случаев) |
| `AIAnalysisRequested` | Clinic Context | Отправлен запрос на ИИ-анализ снимка/исследования. | `requestId`, `patientId`, `studyType`, `imageUrl` | AI Context |
| `AIAnalysisCompleted` | AI Context | ИИ-сервис завершил анализ, готов результат. | `requestId`, `resultId`, `findings`, `confidence` | Clinic Context (обновление карты), Analytics |
| `CreditAgreementSigned` | Fintech Context | Клиент подписал кредитный договор. | `agreementId`, `customerId`, `amount`, `rate`, `signDate` | Analytics |
| `PaymentProcessed` | Fintech Context | Платёж по счёту/кредиту обработан. | `paymentId`, `agreementId`, `amount`, `timestamp` | Analytics, Clinic (если оплата за услуги) |
| `InventoryItemUsed` | Clinic Context | Медикамент/расходник использован во время процедуры. | `itemId`, `patientId`, `quantity`, `procedureId` | Analytics, Pharma Context (для автозаказа) |
| `DeviceAlertGenerated` | Device Context | Оборудование сообщило об ошибке или превышении порога. | `deviceId`, `alertType`, `value`, `timestamp` | Analytics, Clinic (для обслуживания) |
| `RecipeIssued` | Pharma Context | Выписан электронный рецепт. | `recipeId`, `patientId`, `medicationId`, `dosage` | Clinic Context, Analytics |