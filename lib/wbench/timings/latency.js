/* Add JavaScript to the page */
var jQscript=document.createElement('script');
jQscript.src='https://ajax.googleapis.com/ajax/libs/jquery/1.9.0/jquery.min.js';
document.documentElement.appendChild(jQscript);

window.resourceURLs = function() {
  return backgroundURLs().concat(imageURLs(), scriptURLs(), linkURLs(), currentURL());
}

window.backgroundURLs = function() {
  backgroundURLs = new Array();

  $('*').each(function() {
    if ($(this).css('background').match('url')) {
      backgroundURLs.push($(this).css('background').match(/url\((.*)\)/)[1]);
    }
  });

  return backgroundURLs;
}

window.imageURLs = function() {
  imageURLs = new Array();

  $('img').each(function() {
    if ($(this).attr('src')) {
      imageURLs.push($(this).attr('src'));
    }
  });

  return imageURLs;
}

window.scriptURLs = function() {
  scriptURLs = new Array();

  $('script').each(function() {
    if ($(this).attr('src')) {
      scriptURLs.push($(this).attr('src'));
    }
  });

  return scriptURLs;
}


window.linkURLs = function() {
  linkURLs = new Array();

  $('link').each(function() {
    if ($(this).attr('href')) {
      linkURLs.push($(this).attr('href'));
    }
  });

  return linkURLs;
}

window.currentURL = function() {
  return [window.location.href];
}
