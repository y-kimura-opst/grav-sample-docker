#!/bin/sh
# -------------------
# Gitと同期するためには定期的にsyncコマンドを実行する必要がある。
# コンテナ起動時にディレクトリをマウントし、crontab実行用のコンテナと同期できるようにする。
# -------------------

SYNC_DIR=/sync/user

if [ ! -d "$SYNC_DIR" ]; then
  echo "[ERROR] $SYNC_DIR ディレクトリをマウントしてください。"
  exit 1
fi

if [ ! "$(ls $SYNC_DIR/ 2>/dev/null)" ]; then
  echo "$SYNC_DIRにうつす"
  mv user/* $SYNC_DIR
fi

rm -fR user
ln -s $SYNC_DIR user

if [ "$STG_PLUGIN_INSTALL" == "true" ]; then
  echo "検証環境用プラグイン"
  sh user/plugins/staging.sh
fi

echo "[INFO] grav container is ready..."
php -S 0.0.0.0:8080 system/router.php
