class CreateUserYoutubeVideos < ActiveRecord::Migration[5.2]
  def change
    create_table :user_youtube_videos do |t|
      t.integer :user_id
      t.integer :youtube_video_id

      t.timestamps
    end
    add_index :user_youtube_videos, :user_id
    add_index :user_youtube_videos, :youtube_video_id
  end
end
