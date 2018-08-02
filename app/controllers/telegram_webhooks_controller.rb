class TelegramWebhooksController < Telegram::Bot::UpdatesController
  include Telegram::Bot::UpdatesController::MessageContext

  before_action :load_user
  before_action :set_locale

  def start!(*)
    text = "Choose video's language / Выберите язык видео"
    begin
      respond_with(:message, text: text, reply_markup: {
        inline_keyboard: [
          [
            {text: 'English', callback_data: 'english'},
            {text: 'Русский', callback_data: 'russian'},
          ]
        ],
      })
    rescue Telegram::Bot::Forbidden => e
      puts "it is sad"
      user = User.find_by(uid: from[:id])
      user.update(has_blocked: true)
    end
  end

  def help!(*)
    respond_with :message, text: t('help')
  end

  def channels!(*)
    respond_with(
      :message,
      text: YoutubeChannel.where(language: (@user.language || I18n.default_locale))
                          .pluck(:name)
                          .join(', ')
    )
  end

  def choose_channels!(*)
    respond_with(
      :message,
      text: I18n.t('click_on_channel'),
      reply_markup: {
        inline_keyboard:
          channel_names.map do |channel_name|
            [{ text: channel_name, callback_data: channel_name }]
          end
      }
    )
    respond_with(
      :message,
      text: '/help'
    )
  end

  def chosen_channels!(*)
    respond_with(
      :message,
      text: I18n.t('chosen_channels', channels: @user.chosen_channels.pluck(:name).join(', '))
    )
  end

  def get_video!(*)
    return_youtube_video
  end

  def callback_query(data)
    case data
    when 'russian'
      I18n.locale = :ru
      @user.update(language: 'ru')
      respond_with_description
    when 'english'
      I18n.locale = :en
      @user.update(language: 'en')
      respond_with_description
    when 'get_video'
      return_youtube_video
    when 'watch_again'
      ids = @user.chosen_channels.ids
      UserYoutubeVideo.where(user: @user, youtube_video: ids).delete_all
      return_youtube_video
    else
      update_youtube_channel_list(data) if channel_names.include?(data)
    end
  end

  private

    def channel_names
      @channel_names ||= YoutubeChannel.where(language: @user.language).pluck(:name)
    end

    def update_youtube_channel_list(channel_name)
      chosen_channel = @user.chosen_channels.find_by(name: channel_name)
      if chosen_channel.present?
        UserYoutubeChannel.find_by(user: @user, youtube_channel: chosen_channel).destroy
        answer_callback_query I18n.t('channel_removed'), show_alert: true
      else
        UserYoutubeChannel.create(user: @user, youtube_channel: YoutubeChannel.find_by(name: channel_name))
        answer_callback_query I18n.t('channel_added'), show_alert: true
      end
    end

    def return_youtube_video
      # @videos = YoutubeVideo.where(youtube_id: 'fjxQ25nDvqQ').or(YoutubeVideo.where(youtube_id: '3aehewYF8MQ')).pluck(:youtube_id)
      @videos = YoutubeVideo.where(language: @user.language)
                            .search_for(@user)
                            .pluck(:youtube_id)
      watched_videos = @user.watched_videos.pluck(:youtube_id)
      @id = @videos.sample

      while watched_videos.include?(@id)
        @videos.delete(@id)
        @id = @videos.sample
        break if @videos.empty?
      end

      if @videos.empty?
        respond_with(
          :message,
          text: I18n.t('watch_again', channels: @user.chosen_channels.pluck(:channel_name).join(', ')),
          reply_markup: {
            inline_keyboard: [
              [
                {text: I18n.t('answer_yes'), callback_data: 'watch_again'}
              ]
            ],
          }
        )
      else
        UserYoutubeVideo.create(user_id: @user.id, youtube_video_id: YoutubeVideo.find_by(youtube_id: @id).id)

        respond_with(
          :message,
          text: "https://www.youtube.com/watch?v=#{@id}",
          reply_markup: {
            inline_keyboard: [
              [
                {text: I18n.t('get_video'), callback_data: 'get_video'}
              ]
            ],
          }
        )
      end

    end

    def load_user
      @user ||= User.find_or_create_by(
        uid: from[:id],
        first_name: from[:first_name],
        last_name: from[:last_name],
        is_bot: from[:is_bot]
      )
    end

    def respond_with_description
      respond_with(
        :message,
        text: I18n.t('small_description'),
        reply_markup: {
          inline_keyboard: [
            [
              {text: I18n.t('get_video'), callback_data: 'get_video'}
            ]
          ],
        }
      )
    end

    def set_locale
      if @user.language.present?
        I18n.locale = @user.language
      else
        I18n.locale = :en
      end
    end
end
