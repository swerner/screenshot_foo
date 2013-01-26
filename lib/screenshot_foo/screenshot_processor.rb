module ScreenshotFoo
  class ScreenshotProcessor
    attr_accessor :pages

    def initialize(pages)
      @pages = pages
    end

    def process
      @pages.each{ |page| process_page(page) }
    end

    def process_page(page)
      if File.exists?("./screenshot_foo/#{page.name}.png")
        take_screenshot(url: page.url, file: "#{page.name}_new")

        base_screenshot = "./screenshot_foo/#{page.name}.png"
        new_screenshot = "./screenshot_foo/#{page.name}_new.png"

        if hashes_match?(base_screenshot, new_screenshot)
          File.delete(new_screenshot)
        else
          create_diff(page.name, base_screenshot, new_screenshot)
        end
      else
        take_screenshot(url: page.url, file: page.name)
      end
    end

    private
    def take_screenshot(page_info)
      Dir.mkdir("./screenshots/") unless File.exists?("./screenshot_foo/")
      webdriver = Selenium::WebDriver.for :firefox
      webdriver.get page_info[:url]
      webdriver.save_screenshot("./screenshots/#{page_info[:file]}.png")
      webdriver.quit
    end

    def hashes_match?(file1, file2)
      Digest::MD5.hexdigest(File.read(file1)) == Digest::MD5.hexdigest(File.read(file2))
    end

    def create_diff(name, base_screenshot, new_screenshot)
      images = [
        ChunkyPNG::Image.from_file(base_screenshot),
        ChunkyPNG::Image.from_file(new_screenshot)
      ]

      diff = []

      images.first.height.times do |y|
        images.first.row(y).each_with_index do |pixel, x|
          diff << [x,y] unless pixel == images.last[x,y]
        end
      end

      x, y = diff.map{ |xy| xy[0] }, diff.map{ |xy| xy[1] }

      images.last.rect(x.min, y.min, x.max, y.max, ChunkyPNG::Color.rgb(255, 0, 0))
      images.last.save("./screenshot_foo/#{name}_diff.png")
    end
  end
end
