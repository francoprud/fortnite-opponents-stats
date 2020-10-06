require 'mini_magick'
require 'rtesseract'

module FortniteOpponentsStats
  class ImageReader
    def self.read(img_path)
      grayscale_conversion(img_path)
      negate_conversion(img_path)
      read_image(img_path)
    end

    private

    def grayscale_conversion(img_path)
      MiniMagick::Image.new(img_path) { |image| image.colorspace('Gray') }
    end

    def negate_conversion(img_path)
      MiniMagick::Tool::Magick.new do |magick|
        magick << img_path
        magick.negate
        magick << img_path
      end
    end

    def read_image(img_path)
      RTesseract.new(img_path).to_s
    end
  end
end
