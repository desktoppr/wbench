window.resourceURLs = function() {
  urls = backgroundURLs().concat(imageURLs(), scriptURLs(), linkURLs(), currentURL());

  return jQuery.map(urls, function(url) {
    if (url.match(/^\/\//)) {
      return 'http:' + url;
    }
    else if (url.match(/^https?/)) {
      return url;
    }
    else {
      return window.location.origin + '/' + url;
    }
  });
}

window.backgroundURLs = function() {
  backgroundURLs = new Array();

  jQuery('*').each(function() {
    if (jQuery(this).css('background').match('url')) {
      backgroundURLs.push(jQuery(this).css('background').match(/url\((.*?)\)/)[1]);
    }
  });

  return backgroundURLs;
}

window.imageURLs = function() {
  imageURLs = new Array();

  jQuery('img').each(function() {
    if (jQuery(this).attr('src')) {
      imageURLs.push(jQuery(this).attr('src'));
    }
  });

  return imageURLs;
}

window.scriptURLs = function() {
  scriptURLs = new Array();

  jQuery('script').each(function() {
    if (jQuery(this).attr('src')) {
      scriptURLs.push(jQuery(this).attr('src'));
    }
  });

  return scriptURLs;
}

window.linkURLs = function() {
  linkURLs = new Array();

  jQuery('link').each(function() {
    if (jQuery(this).attr('href')) {
      linkURLs.push(jQuery(this).attr('href'));
    }
  });

  return linkURLs;
}

window.currentURL = function() {
  return [window.location.href];
}
