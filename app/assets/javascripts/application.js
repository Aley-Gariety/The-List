//= require jquery

$(function(){

  var rtime = new Date(1, 1, 2000, 12,00,00),
      timeout = false,
      delta = 200,
      mediaQueries =  $('style')

  function setMediaQuery() {
    mediaQueries.html(mediaQueries.html().replace(/\(([^\)]+)\)/,'(max-width: ' + ($('h1').width() + $('.meta-header').width() + 60) + 'px)'));
  }

  $(window).resize(function() {
      rtime = new Date();
      if (timeout === false) {
          timeout = true;
          setTimeout(resizeend, delta);
      }
  });

  function resizeend() {
      if (new Date() - rtime < delta) {
          setTimeout(resizeend, delta);
      } else {
          timeout = false;
          setMediaQuery()
      }
  }

});