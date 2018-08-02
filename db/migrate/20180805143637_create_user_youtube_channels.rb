class CreateUserYoutubeChannels < ActiveRecord::Migration[5.2]
  def change
    create_table :user_youtube_channels do |t|
      t.integer :user_id
      t.integer :youtube_channel_id

      t.timestamps
    end
    add_index :user_youtube_channels, :user_id
    add_index :user_youtube_channels, :youtube_channel_id
  end
end
