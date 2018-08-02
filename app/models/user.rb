class User < ApplicationRecord
  has_many :user_youtube_channels
  has_many :chosen_channels, through: :user_youtube_channels, source: :youtube_channel
  has_many :user_youtube_videos
  has_many :watched_videos, through: :user_youtube_videos, source: :youtube_video
end
