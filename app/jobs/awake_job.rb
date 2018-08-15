require 'net/http'

class AwakeJob < ApplicationJob
  queue_as :default

  def perform(*)
    uri = URI.parse('https://while-you-have-5-minutes.herokuapp.com')
    response = Net::HTTP.get_response(uri)
    puts response.body
  end
end
