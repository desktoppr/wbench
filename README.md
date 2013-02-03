# WBench

WBench is a tool that uses the HTML5 performance timing API to benchmark end user load times for websites.

## Installation

```bash
$ gem install wbench
```

## Usage

### Command Line

Simply enter the URL of a website you want to test. The site will be loaded in the Chrome browser 10 times.

```bash
$ wbench https://www.desktoppr.co/
```

![Example Usage Output](https://github.com/desktoppr/wbench/raw/master/example.png)

### Ruby API

You can programatically run the tests using:

```bash

require 'wbench'

url   = 'https://www.google.com/'
loops = 10

results = WBench::Test.run(url, loops) # => WBench::Results
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
