class TelegramWebhooksController < Telegram::Bot::UpdatesController
  include Telegram::Bot::UpdatesController::MessageContext

  before_action :load_user
  before_action :set_locale

  def start!(*)
    text = 'Choose language / Выберите язык'
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
    respond_with :message, text: YoutubeVideo.where(language: @user.language).pluck(:channel_name).uniq.join(', ')
  end

  def get_video!(*)
    return_youtube_video
  end

  def callback_query(data)
    case data
    when 'russian'
      I18n.locale = :ru
      @user.update(language: 'ru')
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
    when 'english'
      I18n.locale = :en
      @user.update(language: 'en')
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
    when 'get_video'
      return_youtube_video
    end
  end

  private

    def return_youtube_video
      @videos = YoutubeVideo.where(language: @user.language).pluck(:youtube_id)
      watched_videos = @user.watched_videos
      id = @videos.first
      id = @videos.sample while watched_videos.pluck(:youtube_id).include?(id)
      UserYoutubeVideo.create(user_id: @user.id, youtube_video_id: YoutubeVideo.find_by(youtube_id: id).id)

      respond_with(
        :message,
        text: "https://www.youtube.com/watch?v=#{id}",
        reply_markup: {
          inline_keyboard: [
            [
              {text: I18n.t('get_video'), callback_data: 'get_video'}
            ]
          ],
        }
      )      
    end

    def load_user
      @user = User.find_or_create_by(
        uid: from[:id],
        first_name: from[:first_name],
        last_name: from[:last_name],
        is_bot: from[:is_bot]
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
