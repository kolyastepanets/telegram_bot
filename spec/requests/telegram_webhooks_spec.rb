RSpec.describe TelegramWebhooksController, telegram_bot: :rails do
  let!(:youtube_channels) { create_list(:youtube_channel, 5) }

  describe '#start!' do
    subject { -> { dispatch_command :start } }
    it { should respond_with_message "Choose video's language / Выберите язык видео" }
  end

  describe '#help!' do
    subject { -> { dispatch_command :help } }
    it { should respond_with_message I18n.t('help') }
  end

  describe '#channels!' do
    subject { -> { dispatch_command :channels } }
    it { should respond_with_message(youtube_channels.map(&:name).join(', ')) }
  end

  describe '#choose_channels!' do
    subject { -> { dispatch_command :choose_channels } }
    it { should respond_with_message(I18n.t('click_on_channel')) }
  end
end
