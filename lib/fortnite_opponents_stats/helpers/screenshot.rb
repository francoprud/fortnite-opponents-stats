module FortniteOpponentsStats
  module Helpers
    class Screenshot
      def initialize(**options)
        @monitor_number = options[:monitor_number] || 1
        @px_top = options[:px_top] || 0
        @px_left = options[:px_left] || 0
        @px_width = options[:px_width] || 1
        @px_height = options[:px_height] || 1
        @output = options[:output] || './screenshots'
      end

      def capture
        `python3 ./scripts/take_screenshot.py #{build_script_params}` # Run pyhton3 script
        filename = Dir.entries(@output).select { |fn| fn.match(/png/) }.min
        "#{@output}/#{filename}"
      end

      def delete(path)
        File.delete(path)
      end

      private

      def build_script_params
        "#{@monitor_number} #{@px_top} #{@px_left} #{@px_width} #{@px_height} #{@output}"
      end
    end
  end
end
