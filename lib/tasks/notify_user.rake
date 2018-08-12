require 'telegram/bot'

namespace :notify do
  desc 'Notify user about smth'
  task users: :environment do
    bot = Telegram::Bot::Client.new(ENV['TELEGRAM_BOT_TOKEN'])

    User.find_each do |user|
      bot.send_message(chat_id: user.uid, text: I18n.t('updates_12_08_2018', locale: user.language))
    end
  end
end
