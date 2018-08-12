require 'telegram/bot'

class TestJob < ApplicationJob
  queue_as :default

  def perform(*)
    bot = Telegram::Bot::Client.new(ENV['TELEGRAM_BOT_TOKEN'])
    bot.send_message(chat_id: 384435131, text: 'вроде работает')
  end
end
