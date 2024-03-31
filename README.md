1. set TELE_TOKEN env variable
2. build the bot with 
```
go build -ldflags "-X="github.com/vzakharchuk/bot/cmd.appVersion={{version}}
```
3. `./bot start`