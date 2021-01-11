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
mv user /sync/user
ln -s /sync/user user

php -S 0.0.0.0:8080 system/router.php
