#!/bin/sh
# -------------------
# Gitと同期するためには定期的にsyncコマンドを実行する必要がある。
# コンテナ起動時にディレクトリをマウントし、crontab実行用のコンテナと同期できるようにする。
# crontabから定期実行し、web画面から編集された分をコミットする。
# -------------------
# mountPoint: /sync/
# -------------------

SYNC_DIR=/sync/user
if [ -d "$SYNC_DIR" ]
then
  echo "[ERROR] $SYNC_DIR ディレクトリをマウントしてください。"
  exit 1
fi


if [ ! "$(ls $SYNC_DIR 2> /dev/null )" ]
then
  echo "同期対象がありません。"
  exit 0
fi

rm -fR user/*
mv $SYNC_DIR/* user

echo ""
echo ""
echo "---"
bin/plugin git-sync status
echo ""
echo ""
echo "---"
bin/plugin git-sync sync
echo ""
echo ""
echo "---"
bin/plugin git-sync status
