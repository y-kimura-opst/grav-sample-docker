#!/bin/sh
# ---------------
# プラグイン設定やテーマなどを開発する時にこのスクリプトをコンテナで実行します。
# ---------------

rm -fR user
ln -s _user user

echo "---> grav start..."
php -S 0.0.0.0:8080 system/router.php