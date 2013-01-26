require 'spec_helper'

describe ScreenshotFoo::SitemapParser do
  describe "initialization" do
    before do
      @parser = ScreenshotFoo::SitemapParser.new(YAML.load_file(File.dirname(__FILE__) + "/assets/sitemap.yml"))
    end
    it "should set the base url" do
      @parser.base_url.should == "http://localhost:3000"
    end

    it "should create three page objects" do
      @parser.pages.length.should == 3
    end
  end
end
