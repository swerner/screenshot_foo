require "spec_helper"

describe ScreenshotFoo::Page do
  describe "initialization" do
    before do
      @page = ScreenshotFoo::Page.new({base_url: "http://localhost:3000", page: { "name" => "home", "path" => "/"}})
    end

    it "should set the url with the path and the base_url" do
      @page.url.should == "http://localhost:3000/"
    end

    it "should set the page name based on the title param" do
      @page.name.should == "home"
    end
  end
end
