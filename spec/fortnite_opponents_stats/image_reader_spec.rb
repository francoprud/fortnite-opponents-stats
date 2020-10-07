require 'spec_helper'

RSpec.describe FortniteOpponentsStats::ImageReader do
  describe 'self.read', :files do
    subject { described_class }

    screenshots_text = YAML.load_file('spec/support/image_reader/screenshots_text.yml')

    screenshots_text.each do |screenshot_text|
      it "returns the correct text from screenshot_#{screenshot_text[0]}" do
        expect(
          subject.read("spec/support/screenshots/screenshot_#{screenshot_text[0]}.png",
                       "tmp/specs/screenshot_#{screenshot_text[0]}.png")
        ).to eq(screenshot_text[1])
      end
    end
  end
end
