class CreateYoutubeVideos < ActiveRecord::Migration[5.2]
  def change
    create_table :youtube_videos do |t|
      t.string :youtube_id
      t.string :channel_id
      t.string :channel_name
      t.string :language

      t.timestamps
    end
  end
end
