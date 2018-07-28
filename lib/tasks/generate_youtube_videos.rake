require 'csv'

namespace :youtube_videos do
  desc 'Create youtube videos from csv file'
  task create: :environment do
    CSV.foreach("#{Rails.root}/file.csv") do |row|
      YoutubeVideo.create(
        youtube_id: row.to_a[0],
        channel_id: row.to_a[1],
        channel_name: row.to_a[2],
        language: row.to_a[3]
      )
    end
  end
end
