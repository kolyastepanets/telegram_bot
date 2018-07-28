class User < ApplicationRecord
  has_many :user_youtube_videos
  has_many :watched_videos, through: :user_youtube_videos, source: :youtube_video
end
