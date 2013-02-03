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

You can programatically run the benchmarks. Simply specify the URL and
optionally the amount of runs.

```bash

require 'wbench'

results = WBench::Test.run('https://www.google.com/', 10) # => WBench::Results
```

## TODO
- Add ability to [gist](https://gist.github.com/) results
- Add ability to use different browsers (firefox and IE)
- Allow stats collection through the ruby API.
