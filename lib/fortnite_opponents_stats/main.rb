require 'byebug'

module FortniteOpponentsStats
  class Main
    def initialize(forniteio_api_key)
      @forniteio_api = FortniteOpponentsStats::Services::FortniteAPI.new(forniteio_api_key)
      @users_with_stats = [[], []]
    end

    def execute
      loop do
        screenshot = nil # Take screenshot
        feed = FortniteOpponentsStats::ImageReader.read(screenshot) # Read screenshot
        usernames = FortniteOpponentsStats::KillFeedParser.parse(feed) # Parse usernames
        store_user_stats(usernames) # Retrieve stats from users
        # print usernames on terminal
        sleep 5
      end
    end

    private

    def store_user_stats(usernames)
      (0..1).each do |user_group|
        usernames[user_group].each do |username|
          user_with_stats = retrieve_stats(username)
          if user_with_stats && user_with_stats['result']
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
        return response['account_id'] if response['result']
      end
      nil
    end
  end
end
