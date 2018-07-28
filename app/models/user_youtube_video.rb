class UserYoutubeVideo < ApplicationRecord
  belongs_to :user
  belongs_to :youtube_video
end
