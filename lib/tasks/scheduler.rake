require 'net/http'

desc 'Wake up heroku'
task wake_up_heroku: :environment do
  uri = URI.parse('https://while-you-have-5-minutes.herokuapp.com/')
  response = Net::HTTP.get_response(uri)
  puts response.body
end
