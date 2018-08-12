class AddNewVideosJob < ApplicationJob
  queue_as :schedule_job

  def perform(*)
    YoutubeChannel.find_each do |youtube_channel|
      channel = Yt::Channel.new(id: youtube_channel.uid)

      channel.videos.each do |video|
        next if YoutubeVideo.find_by(youtube_id: video.id).present?

        YoutubeVideo.create(
          youtube_id: video.id,
          language: youtube_channel.language,
          youtube_channel: youtube_channel
        ) if video.duration/60.0 <= 6
      end
    end
  end
end
