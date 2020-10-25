module FortniteOpponentsStats
  class Main
    def initialize(forniteio_api_key, **options)
      @forniteio_api = FortniteOpponentsStats::Services::FortniteAPI.new(forniteio_api_key)
      @screenshot = FortniteOpponentsStats::Helpers::Screenshot.new(options)
      @users_with_stats = [[], []]
      @terminal = FortniteOpponentsStats::Helpers::Terminal.new
    end

    def execute
      loop do
        screenshot_path = @screenshot.capture # Take screenshot
        feed = FortniteOpponentsStats::ImageReader.read(screenshot_path) # Read screenshot
        usernames = FortniteOpponentsStats::KillFeedParser.parse(feed) # Parse usernames
        store_user_stats(usernames) # Retrieve stats from users
        @terminal.print(@users_with_stats) # Print usernames on terminal
        @screenshot.delete(screenshot_path) # Delete generated screenshot
      end
    end

    private

    def store_user_stats(usernames)
      (0..1).each do |user_group|
        usernames[user_group].each do |username|
          user_with_stats = retrieve_stats(username)
          if user_with_stats && user_with_stats['result'] &&
             @users_with_stats[user_group].none? { |arr| arr['name'] == user_with_stats['name'] }
            @users_with_stats[user_group] << user_with_stats
          end
        end
      end
    end

    def retrieve_stats(username)
      return unless (account_id = retrieve_account_id(username))
      @forniteio_api.stats(account_id).parsed_response
    end

    def retrieve_account_id(username)
      %w[epic psn xbl].each do |platform|
        response = @forniteio_api.lookup(username, platform).parsed_response
        next if response.nil?
        return response['account_id'] if response['result']
      end
      nil
    end
  end
end
