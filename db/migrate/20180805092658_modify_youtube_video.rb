class ModifyYoutubeVideo < ActiveRecord::Migration[5.2]
  class YoutubeVideo < ApplicationRecord
    belongs_to :youtube_channel
  end

  class YoutubeChannel < ApplicationRecord
    has_many :youtube_videos
  end

  def up
    add_column :youtube_videos, :youtube_channel_id, :integer
    add_index :youtube_videos, :youtube_channel_id

    YoutubeVideo.find_each do |video|
      channel = YoutubeChannel.find_or_create_by(
        uid: video.channel_id,
        name: video.channel_name,
        language: video.language
      )
      video.update(youtube_channel: channel)
    end

    remove_column :youtube_videos, :channel_id, :string
    remove_column :youtube_videos, :channel_name, :string
  end

  def down
    remove_column :youtube_videos, :youtube_channel_id, :integer
    add_column :youtube_videos, :channel_id, :string
    add_column :youtube_videos, :channel_name, :string
  end
end
