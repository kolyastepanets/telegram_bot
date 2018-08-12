source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.5.1'

gem 'rails', '~> 5.2.0'
gem 'pg', '>= 0.18', '< 2.0'
gem 'puma', '~> 3.11'
gem 'sass-rails', '~> 5.0'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.2'
gem 'turbolinks', '~> 5'
gem 'jbuilder', '~> 2.5'
gem 'bootsnap', '>= 1.1.0', require: false
gem 'telegram-bot'
gem 'sidekiq'
gem 'yt', '~> 0.28.0'
gem 'sidekiq-cron', '~> 0.6.3'
gem 'rufus-scheduler', '~> 3.4.2'

group :development, :test do
  gem 'dotenv-rails'
  gem 'pry'
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  gem 'rspec-rails'
  gem 'factory_bot_rails'
  gem 'pry-rails'
  gem 'pry-byebug'
  gem 'faker'
  gem 'fasterer'
  gem 'bundler-audit'
end

group :development do
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

group :test do
  gem 'simplecov',      require: false
  gem 'simplecov-html', require: false
  gem 'simplecov-json', require: false
  gem 'simplecov-rcov', require: false
end
