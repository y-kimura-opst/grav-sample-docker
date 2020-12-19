#!/bin/sh
# ---------------
# プラグイン設定やテーマなどを開発する時にこのスクリプトをコンテナで実行します。
# ---------------

rm -fR user
ln -s _user user

chmod +x bin/*

echo "---> grav plugins installing..."
bin/gpm install admin -y
echo "<--- plugins installed."

echo "---> grav start..."
php -S 0.0.0.0:8080 system/router.php