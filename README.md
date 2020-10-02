# WBench

WBench is a tool that uses the HTML5 performance timing API to benchmark end user load times for websites. It simulates users visiting your website for the first time, with nothing of your site cached.

## Installation

You can install the latest stable gem by running:

```bash
$ gem install wbench
```

If you are running an older version (1.8) of ruby, you may need the JSON gem.

```bash
$ gem install json
```

You will need to install [Google Chrome](http://www.google.com/chrome) as well as the chromedriver utility.
You can install chromedriver (on OSX) with homebrew:

```bash
$ brew install chromedriver
```

If you are not using Homebrew on OSX, download the latest binary version of [chromedriver](http://chromedriver.storage.googleapis.com/index.html).
Then unpack the ZIP archive and copy the chromedriver binary to the /usr/bin directory:
```bash
$ sudo cp /location/of/chromedriver/binary /usr/bin
```
Test that chromedriver is working by typing "chromedriver":
```bash
$ chromedriver
Starting ChromeDriver (v2.7.236836) on port 9515
```
Note that you will NOT need the chromedriver-utility gem if you install the binary in this manner.

Alternatively you can install firefox and use it with wbench. See [Running other browsers](#running-other-browsers) for more info.

## Usage

### Command Line

Simply enter the URL of a website you want to benchmark. The site will be loaded in the Chrome browser 10 times.

```bash
$ wbench https://www.desktoppr.co/
```

![Example Usage Output](https://github.com/desktoppr/wbench/raw/master/example.png)

### Running other browsers

Chrome is the default browser that is used. You can also use firefox by specifying it on the command line.

```bash
$ wbench -b firefox https://www.desktoppr.co/
```

### Setting the user agent
You can also pass the `-u/--user-agent` option to change the browsers user agent (This can be useful for mobile testing).

```bash
$ wbench -u "Mozilla/5.0 (iPhone; U; ..." https://www.desktoppr.co/
```

### Color output

By default the output will be in color. Piping the results to another process
should correctly remove the coloring. If your terminal doesn't output color, or
you're getting funny symbols in your results then you can remove color from the
output using the `-nc` flag.

```bash
$ wbench -nc https://www.desktoppr.co/
```

### Server performance measuring

Server response times will be reported if the application is a ruby/rack application that returns the `X-Runtime` http header. Without that header the server performance will not be able to be measured.

### Ruby API

You can programatically run the benchmarks. Simply specify the URL and
optionally the amount of runs.

Here is an example of running a benchmark in chrome looping around 3 times.

```ruby

require 'wbench'

benchmark = WBench::Benchmark.new('https://www.desktoppr.co/', :browser => :chrome)
results   = benchmark.run(3) # => WBench::Results

results.app_server # =>
  [25, 24, 24]

results.browser # =>
  {
    "navigationStart"            => [0, 0, 0],
    "fetchStart"                 => [0, 0, 0],
    "domainLookupStart"          => [0, 0, 0],
    "domainLookupEnd"            => [0, 0, 0],
    "connectStart"               => [12, 12, 11],
    "connectEnd"                 => [609, 612, 599],
    "secureConnectionStart"      => [197, 195, 194],
    "requestStart"               => [609, 612, 599],
    "responseStart"              => [829, 858, 821],
    "responseEnd"                => [1025, 1053, 1013],
    "domLoading"                 => [1028, 1055, 1016],
    "domInteractive"             => [1549, 1183, 1136],
    "domContentLoadedEventStart" => [1549, 1183, 1136],
    "domContentLoadedEventEnd"   => [1549, 1184, 1137],
    "domComplete"                => [2042, 1712, 1663],
    "loadEventStart"             => [2042, 1712, 1663],
    "loadEventEnd"               => [2057, 1730, 1680]
  }

results.latency # =>
  {
    "a.desktopprassets.com"         => [352, 15, 15],
    "beacon-1.newrelic.com"         => [587, 235, 248],
    "d1ros97qkrwjf5.cloudfront.net" => [368, 14, 14],
    "ssl.google-analytics.com"      => [497, 14, 14],
    "www.desktoppr.co"              => [191, 210, 203]
  }
```

### Benchmarking authenticated pages

Benchmarking authenticated pages is possible using the ruby API. The API
provides direct access to the selenium session. The session allows us to visit
a login page before our test page, for example:

```ruby
require 'wbench'

benchmark = WBench::Benchmark.new('https://www.desktoppr.co/dashboard', :browser => :chrome)
benchmark.before_each do
  visit 'https://www.desktoppr.co/login'
  fill_in 'Login', :with => 'mario'
  fill_in 'Password', :with => 'super secret'
  click_button 'Log In'
end

results = benchmark.run(3) # => WBench::Results
```

Please note that by visiting pages before each run, your browser may cache some
assets. This means that when the benchmark is run against the authenticated
page, some assets may be loaded from the cache, and the result may appear
quicker than an uncahed visit.


### Setting cookies

You can pass the `-c` flag to wbench to set a cookie before benchmarking the
page, this can be used similarly with the method listed above for testing
authenticated pages, as well as any other cookies you would like the browser to use.

One problem with this approach is that we have to visit the homepage before
setting the cookie, this means that some assets may be cached during the visit,
skewing your results for the actual page load.

The cookie format is the same used for curl, so an example might be

```bash
$ wbench -c "session_id=4000; theme=blue" https://www.desktoppr.co/wallpapers
```

### Custom event timings

Custom events are available to instrument through wbench. To do so use the native HTML5 function `window.performance.mark` like so:

```javascript
if(typeof(window.performance) === 'object' && typeof(window.performance.mark) == 'function') {
  window.performance.mark('my custom event');
}
```

You can use the `onload` event handler to call the JavaScript above to instrument when certain elements (images for example) are loaded. Currently this only works in google chrome, so we need to protect against the function not being available.


### Gisting results

You can install the [Github gist gem](https://github.com/defunkt/gist) and pipe in the results of wbench

```bash
$ gem install gist

$ wbench http://www.google.com.au/ | gist -d "Google homepage"
```
