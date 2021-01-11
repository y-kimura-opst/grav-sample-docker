#!/bin/sh
# -------------------
# Gitと同期するためには定期的にsyncコマンドを実行する必要がある。
# コンテナ起動時にディレクトリをマウントし、crontab実行用のコンテナと同期できるようにする。
# -------------------
# mountPoint: /sync/
# -------------------

if [ ! -d "/sync" ]
then
  echo "[ERROR] /sync ディレクトリをマウントしてください。"
  exit 1
fi

if [ ! -L "$PWD/user" ]
then
  echo "/sync/userにうつす"
  mv user /sync
  ln -s /sync/user user
fi

echo "[INFO] grav container is ready..."
php -S 0.0.0.0:8080 system/router.php
