# Shake!FM Telegram Bot
#
# Created: 25.04.2020 by codiflow (t.me/codiflow)
# Updated: 16.05.2020 by codiflow (t.me/codiflow)
#
# License: MIT
# Source: https://github.com/codiflow/shakefm_bot

require 'telegram/bot'
require 'net/http'
require 'json'

# Method for getting current Unix timestamp
def timestamp
  Time.now.to_i
end

token = 'REDACTED-FOR-SECURITY'

# Current version
version_string = 'shakefm_bot v1.1 - 16.05.2020'

Telegram::Bot::Client.run(token) do |bot|
  bot.listen do |message|
    case message.text
    when '/start'
      bot.api.send_message(chat_id: message.chat.id, text: "Hi #{message.from.first_name}, ich stehe dir nun zu Diensten. Was kann ich für dich tun?")
    when '/current_track'
      url = 'https://api.shakefm.de/playlist/'
      uri = URI(url)
      response = Net::HTTP.get(uri)
      parsed = JSON.parse(response)
      bot.api.send_message(chat_id: message.chat.id, text: "#{parsed[0]["date"]}, #{parsed[0]["time"]}: #{parsed[0]["artist"]} - #{parsed[0]["title"]}\n\nAlle Titel findest du hier: https://api.shakefm.de/playlist/")
    when '/current_playlist'
      url = 'https://api.shakefm.de/playlist/'
      uri = URI(url)
      response = Net::HTTP.get(uri)
      parsed = JSON.parse(response)
      bot.api.send_message(chat_id: message.chat.id, text: "#{parsed[0]["date"]}, #{parsed[0]["time"]}: #{parsed[0]["artist"]} - #{parsed[0]["title"]}\n#{parsed[1]["date"]}, #{parsed[1]["time"]}: #{parsed[1]["artist"]} - #{parsed[1]["title"]}\n#{parsed[2]["date"]}, #{parsed[2]["time"]}: #{parsed[2]["artist"]} - #{parsed[2]["title"]}\n#{parsed[3]["date"]}, #{parsed[3]["time"]}: #{parsed[3]["artist"]} - #{parsed[3]["title"]}\n#{parsed[4]["date"]}, #{parsed[4]["time"]}: #{parsed[4]["artist"]} - #{parsed[4]["title"]}\n#{parsed[5]["date"]}, #{parsed[5]["time"]}: #{parsed[5]["artist"]} - #{parsed[5]["title"]}\n\nAlle Titel findest du hier: https://api.shakefm.de/playlist/")
    when '/play'
      bot.api.send_message(chat_id: message.chat.id, text: "Shake!FM Player\nhttps://www.shakefm.de/player/")
    when '/shows'
      if timestamp < 1589666400 # Sonntag, 17. Mai 2020 00:00:00 GMT+02:00 DST
        bot.api.send_message(chat_id: message.chat.id, text: "SPEZIELLE TERMINE\nSamstag und Sonntag 16. und 17. Mai: #bleibzuhause Wochenende Teil 9\n\nWir gehen in das neunte Party-WE mit euch.\n\nAkim B., DJ Kobex, André Fossen, Deejay Caspa, Lutz Wollgarten (Hunky & Funky), Maurice Da Vido und Peter Železnik liefern euch den Partysound in die eigenen vier Wände.")
        bot.api.send_message(chat_id: message.chat.id, text: "https://www.shakefm.de/wp-content/uploads/2020/05/Bleibzuhause-Samstag-9.jpg")
        bot.api.send_message(chat_id: message.chat.id, text: "https://www.shakefm.de/wp-content/uploads/2020/05/Bleibzuhause-Sonntag-9.jpg")
      elsif timestamp > 1589666400 and timestamp < 1589713200 # Sonntag, 17. Mai 2020 13:00:00 GMT+02:00 DST
        bot.api.send_message(chat_id: message.chat.id, text: "https://www.shakefm.de/wp-content/uploads/2020/05/Bleibzuhause-Sonntag-9.jpg")
      end
      bot.api.send_message(chat_id: message.chat.id, text: "WÖCHENTLICH\nMontags bis Donnerstags 22 – 0 Uhr: Groove Lounge (2 Stunden lang Soul, Funk und Disco aus den 70s und 80s – nicht moderiert) nicht an Feiertagen.\n\nMittwochs 19 – 20 Uhr: Das Playlist Update mit Michel Mertens (alle neuen Top Tracks aus dem Shake!FM Programm in einer Stunde)\n\nFreitags 19 – 20 Uhr: Andrés Nu-Soul-Lounge mit André Fossen (André präsentiert seine frischen Songs und aktuellen Lieblingstracks)\n\nSonntags 10 – 11 Uhr: Soulfood Breakfast mit André Fossen\n\nhttps://www.shakefm.de/backstage/radio-programm/")
    when '/tv'
      bot.api.send_message(chat_id: message.chat.id, text: "Shake!FM TV\nhttps://www.shakefm.de/tv/")
    when '/chat'
      bot.api.send_message(chat_id: message.chat.id, text: "Shake!FM Chat\nhttps://www.shakefm.de/chat/")
    when '/social'
      bot.api.send_message(chat_id: message.chat.id, text: "Wir sind natürlich auch in den sozialen Netzwerken vertreten\n\nFacebook: https://www.facebook.com/shakefm.de\nTwitter: https://twitter.com/shakefm\nInstagram: https://www.instagram.com/shake.fm/\nSoundcloud: https://soundcloud.com/shakefm\nMixcloud: https://www.mixcloud.com/Shake_FM")
    when '/support'
      bot.api.send_message(chat_id: message.chat.id, text: "Dir gefällt unser Programm? Dann unterstütze uns doch mit einer Steady-Mitgliedschaft - schon ab 5€ / Monat.\n\nMit dem Geld finanzieren wir:\n- Musiklizenzen (GEMA & GVL)\n- die Serverkosten\n- unsere Homepage\n\nhttps://steadyhq.com/de/shakefm?utm_source=telegram&utm_medium=shakefm_bot")
    when '/contact'
      bot.api.send_message(chat_id: message.chat.id, text: "Du hast Anmerkungen, konstruktive Kritik oder einfach paar coole Musiktipps?\n\nLeider sind wir noch nicht bei Telegram.\nSchreib uns: anfrage@shakefm.de\n\nFür Anmerkungen oder Fehlerberichte zum Telegram-Bot wende dich an @codiflow\n\n#{version_string}\nSource: https://github.com/codiflow/shakefm_bot")
    else
      bot.api.send_message(chat_id: message.chat.id, text: "Sorry, aber mit \"#{message.text}\" kann ich leider nichts anfangen.")
    end
  end
end
