# grav-sample

![Docker Image CI](https://github.com/y-kimura-opst/grav-sample/workflows/Docker%20Image%20CI/badge.svg)
![Docker Base Image CI](https://github.com/y-kimura-opst/grav-sample/workflows/Docker%20Base%20Image%20CI/badge.svg)

## development & publishing

- install Docker & docker-compose
- docker-compose up

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