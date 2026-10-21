# qbitmb

[Русская версия](README.ru.md)

The stock qBittorrent WebUI with a macOS look and speeds in bits. Installs as a Docker mod for the [linuxserver/qbittorrent](https://docs.linuxserver.io/images/docker-qbittorrent) image or as a regular alternative WebUI.

## Installation

### With Docker (linuxserver/qbittorrent)

1. Add the mod to your `docker-compose.yml`:

   ```yaml
   services:
     qbittorrent:
       image: lscr.io/linuxserver/qbittorrent:latest
       environment:
         DOCKER_MODS: ghcr.io/dobriys/qbitmb-mod:latest
   ```

   Recreate the container:

   ```bash
   docker compose up -d
   ```

2. In qBittorrent, open **Options → WebUI**:
   - turn on **Use alternative WebUI**;
   - set **Files location** to `/qbitmb`;
   - click **Save**.

### Without Docker

1. Download the archive for your qBittorrent version:
   - [qbitmb.zip for the latest version](https://github.com/dobriys/qbitmb/releases/latest/download/qbitmb.zip);
   - archives for other versions are on the [releases](https://github.com/dobriys/qbitmb/releases) page; the qBittorrent version is in the release name.

2. Extract the archive anywhere. You get a `qbitmb` folder.

3. In qBittorrent, open **Options → WebUI**:
   - turn on **Use alternative WebUI**;
   - set **Files location** to the full path of the `qbitmb` folder, for example `/home/user/qbitmb` or `C:\qbitmb`;
   - click **Save**.

### Settings

Optionally, open **Options → Behavior → Interface** and set two checkboxes:

- **Show speed in bits (kbit/s, Mbit/s)**;
- **Use macOS style** — on by default.

Click **Save**.

## Removal

1. In qBittorrent, open **Options → WebUI**, turn off **Use alternative WebUI** and click **Save**.

2. Remove the WebUI itself:
   - **with Docker** — delete the `DOCKER_MODS` line from `docker-compose.yml` and recreate the container with `docker compose up -d`;
   - **without Docker** — delete the `qbitmb` folder.

If the WebUI does not open, close qBittorrent or stop the container. Then set the value below in the qBittorrent settings file and start qBittorrent again:

```
WebUI\AlternativeUIEnabled=false
```

Where the settings file is:

| qBittorrent runs on | File |
|---|---|
| Docker | `qBittorrent/qBittorrent.conf` in the folder mounted as `/config` |
| Linux | `~/.config/qBittorrent/qBittorrent.conf` |
| Windows | `%APPDATA%\qBittorrent\qBittorrent.ini` |
| macOS | `~/Library/Preferences/qBittorrent/qBittorrent.ini` |
