# syntax=docker/dockerfile:1

## Buildstage: stock qBittorrent WebUI + qbitmb patches ##
FROM alpine:3.22 AS buildstage

ARG QBT_VERSION

RUN apk add --no-cache curl patch qt6-qttools

COPY patches/ /tmp/patches/
COPY i18n/ /tmp/i18n/
COPY theme/ /tmp/theme/
COPY root/ /root-layer/

RUN \
  set -eu && \
  test -n "${QBT_VERSION}" && \
  echo "**** grab qBittorrent ${QBT_VERSION} WebUI ****" && \
  mkdir -p /tmp/www && \
  curl -fsSL "https://github.com/qbittorrent/qBittorrent/archive/refs/tags/release-${QBT_VERSION}.tar.gz" \
    | tar -xz -C /tmp/www --strip-components=4 "qBittorrent-release-${QBT_VERSION}/src/webui/www" && \
  cd /tmp/www && \
  echo "**** apply patches ****" && \
  for p in /tmp/patches/*.patch; do \
    patch -p1 --forward --fuzz=0 --no-backup-if-mismatch < "${p}"; \
  done && \
  echo "**** add macOS theme ****" && \
  cp /tmp/theme/qbitmb-macos.css private/css/ && \
  cp /tmp/theme/qbitmb-macos.css public/css/ && \
  find private public -name '*.html' -exec grep -l '</head>' {} + \
    | xargs sed -i 's#</head>#    <link rel="stylesheet" type="text/css" href="css/qbitmb-macos.css?v=${CACHEID}">\n</head>#' && \
  echo "**** compile translations ****" && \
  mkdir -p /root-layer/qbitmb/translations && \
  for ts in translations/webui_*.ts; do \
    name=$(basename "${ts}" .ts); \
    extra="/tmp/i18n/qbitmb_${name#webui_}.ts"; \
    if [ -f "${extra}" ]; then set -- "${ts}" "${extra}"; else set -- "${ts}"; fi; \
    /usr/lib/qt6/bin/lrelease -silent "$@" -qm "/root-layer/qbitmb/translations/${name}.qm"; \
  done && \
  cp -R private public /root-layer/qbitmb/ && \
  echo "${QBT_VERSION}" > /root-layer/qbitmb/version.txt && \
  chmod -R u=rwX,go=rX /root-layer/qbitmb

## WebUI files only, for the zip release (docker build --target webui) ##
FROM scratch AS webui

COPY --from=buildstage /root-layer/qbitmb/ /qbitmb/

## Single layer deployed image ##
FROM scratch

COPY --from=buildstage /root-layer/ /
