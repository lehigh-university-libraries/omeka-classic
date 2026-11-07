#!/usr/bin/env bash
set -euo pipefail

docker compose exec -T omeka-classic /command/with-contenv bash -ec '
  mapfile -d "" -t config < <(php /usr/local/share/libops/omeka-classic-database-config.php)
  [ "${#config[@]}" -eq 5 ]
  [ "${config[0]}" = "$DB_HOST" ] && [ "${config[1]}" = "$DB_PORT" ]
  [ "${config[2]}" = "$DB_USER" ] && [ "${config[4]}" = "$DB_NAME" ]
'
docker compose exec -T omeka-classic /usr/local/bin/omeka-classic-verify-database >/dev/null
curl -fsS "${SITE_URL:-http://localhost/}" >/dev/null
