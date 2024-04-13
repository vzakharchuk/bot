1. set TELE_TOKEN env variable
2. build the bot with 
```
go build -ldflags "-X="github.com/vzakharchuk/bot/cmd.appVersion={{version}}
```
3. `./bot start`
4. In order to publish a new image locally:
 -  commit a new change
 - `make build`
 - `make image`
 - `make push`

New image version will be available in 
https://hub.docker.com/repository/docker/vzak/bot 