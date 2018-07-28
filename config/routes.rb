Rails.application.routes.draw do
  root 'home#dashboard'
  telegram_webhook TelegramWebhooksController
end
