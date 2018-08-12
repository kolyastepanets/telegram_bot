require 'telegram/bot'

namespace :notify do
  desc 'Notify user about smth'
  task users: :environment do
    bot = Telegram::Bot::Client.new(ENV['TELEGRAM_BOT_TOKEN'])

    User.find_each do |user|
      begin
        bot.send_message(chat_id: user.uid, text: I18n.t('updates_12_08_2018', locale: user.language))
        puts "user with name #{user.first_name} was notified"
      rescue Telegram::Bot::Forbidden => e
        puts "it is sad, user uid: #{user.uid}"
        user.update(has_blocked: true)
      end
    end
  end
end
