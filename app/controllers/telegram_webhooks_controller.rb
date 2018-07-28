class TelegramWebhooksController < Telegram::Bot::UpdatesController
  include Telegram::Bot::UpdatesController::MessageContext

  before_action :load_user

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
    respond_with :message, text: t('.content')
    # '/start - change language'
    # "/channels - videos are shown from this channel's list"
  end

  def channels!(*)
    respond_with :message, text: t('.content')
    # respond_with :message, text: YoutubeVideo.where(language: I18n.locale).pluck(:channel_name)
  end

  # def memo!(*args)
  #   if args.any?
  #     session[:memo] = args.join(' ')
  #     respond_with :message, text: t('.notice')
  #   else
  #     respond_with :message, text: t('.prompt')
  #     save_context :memo!
  #   end
  # end

  # def remind_me!(*)
  #   to_remind = session.delete(:memo)
  #   reply = to_remind || t('.nothing')
  #   respond_with :message, text: reply
  # end

  # def keyboard!(value = nil, *)
  #   if value
  #     respond_with :message, text: t('.selected', value: value)
  #   else
  #     save_context :keyboard!
  #     respond_with :message, text: t('.prompt'), reply_markup: {
  #       keyboard: [t('.buttons')],
  #       resize_keyboard: true,
  #       one_time_keyboard: true,
  #       selective: true,
  #     }
  #   end
  # end

  # def inline_keyboard!(*)
  #   respond_with :message, text: t('.prompt'), reply_markup: {
  #     inline_keyboard: [
  #       [
  #         {text: t('.alert'), callback_data: 'alert'},
  #         {text: t('.no_alert'), callback_data: 'no_alert'},
  #       ],
  #       [{text: t('.repo'), url: 'https://github.com/telegram-bot-rb/telegram-bot'}],
  #     ],
  #   }
  # end

  def callback_query(data)
    case data
    when 'russian'
      I18n.default_locale = :ru
      respond_with(:message, text: I18n.t('small_description'), reply_markup: {
        inline_keyboard: [
          [
            {text: I18n.t('get_video'), callback_data: 'get_video'}
          ]
        ],
      })
    when 'english'
      I18n.default_locale = :en
      respond_with(:message, text: I18n.t('small_description'), reply_markup: {
        inline_keyboard: [
          [
            {text: I18n.t('get_video'), callback_data: 'get_video'}
          ]
        ],
      })
    when 'get_video'
      @videos = YoutubeVideo.where(language: I18n.locale).pluck(:youtube_id)
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
        })
    end
  end

  private

    def load_user
      @user = User.find_or_create_by(
        uid: from[:id],
        first_name: from[:first_name],
        last_name: from[:last_name],
        is_bot: from[:is_bot]
      )
    end

  # def message(message)
  #   respond_with :message, text: t('.content', text: message['text'])
  # end

  # def inline_query(query, _offset)
  #   query = query.first(10) # it's just an example, don't use large queries.
  #   t_description = t('.description')
  #   t_content = t('.content')
  #   results = Array.new(5) do |i|
  #     {
  #       type: :article,
  #       title: "#{query}-#{i}",
  #       id: "#{query}-#{i}",
  #       description: "#{t_description} #{i}",
  #       input_message_content: {
  #         message_text: "#{t_content} #{i}",
  #       },
  #     }
  #   end
  #   answer_inline_query results
  # end

  # As there is no chat id in such requests, we can not respond instantly.
  # So we just save the result_id, and it's available then with `/last_chosen_inline_result`.
  # def chosen_inline_result(result_id, _query)
  #   session[:last_chosen_inline_result] = result_id
  # end

  # def last_chosen_inline_result!(*)
  #   result_id = session[:last_chosen_inline_result]
  #   if result_id
  #     respond_with :message, text: t('.selected', result_id: result_id)
  #   else
  #     respond_with :message, text: t('.prompt')
  #   end
  # end

  # def action_missing(action, *_args)
  #   if action_type == :command
  #     respond_with :message,
  #       text: t('telegram_webhooks.action_missing.command', command: action_options[:command])
  #   else
  #     respond_with :message, text: t('telegram_webhooks.action_missing.feature', action: action)
  #   end
  # end
end
