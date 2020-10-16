module FortniteOpponentsStats
  class Main
    class << self
      def execute(_forniteio_api_key)
        loop do
          screenshot = nil # take screenshot
          feed = FortniteOpponentsStats::ImageReader.read(screenshot)
          _usernames = FortniteOpponentsStats::KillFeedParser.parse(feed)
          # search usernames from API
          # store usernames
          # print usernames on terminal
          sleep 5.seconds
        end
      end
    end
  end
end
