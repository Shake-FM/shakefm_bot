# Shake!FM Telegram Bot
#
# Created: 25.04.2020 by codiflow (t.me/codiflow)
# Updated: 22.05.2020 by codiflow (t.me/codiflow)
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
version_string = 'shakefm\_bot v1.2 - 22.05.2020'

# Emojis
emoji_right_arrow = "\u27A1"
emoji_heart = "\u2764"
emoji_envelope = "\u2709"

Telegram::Bot::Client.run(token) do |bot|
  bot.listen do |message|
    case message.text
    when '/start'
      bot.api.send_message(chat_id: message.chat.id, text: "Hi *#{message.from.first_name}*, ich stehe dir nun zu Diensten. Was kann ich für dich tun?", parse_mode: "Markdown")
    when '/current_track'
      url = 'https://api.shakefm.de/playlist/'
      uri = URI(url)
      response = Net::HTTP.get(uri)
      parsed = JSON.parse(response)
      # Check if theres currently a show in progress
      if parsed[0]["title"] == "" and parsed[0]["artist"] == ""
        bot.api.send_message(chat_id: message.chat.id, text: "Aktuell läuft eine *Live-Sendung*.\n\nAlle Titel findest du hier:\nhttps://www.shakefm.de/player/", parse_mode: "Markdown", disable_web_page_preview: true)
      else
        bot.api.send_message(chat_id: message.chat.id, text: "#{parsed[0]["date"]}, #{parsed[0]["time"]}: *#{parsed[0]["artist"]} - #{parsed[0]["title"]}*\n\nAlle Titel findest du hier:\nhttps://www.shakefm.de/player/", parse_mode: "Markdown", disable_web_page_preview: true)
      end
    when '/playlist'
      url = 'https://api.shakefm.de/playlist/'
      uri = URI(url)
      response = Net::HTTP.get(uri)
      parsed = JSON.parse(response)
      bot.api.send_message(chat_id: message.chat.id, text: "#{parsed[0]["date"]}, #{parsed[0]["time"]}: *#{parsed[0]["artist"]} - #{parsed[0]["title"]}*\n#{parsed[1]["date"]}, #{parsed[1]["time"]}: *#{parsed[1]["artist"]} - #{parsed[1]["title"]}*\n#{parsed[2]["date"]}, #{parsed[2]["time"]}: *#{parsed[2]["artist"]} - #{parsed[2]["title"]}*\n#{parsed[3]["date"]}, #{parsed[3]["time"]}: *#{parsed[3]["artist"]} - #{parsed[3]["title"]}*\n#{parsed[4]["date"]}, #{parsed[4]["time"]}: *#{parsed[4]["artist"]} - #{parsed[4]["title"]}*\n#{parsed[5]["date"]}, #{parsed[5]["time"]}: *#{parsed[5]["artist"]} - #{parsed[5]["title"]}*\n\nAlle Titel findest du auch hier:\nhttps://api.shakefm.de/playlist/", parse_mode: "Markdown", disable_web_page_preview: true)
    when '/play'
      bot.api.send_message(chat_id: message.chat.id, text: "Shake!FM Player\nhttps://www.shakefm.de/player/")
    when '/shows'
      # Special shows
      if timestamp < 1590271200 # Sonntag, 24. Mai 2020 00:00:00 GMT+02:00 DST
        bot.api.send_message(chat_id: message.chat.id, text: "*SPEZIELLE TERMINE*\nSamstag und Sonntag 23. und 24. Mai: #bleibzuhause Wochenende Teil 10\n\nWir gehen in *das zehnte Party-WE* mit euch.\n\nWir gehen in das zehnte Party-WE mit euch. Mit dabei sind Deejay Caspa, André Fossen, Mr. Brown und DJ Jocar und Booming B. von “The Spank” aus Paderborn.", parse_mode: "Markdown")
        bot.api.send_photo(chat_id: message.chat.id, photo: "https://www.shakefm.de/wp-content/uploads/2020/05/Bleibzuhause-Samstag-10.jpg")
        bot.api.send_photo(chat_id: message.chat.id, photo: "https://www.shakefm.de/wp-content/uploads/2020/05/Bleibzuhause-Sonntag-10.jpg")
      elsif timestamp > 1590271200 and timestamp < 1590310800 # Sonntag, 24. Mai 2020 11:00:00 GMT+02:00 DST
        bot.api.send_photo(chat_id: message.chat.id, photo: "https://www.shakefm.de/wp-content/uploads/2020/05/Bleibzuhause-Sonntag-10.jpg")
      end

      # Weekly shows
      bot.api.send_message(chat_id: message.chat.id, text: "*WÖCHENTLICH*\n*Montags bis Donnerstags* 22 bis 0 Uhr:\nGroove Lounge (2 Stunden lang Soul, Funk und Disco aus den 70s und 80s\n_nicht moderiert_\n*nicht an Feiertagen*\n\n*Mittwochs* 19 bis 20 Uhr:\nDas Playlist Update mit _Michel Mertens_ (alle neuen Top Tracks aus dem Shake!FM Programm in einer Stunde)\n\n*Freitags* 19 bis 20 Uhr:\nAndrés Nu-Soul-Lounge mit _André Fossen_ (André präsentiert seine frischen Songs und aktuellen Lieblingstracks)\n\n*Sonntags* 10 bis 11 Uhr:\nSoulfood Breakfast mit _André Fossen_\n\nDas gesamte Radioprogramm findest du hier:\nhttps://www.shakefm.de/backstage/radio-programm/", parse_mode: "Markdown")
    when '/tv'
      bot.api.send_message(chat_id: message.chat.id, text: "Shake!FM TV\nhttps://www.shakefm.de/tv/")
    when '/chat'
      bot.api.send_message(chat_id: message.chat.id, text: "Shake!FM Chat\nhttps://www.shakefm.de/chat/")
    when '/social'
      bot.api.send_message(chat_id: message.chat.id, text: "Wir sind natürlich auch in den sozialen Netzwerken vertreten:\n\n<strong>Facebook</strong>\nhttps://www.facebook.com/shakefm.de\n\n<strong>Twitter</strong>\nhttps://twitter.com/shakefm\n\n<strong>Instagram</strong>\nhttps://www.instagram.com/shake.fm\n\n<strong>Soundcloud</strong>\nhttps://soundcloud.com/shakefm\n\n<strong>Mixcloud</strong>\nhttps://www.mixcloud.com/Shake_FM", parse_mode: "HTML", disable_web_page_preview: true)
    when '/support'
      bot.api.send_message(chat_id: message.chat.id, text: "Dein Herz schlägt für ShakeFM? #{emoji_heart.encode('utf-8')} Dann <strong>unterstütze uns</strong> doch mit einer <strong>Steady-Mitgliedschaft</strong> - schon ab 5€ pro Monat.\n\nMit dem Geld finanzieren wir:\n#{emoji_right_arrow.encode('utf-8')} Musiklizenzen (GEMA & GVL)\n#{emoji_right_arrow.encode('utf-8')} die Serverkosten\n#{emoji_right_arrow.encode('utf-8')} unsere Homepage\n\nhttps://steadyhq.com/de/shakefm?utm_source=telegram&utm_medium=shakefm_bot", parse_mode: "HTML")
    when '/contact'
      bot.api.send_message(chat_id: message.chat.id, text: "Du hast <strong>Anmerkungen</strong>, <strong>konstruktive Kritik</strong> oder einfach paar <strong>coole Musiktipps</strong>?\n\nLeider sind wir noch nicht bei Telegram.\n#{emoji_envelope.encode('utf-8')} Schreib uns einfach eine E-Mail: anfrage@shakefm.de\n\nFür Anmerkungen oder Fehlerberichte zum Telegram-Bot wende dich bitte an @codiflow\n\n#{version_string}\n<em>Source: https://github.com/codiflow/shakefm_bot</em>", parse_mode: "HTML", disable_web_page_preview: true)
    when '/test'
      bot.api.send_message(chat_id: message.chat.id, text: "Nothing to test at the moment")
    else
      bot.api.send_message(chat_id: message.chat.id, text: "Sorry, aber mit \"#{message.text}\" kann ich leider nichts anfangen.")
    end
  end
end
