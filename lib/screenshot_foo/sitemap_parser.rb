module ScreenshotFoo
  class SitemapParser
    attr_reader :base_url, :pages

    def initialize(yaml)
      @base_url = yaml["base_url"]
      @pages = []

      yaml["pages"].each do |page|
        @pages << ScreenshotFoo::Page.new(base_url: @base_url, page: page)
      end
    end
  end
end
