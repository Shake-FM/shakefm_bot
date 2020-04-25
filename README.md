# shakefm_bot
Shake!FM Telegram Bot

## Thanks

Thanks to [@atipugin](https://github.com/atipugin/) for his excellent example of a [Telegram ruby bot](https://github.com/atipugin/telegram-bot-ruby/blob/master/examples/bot.rb).

This is my first productive Telegram bot so I hope it will get better and more useful from time to time.

## Usage

You can find the bot at [t.me/@shakefm_bot](https://t.me/shakefm_bot) and add it to your Telegram profile by visiting the link and starting the bot by sending him the command `/start`.

## Commands

`/start` - This starts the bot  
`/current_track` - Shows the current track  
`/current_playlist` - Shows the last five tracks  
`/play` - Shows the url to tune into the radio stream Shake!FM  
`/tv` - Shows the url to tune into the video stream of Shake!FM  
`/contact` - Shows contact info  
`/social` - Shows social media channels  
`/stop` - This stops the bot

## How it works

At the moment everything is hardcoded into the ruby script except the playlist information. This is extracted from the json api which is available here: [api.shakefm.de/playlist/](https://api.shakefm.de/playlist/)

## Issues, Comments and more

If you have any suggestions just drop me a message or open an issue here at GitHub.

## Other repositories

I'm planning to host this repository also at Codeberg. I will post the url here when this is done.
