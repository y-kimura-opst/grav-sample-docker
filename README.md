# grav-sample

![Docker Build CI](https://github.com/y-kimura-opst/grav-sample/workflows/Docker%20Build%20CI/badge.svg)

## 開発環境構築

1. Docker for Desktopに組み込みのkubernetes上で動かします。
2. `manifest/pv.yaml`のhostPathを`<repository-root>/grav/user`に修正します。※manifestのCIに使用するので変更をコミットしないでください。
  - (OPTION) `Docker on WSL2`環境の方は`/run/desktop/mnt/host/c/path/from/C-Drive/`となります。
3. `manifest/secret.yaml`を作成します。
4. `kubectl create namespace grav`コマンドを実行し、namespaceを作成します。
5. `kubectl apply -f manifest`コマンドを実行し、kubernetesにデプロイします。

```
apiVersion: v1
kind: Secret
metadata:
  name: github-registry
  namespace: grav
type: kubernetes.io/dockerconfigjson
stringData:
  .dockerconfigjson: '{"auths":{"docker.pkg.github.com":{"username":"<Github User Name>","password":"<Github PersonalAccessToken>"}}}'
```

### Edit Site

- access [Admin Page](http://localhost/admin)
- create account (local only.)
- edit site...
- commit & push changes to feature branch
- create pull request to main.
  - Github Action run automatically , and create new grav image tag xxx:<src-branch-name>
  - review new container image with docker-compose.
- merge pull request, and done editing.

### Add Other Theme Site

- put grav-skelton-dir on grav/user/site/<site-name> 

### TroubleShooting

- Composerが動かなくなった。⏩vendorディレクトリを削除して実行。