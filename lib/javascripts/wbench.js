window.WBench = {
  resourceURLs: function() {
    urls = this.backgroundURLs().concat(this.imageURLs(), this.scriptURLs(), this.linkURLs(), [this.currentURL()]);

    return this.stringify(this.parseURLs(urls));
  },

  /*
   * Originally from: http://blogs.sitepointstatic.com/examples/tech/json-serialization/json-serialization.js
   * Modified slightly by Mario Visic
   */
  stringify: function (obj) {
    var t = typeof (obj);
    if (t != "object" || obj === null) {
      /* simple data type */
      if (t == "string") obj = '"'+obj+'"';
      return String(obj);
    }
    else {
      /* recurse array or object */
      var n, v, json = [], arr = (obj && obj.constructor == Array);

      for (n in obj) {
        v = obj[n]; t = typeof(v);

        if (t == "string") v = '"'+v+'"';
        else if (t == "object" && v !== null) v = JSON.stringify(v);

        json.push((arr ? "" : '"' + n + '":') + String(v));
      }

      return (arr ? "[" : "{") + String(json) + (arr ? "]" : "}");
    }
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
  }
}
