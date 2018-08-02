class CreateYoutubeChannels < ActiveRecord::Migration[5.2]
  def change
    create_table :youtube_channels do |t|
      t.string :uid
      t.string :name
      t.string :language

      t.timestamps
    end
  end
end
