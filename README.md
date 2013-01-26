# ScreenshotFoo

This gem reads through a sitemap.yml file in the root of your project.

If it finds a screenshot with the declared name, it takes a new temporary one and compares the two hashes.

If the hashes are different, it diffs the images and shows you where the two files differ.

You can then decide to fix the issue or rename the new file to be the reference screenshot.

## Installation

Add this line to your application's Gemfile:

    gem 'screenshot_foo'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install screenshot_foo

## Usage

TODO: Write usage instructions here

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

## Thanks

### Jeff Kreeftmeijer
For the code samples in: http://jeffkreeftmeijer.com/2011/comparing-images-and-creating-image-diffs/
