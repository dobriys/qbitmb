# qbitmb

Стандартный веб-интерфейс qBittorrent в оформлении macOS и со скоростью в битах. Ставится как Docker mod для образа [linuxserver/qbittorrent](https://docs.linuxserver.io/images/docker-qbittorrent) или как обычный альтернативный веб-интерфейс.

## Установка

### Через Docker (linuxserver/qbittorrent)

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

### Без Docker

1. Скачайте архив под свою версию qBittorrent:
   - [qbitmb.zip для последней версии](https://github.com/dobriys/qbitmb/releases/latest/download/qbitmb.zip);
   - архивы для других версий — на странице [релизов](https://github.com/dobriys/qbitmb/releases); версия qBittorrent указана в названии релиза.

2. Распакуйте архив в любое место. Получится папка `qbitmb`.

3. В qBittorrent откройте **Настройки → Веб-интерфейс**:
   - включите **«Использовать альтернативный веб-интерфейс»**;
   - в поле **«Расположение файлов»** укажите полный путь к папке `qbitmb`, например `/home/user/qbitmb` или `C:\qbitmb`;
   - нажмите «Сохранить».

### Настройка

По желанию откройте **Настройки → Поведение → Интерфейс** и настройте два флажка:

- **«Показывать скорость в битах (Кбит/с, Мбит/с)»**;
- **«Оформление в стиле macOS»** — включено по умолчанию.

Нажмите «Сохранить».

## Удаление

1. В qBittorrent откройте **Настройки → Веб-интерфейс**, снимите **«Использовать альтернативный веб-интерфейс»** и нажмите «Сохранить».

2. Удалите сам интерфейс:
   - **через Docker** — удалите строку `DOCKER_MODS` из `docker-compose.yml` и пересоздайте контейнер командой `docker compose up -d`;
   - **без Docker** — удалите папку `qbitmb`.

Если веб-интерфейс не открывается, закройте qBittorrent или остановите контейнер. Затем в файле настроек qBittorrent поставьте значение ниже и запустите qBittorrent снова:

```
WebUI\AlternativeUIEnabled=false
```

Где лежит файл настроек:

| Где установлен qBittorrent | Файл |
|---|---|
| Docker | `qBittorrent/qBittorrent.conf` в папке, подключённой как `/config` |
| Linux | `~/.config/qBittorrent/qBittorrent.conf` |
| Windows | `%APPDATA%\qBittorrent\qBittorrent.ini` |
| macOS | `~/Library/Preferences/qBittorrent/qBittorrent.ini` |
