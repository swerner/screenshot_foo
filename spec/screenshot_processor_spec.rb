require 'spec_helper'

describe ScreenshotFoo::ScreenshotProcessor do
  before do
    @pages = ScreenshotFoo::SitemapParser.new(YAML.load_file(File.dirname(__FILE__) + "/assets/sitemap.yml")).pages

    @webdriver = double(:webdriver).as_null_object

    @processor = ScreenshotFoo::ScreenshotProcessor.new(@pages)
    @processor.stub(:hashes_match?).and_return(true)

    Selenium::WebDriver.stub(:for).and_return(@webdriver)
  end

  describe "process" do
    it "should call process_page one time for every page" do
      @processor.should_receive(:process_page).exactly(@pages.count).times
      @processor.process
    end
  end

  describe "process_page" do
    context "no screenshot exists" do
      it "creates a new screenshot for the page" do
        first_page = @processor.pages.first
        @webdriver.should_receive(:get).with("http://localhost:3000/")
        @webdriver.should_receive(:save_screenshot).with("./screenshot_foo/home.png")

        @processor.process_page(first_page)
      end
    end

    context "screenshot already exists" do
      before do
        @first_page = @processor.pages.first
        File.stub(:exists?).with("./screenshot_foo/#{@first_page.name}.png").and_return(true)
      end

      it "should create a new screenshot with _new appended to the name" do
        @webdriver.should_receive(:get).with("http://localhost:3000/")
        @webdriver.should_receive(:save_screenshot).with("./screenshot_foo/home_new.png")
        File.stub(:delete)

        @processor.process_page(@first_page)
      end

      context "screenshot hashes match" do
        it "destroys the screenshot with _new" do
          File.should_receive(:delete).with("./screenshot_foo/home_new.png")

          @processor.process_page(@first_page)
        end
      end

      context "screenshot hashes do not match" do
        it "creates an image diff" do
          image = double(:image).as_null_object
          ChunkyPNG::Image.stub(:from_file).and_return(image)

          @processor.stub(:hashes_match?).and_return(false)

          image.should_receive(:rect)
          image.should_receive(:save).with("./screenshot_foo/home_diff.png")

          @processor.process_page(@first_page)
        end
      end
    end
  end
end
