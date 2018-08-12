require 'telegram/bot'

class AddVideosJob < ApplicationJob
  queue_as :default

  def perform(user_id:, channel_id:)
    videos = []
    bot = Telegram::Bot::Client.new(ENV['TELEGRAM_BOT_TOKEN'])

    user = User.find(user_id)
    channel = Yt::Channel.new(id: channel_id)
    channel.videos.map do |video|
      videos << video.id if video.duration/60.0 <= 6
    end

    if videos.present?
      channel = YoutubeChannel.create(uid: channel_id, name: channel.title, language: user.language)
      videos.each do |video_id|
        YoutubeVideo.create(youtube_id: video_id, language: user.language, youtube_channel: channel)
      end
      UserYoutubeChannel.create(user: user, youtube_channel: channel)
      bot.send_message(chat_id: user.uid, text: I18n.t('videos_added', number_of_videos: videos.count))
    else
      bot.send_message(chat_id: user.uid, text: I18n.t('no_videos'))
    end
  end
end
