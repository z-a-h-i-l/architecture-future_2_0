const fs = require('fs');
const path = require('path');

// Читаем ваш radar.json
const radar = JSON.parse(fs.readFileSync('radar.json', 'utf8'));

// Дата релиза — сегодня или задайте явно, например '2025-01-01'
const releaseDate = new Date().toISOString().slice(0, 10); // YYYY-MM-DD
const radarDir = path.join('radar', releaseDate);

// Создаём папку с датой
if (!fs.existsSync(radarDir)) {
  fs.mkdirSync(radarDir, { recursive: true });
}

// Проходим по каждой записи из radar.json
radar.entries.forEach(entry => {
  // Безопасное имя файла (убираем спецсимволы)
  const safeLabel = entry.label.replace(/[\/\\:*?"<>|]/g, '_');
  const filePath = path.join(radarDir, `${safeLabel}.md`);

  // Экранируем кавычки в названии
  const titleEscaped = entry.label.replace(/"/g, '\\"');

  // Формируем frontmatter
  const frontmatter = `---
title: "${titleEscaped}"
ring: ${entry.ring}
quadrant: ${entry.quadrant}
tags: []
featured: true
---

Технология **${entry.label}** находится в статусе *${entry.ring}*.

<!-- При необходимости добавьте здесь подробное описание -->
`;

  fs.writeFileSync(filePath, frontmatter);
  console.log(`Создан: ${filePath}`);
});

console.log(`\n✅ Сгенерировано ${radar.entries.length} записей в папку ${radarDir}`);
console.log('Теперь можно запускать npm run build');