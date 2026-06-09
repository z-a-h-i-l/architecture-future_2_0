FROM node:22-alpine

WORKDIR /app

# Копируем package.json и устанавливаем зависимости
COPY package.json package-lock.json* ./
RUN npm install

# Копируем все файлы проекта
COPY config.json about.md generate-md.js radar.json ./

# Генерируем Markdown-файлы из radar.json
RUN npm run generate

# Собираем статический сайт
RUN npm run build

# Устанавливаем сервер (используем встроенный serve от techradar или nginx)
# Проще всего использовать serve, который уже есть в зависимостях
EXPOSE 3000
CMD ["npm", "run", "serve"]