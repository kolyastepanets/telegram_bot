class CreateUserVideos < ActiveRecord::Migration[5.2]
  def change
    create_table :user_videos do |t|
      t.integer :user_id
      t.integer :video_id

      t.timestamps
    end
    add_index :user_videos, :user_id
    add_index :user_videos, :video_id
  end
end
