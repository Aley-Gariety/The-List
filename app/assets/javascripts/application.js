//= require jquery
//= require jquery_ujs

$(function(){

  var mediaQueries =  $('style'),
      timer

  function setMediaQuery() {
    mediaQueries.html(mediaQueries.html().replace(/\(([^\)]+)\)/,'(max-width: ' + ($('.meta-header').width() + 258) + 'px)'))
  }

  function getUrlVars() {
    var vars = {}
    var parts = window.location.href.replace(/[?&]+([^=&]+)=([^&]*)/gi, function(m,key,value) {
      vars[key] = decodeURIComponent(value)
    })
    return vars
  }

  $(window).resize(setMediaQuery)

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

  })

  $('#user_name').val(getUrlVars()['name'])
  $('#user_email').val(getUrlVars()['email'])
  $('#post_title').val(getUrlVars()['t'])
  $('#post_url').val(getUrlVars()['u'])

  $(".suffrage span").click(function(){
    var str,
      $this = $(this)

    clearTimeout(timer)
    timer = setTimeout(function(){
      $(".suffrage span").each(function(){
        $(this).html($(this).attr("data-total")).removeAttr("class")
      })
    }, 2000)

    if ($this.hasClass("up-toggled")) {
      str = "down"
    } else if ($this.hasClass("down-toggled")) {
      str = "total"
    } else {
      str = "up"
    }

    $(".suffrage span").each(function(){
      $(this).html($(this).attr("data-total")).removeAttr("class")
    })
    $(this).html($(this).attr("data-" + str)).attr("class",str + "-toggled")
  })
})