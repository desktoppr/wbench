window.WBench = {
  resourceURLs: function() {
    urls = this.backgroundURLs().concat(this.imageURLs(), this.scriptURLs(), this.linkURLs(), [this.currentURL()]);

    return this.stringify(this.parseURLs(urls));
  },

  stringify: function (obj) {
    return JSON.stringify(obj);
  },

  parseURLs: function(urls) {
    return(urls.map(function(url) {
      if (url.match(/^\/\//)) {
        return 'http:' + url;
      }
      else if (url.match(/^https?/)) {
        return url;
      }
      else {
        return window.location.origin + '/' + url;
      }
    }));
  },

  backgroundURLs: function() {
    backgroundURLs = [];

    elements = document.getElementsByTagName('*');
    length   = elements.length;

    for (var i = 0; i < length; i++) {
      background = window.getComputedStyle(elements[i])['background'];

      if(background.match('url')) {
        backgroundURLs.push(background.match(/url\((.*?)\)/)[1]);
      }
    }

    return backgroundURLs;
  },

  imageURLs: function() {
    imageURLs = [];

    images = document.images;
    length = images.length;

    for (var i = 0; i < length; i++) {
      src = images[i]['src'];

      if (src) {
        imageURLs.push(src);
      }
    }
    return imageURLs;
  },

  scriptURLs: function() {
    scriptURLs = [];

    scripts = document.scripts;
    length  = scripts.length;

    for (var i = 0; i < length; i++) {
      src = scripts[i]['src'];

      if (src) {
        scriptURLs.push(src);
      }
    }

    return scriptURLs;
  },

  linkURLs: function() {
    linkURLs = [];

    links  = document.getElementsByTagName('link');
    length = links.length;

    for (var i = 0; i < length; i++) {
      href = links[i]['href'];

      if (href) {
        linkURLs.push(src);
      }
    }

    return linkURLs;
  },

  currentURL: function() {
    return window.location.href;
  },

  performanceTimings: function() {
    if (typeof window.performance.timing === 'undefined') return {};

    var resultTimings = Object.keys(window.performance.timing.__proto__).reduce(function(memo, name) {
      if (typeof window.performance.timing[name] !== 'number') return memo;
      memo[name] = window.performance.timing[name];
      return memo;
    }, {});

    // Use user defined timings that are added via window.performance.mark('event name')
    if(typeof(window.performance.getEntriesByType) === 'function') {
      window.performance.getEntriesByType('mark').forEach(function(item) {
        resultTimings[item.name] = Math.ceil(window.performance.timing.navigationStart + item.startTime);
      });
    }

    return resultTimings;
  },

  /* This function only works in chrome with the --enable-precise-memory-info flag */
  performanceMemory: function() {
    if (typeof window.performance.memory === 'undefined') return {};

    var resultsMemory = Object.keys(window.performance.memory.__proto__).reduce(function(memo, name) {
      if (typeof window.performance.memory[name] !== 'number') return memo;
      memo[name] = window.performance.memory[name];
      return memo;
    }, {});

    return resultsMemory;
  }
};
