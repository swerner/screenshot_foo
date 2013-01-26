module ScreenshotFoo
  class Page
    attr_accessor :name, :url

    def initialize(hash)
      @url = hash[:base_url] + hash[:page]["path"]
      @name = hash[:page]["name"]
    end
  end
end
