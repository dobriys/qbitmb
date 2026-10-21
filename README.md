# qbitmb

Стандартный веб-интерфейс qBittorrent в оформлении macOS и со скоростью в битах. Это Docker mod для образа [linuxserver/qbittorrent](https://docs.linuxserver.io/images/docker-qbittorrent).

## Установка

1. Добавьте мод в `docker-compose.yml`:

   ```yaml
   services:
     qbittorrent:
       image: lscr.io/linuxserver/qbittorrent:latest
       environment:
         DOCKER_MODS: ghcr.io/dobriys/qbitmb-mod:latest
   ```

   Пересоздайте контейнер:

   ```bash
   docker compose up -d
   ```

2. В qBittorrent откройте **Настройки → Веб-интерфейс**:
   - включите **«Использовать альтернативный веб-интерфейс»**;
   - в поле **«Расположение файлов»** укажите `/qbitmb`;
   - нажмите «Сохранить».

3. По желанию откройте **Настройки → Поведение → Интерфейс** и настройте два флажка:
   - **«Показывать скорость в битах (Кбит/с, Мбит/с)»**;
   - **«Оформление в стиле macOS»** — включено по умолчанию.

   Нажмите «Сохранить».

## Удаление

1. В qBittorrent откройте **Настройки → Веб-интерфейс**, снимите **«Использовать альтернативный веб-интерфейс»** и нажмите «Сохранить».

2. Удалите строку `DOCKER_MODS` из `docker-compose.yml` и пересоздайте контейнер:

   ```bash
   docker compose up -d
   ```

Если веб-интерфейс не открывается, остановите контейнер. Затем в файле `qBittorrent/qBittorrent.conf` внутри папки, подключённой как `/config`, поставьте значение ниже и запустите контейнер снова:

```
WebUI\AlternativeUIEnabled=false
```
