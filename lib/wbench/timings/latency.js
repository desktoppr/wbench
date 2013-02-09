function addjQuery() {
  var jQscript=document.createElement('script');
  jQscript.src='https://ajax.googleapis.com/ajax/libs/jquery/1.9.0/jquery.min.js';
  document.documentElement.appendChild(jQscript);
}

function backgroundURLs() {
  backgroundURLs = new Array();

  $('*').each(function() {
    if ($(this).css('background').match('url')) {
      backgroundURLs.push($(this).css('background').match(/url\((.*)\)/)[1]);
    }
  });

  return backgroundURLs;
}
