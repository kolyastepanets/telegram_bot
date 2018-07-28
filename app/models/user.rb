class User < ApplicationRecord
  has_many :user_videos
  has_many :watched_videos, through: :user_videos, source: :youtube_video, foreign_key: :video_id
end
