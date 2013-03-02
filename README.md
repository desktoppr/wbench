# WBench

WBench is a tool that uses the HTML5 performance timing API to benchmark end user load times for websites. It simulates users visiting your website for the first time, with nothing of your site cached.

## Installation

You can install the latest stable gem by running:

```bash
$ gem install wbench
```

If you're running an older version (1.8) of ruby, you'll need the JSON gem.

```bash
$ gem install json
```

You will need to install [Google Chrome](http://www.google.com/chrome) as well as the chromedriver utility.
You can install chromedriver (on OSX) with homebrew:

```bash
brew install chromedriver
```

Alternatively you can install firefox and use it with wbench. See [Running other browsers](#running-other-browsers) for more info.

## Usage

### Command Line

Simply enter the URL of a website you want to benchmark. The site will be loaded in the Chrome browser 10 times.

```bash
wbench https://www.desktoppr.co/
```

![Example Usage Output](https://github.com/desktoppr/wbench/raw/master/example.png)

### Running other browsers and user-agents

Chrome is the default browser that is used. You can also use firefox by specifying it on the command line. If `-u/--user-agent` is not passed, browsers' default user-agent value will be used.

```bash
wbench -b firefox -u '... user-agent string ...' https://www.desktoppr.co/
```

### Ruby API

You can programatically run the benchmarks. Simply specify the URL and
optionally the amount of runs.

```bash

require 'wbench'

results = WBench::Benchmark.run('https://www.desktoppr.co/', :loops => 3, :browser => :chrome) # => WBench::Results

results.app_server # =>
  [25, 24, 24]

results.browser # =>
  {"navigationStart"=>[0, 0, 0], "fetchStart"=>[0, 0, 0],
  "domainLookupStart"=>[0, 0, 0], "domainLookupEnd"=>[0, 0, 0],
  "connectStart"=>[12, 12, 11], "connectEnd"=>[609, 612, 599],
  "secureConnectionStart"=>[197, 195, 194], "requestStart"=>[609, 612, 599],
  "responseStart"=>[829, 858, 821], "responseEnd"=>[1025, 1053, 1013],
  "domLoading"=>[1028, 1055, 1016], "domInteractive"=>[1549, 1183, 1136],
  "domContentLoadedEventStart"=>[1549, 1183, 1136],
  "domContentLoadedEventEnd"=>[1549, 1184, 1137], "domComplete"=>[2042, 1712,
  1663], "loadEventStart"=>[2042, 1712, 1663], "loadEventEnd"=>[2057, 1730,
  1680]}

results.latency # =>
  {"a.desktopprassets.com"=>[352, 15, 15],
  "beacon-1.newrelic.com"=>[587, 235, 248],
  "d1ros97qkrwjf5.cloudfront.net"=>[368, 14, 14],
  "ssl.google-analytics.com"=>[497, 14, 14], "www.desktoppr.co"=>[191, 210, 203]}
```

## TODO
- Add ability to [gist](https://gist.github.com/) results
