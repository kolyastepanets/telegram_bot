class YoutubeVideo < ApplicationRecord
  belongs_to :youtube_channel

  def self.search_for(user)
    if user.chosen_channels.present?
      joins(:youtube_channel).where(youtube_channels: { id: user.chosen_channels.ids })
    else
      all
    end
  end
end
