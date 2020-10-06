require 'mini_magick'
require 'rtesseract'

module FortniteOpponentsStats
  class ImageReader
    # Second argument is passed just for test purposes
    def self.read(image_path, output_path = nil)
      grayscale_conversion(image_path, output_path)
      negate_conversion(image_path, output_path)
      read_image(image_path, output_path)
    end

    private

    def grayscale_conversion(image_path, output_path = nil)
      image = MiniMagick::Image.open(image_path)
      image.colorspace('Gray')
      image.write(output_path || image_path)
    end

    def negate_conversion(image_path, output_path = nil)
      MiniMagick::Tool::Magick.new do |magick|
        magick << (output_path || image_path)
        magick.negate
        magick << (output_path || image_path)
      end
    end

    def read_image(image_path, output_path = nil)
      RTesseract.new(output_path || image_path).to_s
    end
  end
end
