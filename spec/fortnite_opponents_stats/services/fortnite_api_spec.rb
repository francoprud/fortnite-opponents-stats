require 'spec_helper'

RSpec.describe FortniteOpponentsStats::Services::FortniteAPI do
  let(:api_key)    { 'api_key' }
  let(:lookup_uri) { described_class::LOOKUP_URI }
  let(:stats_uri)  { described_class::STATS_URI }

  subject { described_class.new(api_key) }

  describe '#lookup' do
    let(:username) { 'Ninja' }
    let(:platform) { 'epic' }

    subject { described_class.new(api_key).lookup(username, platform) }

    context 'when API key is valid' do
      context 'and daily request limit is not exceeded' do
        context 'and username and platform are valid' do
          it 'returns the account_id of the user' do
            stub_request(:get, lookup_uri)
              .with(query: { username: username, platform: platform })
              .to_return(
                status: 200,
                body: File.read(
                  'spec/support/responses/fortniteapi.io/lookup/valid_and_exists.json'
                ),
                headers: { 'Authorization' => api_key, 'Content-Type' => 'application/json' }
              )

            expect(subject.parsed_response).to eq(
              YAML.load_file('spec/support/services/fortnite_api/lookup/valid_and_exists.yml')
            )
          end
        end

        context 'and username and platform are not valid' do
          it 'returns an error where the account does not exist' do
            stub_request(:get, lookup_uri)
              .with(query: { username: username, platform: platform })
              .to_return(
                status: 200,
                body: File.read(
                  'spec/support/responses/fortniteapi.io/lookup/valid_and_do_not_exist.json'
                ),
                headers: { 'Authorization' => api_key, 'Content-Type' => 'application/json' }
              )

            expect(subject.parsed_response).to eq(
              YAML.load_file(
                'spec/support/services/fortnite_api/lookup/valid_and_do_not_exist.yml'
              )
            )
          end
        end
      end

      # TODO: verify response code for DailyRequestLimitExceededError
      context 'and daily request limit is exceeded' do
        xit 'raises a DailyRequestLimitExceededError' do
          expect { subject }
            .to raise_error(described_class::DailyRequestLimitExceededError)
        end
      end
    end

    context 'when API key is not valid' do
      it 'raises a APIKeyNotValidError' do
        stub_request(:get, lookup_uri)
          .with(query: { username: username, platform: platform })
          .to_return(
            status: 200,
            body: File.read('spec/support/responses/fortniteapi.io/lookup/invalid_api_key.json'),
            headers: { 'Authorization' => api_key, 'Content-Type' => 'application/json' }
          )

        expect { subject }.to raise_error(described_class::APIKeyNotValidError)
      end
    end
  end

  describe '#stats' do
    let(:account_id) { '4735ce9132924caf8a5b17789b40f79c' }

    subject { described_class.new(api_key).stats(account_id) }

    context 'when API key is valid' do
      context 'and daily request limit is not exceeded' do
        context 'and account id is valid' do
          it 'returns the stats of the user' do
            stub_request(:get, stats_uri)
              .with(query: { account: account_id })
              .to_return(
                status: 200,
                body: File.read(
                  'spec/support/responses/fortniteapi.io/stats/valid_and_exists.json'
                ),
                headers: { 'Authorization' => api_key, 'Content-Type' => 'application/json' }
              )

            expect(subject.parsed_response).to eq(
              YAML.load_file('spec/support/services/fortnite_api/stats/valid_and_exists.yml')
            )
          end
        end

        context 'and account id is not valid' do
          it 'returns the stats of the user' do
            stub_request(:get, stats_uri)
              .with(query: { account: account_id })
              .to_return(
                status: 200,
                body: File.read(
                  'spec/support/responses/fortniteapi.io/stats/valid_and_do_not_exist.json'
                ),
                headers: { 'Authorization' => api_key, 'Content-Type' => 'application/json' }
              )

            expect(subject.parsed_response).to eq(
              YAML.load_file(
                'spec/support/services/fortnite_api/stats/valid_and_do_not_exist.yml'
              )
            )
          end
        end
      end

      # TODO: verify response code for DailyRequestLimitExceededError
      context 'and daily request limit is exceeded' do
        xit 'raises a DailyRequestLimitExceededError' do
          expect { subject }.to raise_error(described_class::DailyRequestLimitExceededError)
        end
      end
    end

    context 'when API key is not valid' do
      it 'raises a APIKeyNotValidError' do
        stub_request(:get, stats_uri)
          .with(query: { account: account_id })
          .to_return(
            status: 200,
            body: File.read(
              'spec/support/responses/fortniteapi.io/stats/invalid_api_key.json'
            ),
            headers: { 'Authorization' => api_key, 'Content-Type' => 'application/json' }
          )

        expect { subject }.to raise_error(described_class::APIKeyNotValidError)
      end
    end
  end
end
