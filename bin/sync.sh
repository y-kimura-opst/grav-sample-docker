#!/bin/sh
# -------------------
# Gitと同期するためには定期的にsyncコマンドを実行する必要がある。
# コンテナ起動時にディレクトリをマウントし、crontab実行用のコンテナと同期できるようにする。
# crontabから定期実行し、web画面から編集された分をコミットする。
# -------------------
# mountPoint: /sync/
# -------------------

if [ -d "/sync" ]
then
  echo "[ERROR] /sync ディレクトリをマウントしてください。"
  exit 1
fi

ln -s /sync/user user
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
