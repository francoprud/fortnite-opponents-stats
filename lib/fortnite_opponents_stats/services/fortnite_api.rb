require 'httparty'

module FortniteOpponentsStats
  module Services
    class FortniteAPI
      class DailyRequestLimitExceededError < StandardError; end
      class APIKeyNotValidError < StandardError; end

      BASE_URI    = -'https://fortniteapi.io/v1/'
      ACCOUNT_URI = -"#{BASE_URI}/lookup"
      STATS_URI   = -"#{BASE_URI}/stats"

      def initialize(api_key)
        @api_key = api_key
      end

      def account_id_by_username(username)
        request(:get, ACCOUNT_URI, { username: username })
      end

      def stats_by_account_id(account_id)
        request(:get, STATS_URI, { account: account_id })
      end

      private

      def request(method, uri, params)
        response = HTTParty.send(method, uri, query: params,
                                              headers: { 'Authorization' => @api_key })
        verify(response)
        response
      end

      def verify(response)
        raise APIKeyNotValidError if response['code'] == 'INVALID_API_KEY'
        # TODO: verify response code for DailyRequestLimitExceededError
        # raise DailyRequestLimitExceededError if response['code'] == 'REQUEST_LIMIT_EXCEEDED'
      end
    end
  end
end
