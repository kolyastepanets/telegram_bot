class UserYoutubeChannel < ApplicationRecord
  belongs_to :user
  belongs_to :youtube_channel
end
