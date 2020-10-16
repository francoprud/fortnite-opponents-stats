require 'spec_helper'

RSpec.describe FortniteOpponentsStats::KillFeedParser do
  describe 'self.parse' do
    subject { described_class }

    actions = YAML.load_file('spec/support/kill_feed_parser/actions.yml')
    usernames = YAML.load_file('spec/support/kill_feed_parser/usernames.yml')

    actions.each_with_index do |action, index|
      it "returns the correct usernames from action #{index + 1}" do
        expect(subject.parse(action)).to eq(usernames[index])
      end
    end
  end
end
