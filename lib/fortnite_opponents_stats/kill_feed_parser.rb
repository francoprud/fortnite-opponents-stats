module FortniteOpponentsStats
  class KillFeedParser
    AIS = ['Doctor Doom', 'Doom Henchmen', 'Stark Robot', 'Iron Man', 'Wolverine', 'Shark'].freeze
    POSSIBLE_ACTIONS = ['shotgunned', 'eliminated', 'finally eliminated', 'sniped', 'NO-SCOPED',
                        'bludgeoned', 'dealt it and', 'Infinity Blade erased', 'shivered', 'burst',
                        'flushed', 'dropped anchor on', 'sent', 'arrested', 'ZAPPED', 'CANcelled',
                        'smote', 'skewered', 'flattened', "'sploded"].freeze

    class << self
      def parse(feed)
        usernames = [[], []] # usernames[0] for left usernames, usernames[1] for right usernames 
        lines = feed.split("\n") # Split by lines
        lines.each do |line|
          left, right = split_by_left_and_right(line)
          usernames[0] << parse_username(left)
          usernames[1] << parse_username(right)
        end
        usernames[0].compact!
        usernames[1].compact!
        usernames
      end

      private

      def split_by_left_and_right(line)
        POSSIBLE_ACTIONS.each do |action|
          return line.split(/\s#{action}\s/) if line.match(/#{action}/)
        end
        nil
      end

      def parse_username(string)
        return if string.nil? || AIS.any? { |ai| string.include?(ai) }
        return unless (name = string.match(/(.*)\s\(\d+\)/))
        name[1]
      end
    end
  end
end
