class YoutubeVideo < ApplicationRecord
  def self.search_for(user)
    if user.chosen_channels.present?
      where(channel_name: user.chosen_channels.pluck(:channel_name))
    else
      all
    end
  end
end
