require 'tty-cursor'
require 'tty-table'
require 'byebug'

module FortniteOpponentsStats
  module Helpers
    class Terminal
      HEADERS = ['Username', 'KD Solos', 'KD Duos', 'KD Squads', 'KD Average'].freeze

      def initialize
        @cursor = TTY::Cursor
      end

      def print(users_with_stats)
        table = TTY::Table.new(HEADERS, rows(users_with_stats))
        renderer = TTY::Table::Renderer::Unicode.new(table, alignment: [:center])
        puts @cursor.clear_screen
        puts @cursor.move_to # Move to origin
        puts renderer.render
      end

      private

      def rows(users_with_stats)
        rows = []
        users_with_stats[0].each do |user|
          next unless user['global_stats']
          rows << calculate_stats(user)
        end
        rows.sort_by { |user| -user[4] }
      end

      def calculate_stats(user)
        return unless user['global_stats']
        row = []
        %w[solo duo squad].each do |match_type|
          row << (user['global_stats'][match_type] ? user['global_stats'][match_type]['kd'] : nil)
        end
        compacted_row = row.compact
        row << (compacted_row.sum(0) / compacted_row.length).round(2)
        row.unshift(user['name'])
      end
    end
  end
end
