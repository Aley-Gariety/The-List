//= require jquery
//= require jquery_ujs

$(function(){

  var mediaQueries =  $('style')

  function setMediaQuery() {
    mediaQueries.html(mediaQueries.html().replace(/\(([^\)]+)\)/,'(max-width: ' + ($('.meta-header').width() + 258) + 'px)'));
  }

  $(window).resize(setMediaQuery);

  $('.suffrage > a').click(function(){
    var _this = $(this),
        direction = _this.attr('class'),
        suffrage = _this.parent(),
        countSpan = _this.siblings('span'),
        origScore = parseInt(_this.siblings('span').html()),
        increment = parseInt(suffrage.attr('data-value')) || 1

    if (direction == 'up' && !suffrage.hasClass('upactive')) {
      if (suffrage.hasClass('downactive')) {
        countSpan.html(parseInt(origScore) + (increment * 2))
      } else {
        countSpan.html(parseInt(origScore) + increment)
      }
    } else if (direction == 'down' && !suffrage.hasClass('downactive')) {
      if (suffrage.hasClass('upactive')) {
        countSpan.html(parseInt(origScore) - (increment * 2))
      } else {
        countSpan.html(parseInt(origScore) - increment)
      }
    }

    suffrage.attr('class','suffrage ' + direction + 'active')

  });

});