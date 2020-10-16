module FortniteOpponentsStats
  class Main
    class << self
      def execute(forniteio_api_key)
        while true
          screenshot = nil # take screenshot
          feed = FortniteOpponentsStats::ImageReader.read(screenshot)
          usernames = FortniteOpponentsStats::KillFeedParser.parse(feed)
          # search usernames from API
          # store usernames
          # print usernames on terminal
          sleep 5.seconds
        end
      end
    end
  end
end
