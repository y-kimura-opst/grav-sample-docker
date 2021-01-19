# grav-sample-docker

![Docker Build CI](https://github.com/y-kimura-opst/grav-sample-docker/workflows/Docker%20Build%20CI/badge.svg)

## setup repository

```
git submodule add https://github.com/y-kimura-opst/grav-sample.git grav
```

## kubernetesにデプロイする

1. `kubectl create namespace grav`コマンドを実行し、namespaceを作成します。
2. レジストリにアクセスする`docker-registry`シークレットを作成します。
```
kubectl create secret docker-registry github-registry \
-n grav
--docker-server=docker.pkg.github.com \
--docker-username=`github-username` \
--docker-password=`github-access-token` \
--docker-email=aaa@example.com
```
3. `kustomize build manifest/override/(local or production) | kubectl apply -f -`コマンドを実行し、kubernetesにデプロイします。

## 開発環境構築

1. Docker for Desktopに組み込みのkubernetes上で動かします。
2. `manifest/pv.yaml`のhostPathを`<repository-root>/grav/user`に修正します。※manifestのCIに使用するので変更をコミットしないでください。
  - (OPTION) `Docker on WSL2`環境の方は`/run/desktop/mnt/host/c/path/from/C-Drive/`となります。
3. `kubernetesにデプロイする`の手順を実行してください。

## 本番環境構築

1. `nginx-ingress-controller`をデプロイします
  - `kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/controller-v0.43.0/deploy/static/provider/aws/deploy.yaml`
2. nginx-ingress-controllerのLBのIPにDNSを設定します
3. `kubernetesにデプロイする`の手順を実行します

### サイトを編集

- [Admin Page](http://localhost/admin)にアクセスします
- 編集画面から投稿します
- GitSyncプラグインで同期します

### Add Other Theme Site

- `grav-skelton-dir`を`grav/user/site/<site-name>`に配置します

### crontab運用メモ

邪魔なジョブが溜まってきたら以下のコマンドで全削除できます。

```
kubectl -n grav get job | grep grav-gitsync | awk '{print $1}' | xargs kubectl -n grav delete job
# もしくは
kubectl -n grav delete job --all
```

### TroubleShooting

- Composerが動かなくなった。⏩vendorディレクトリを削除して実行。
