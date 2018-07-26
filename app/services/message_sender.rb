# # require 'telegram/bot'

# # Telegram::Bot::Client.run('650059763:AAEvzanhOz6w8T6_xoahgpmFTYb4zi6qUGU') do |bot|
# #   bot.listen do |message|
# #     MessageSender.new(bot, message).run
# #   end
# # end


# class MessageSender
#   def initialize(bot, message)
#     @bot = bot
#     @message = message
#   end

#   def run
#     case @message
#     when Telegram::Bot::Types::CallbackQuery
#       case @message.data
#       when '/russian'
#         @bot.api.send_message(
#           chat_id: @message.from.id,
#           text: 'bla bla',
#           reply_markup: get_video_button
#         )
#         # @videos = YoutubeVideo.where(language: user.language).pluck(:youtube_id)
#       when '/english'
#         # I18n.locale = :en
#         # user.update(language: 'en')
#         @bot.api.send_message(
#           chat_id: @message.from.id,
#           text: I18n.t('small_description'),
#           reply_markup: get_video_button
#         )
#         # @videos = YoutubeVideo.where(language: user.language).pluck(:youtube_id)
#         # @logger.debug "user uid: #{message.from.id}, message: #{I18n.t('small_description')}"
#       when '/get_video'
#         # @videos = YoutubeVideo.where(language: user.language).pluck(:youtube_id) if @videos.empty?
#         # user_videos = user.watched_videos
#         # id = @videos.first
#         # id = @videos.sample while user_videos.pluck(:youtube_id).include?(id)
#         # UserVideo.create(user_id: user.id, youtube_video_id: YoutubeVideo.find_by(youtube_id: id).id)
#         # text = "https://www.youtube.com/watch?v=#{id}"

#         @bot.api.send_message(
#           chat_id: @message.from.id,
#           text: 'dfdfdf',
#           reply_markup: get_video_button
#         )
#       end
#     when Telegram::Bot::Types::Message
#       case @message.text
#       when '/start'
#         text = 'Choose language / Выберите язык'
#         kb = [
#           Telegram::Bot::Types::InlineKeyboardButton.new(text: 'English', callback_data: '/english'),
#           Telegram::Bot::Types::InlineKeyboardButton.new(text: 'Русский', callback_data: '/russian')
#         ]
#         markup_languages = Telegram::Bot::Types::InlineKeyboardMarkup.new(inline_keyboard: kb)
#         @bot.api.send_message(chat_id: @message.chat.id, text: text, reply_markup: markup_languages)
#       end
#     end

#   end

#   def get_video_button
#     kb = Telegram::Bot::Types::InlineKeyboardButton.new(text: I18n.t('get_video'), callback_data: '/get_video')
#     Telegram::Bot::Types::InlineKeyboardMarkup.new(inline_keyboard: kb)
#   end
# end
