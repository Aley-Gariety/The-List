//= require jquery
//= require jquery_ujs

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

  $('.suffrage > a').click(function(){
    var _this = $(this),
        direction = _this.attr('class'),
        suffrage = _this.parent(),
        countSpan = _this.siblings('span'),
        origScore = _this.siblings('span').html()

    if (direction == 'up') {
      if ($('.suffrage.downactive').length) {
        countSpan.html(parseInt(origScore) + 2)
      } else if (!$('.suffrage.upactive').length) {
        countSpan.html(parseInt(origScore) + 1)
      }
    } else {
      if ($('.suffrage.upactive').length) {
        countSpan.html(parseInt(origScore) - 2)
      } else if (!$('.suffrage.downactive').length) {
        countSpan.html(parseInt(origScore) - 1)
      }
    }

    suffrage.attr('class','suffrage ' + direction + 'active')

  });

});