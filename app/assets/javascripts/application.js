//= require jquery
//= require jquery_ujs

function htmlDecode(input){
  var e = document.createElement('div');
  e.innerHTML = input;
  return e.childNodes[0].nodeValue;
}

function getUrlVars() {
  var vars = {}
  var parts = window.location.href.replace(/[?&]+([^=&]+)=([^&]*)/gi, function(m,key,value) {
    vars[key] = decodeURIComponent(value)
  })
  return vars
}

(function(){
	var small = "(a|an|and|as|at|but|by|en|for|if|in|of|on|or|the|to|v[.]?|via|vs[.]?)";
	var punct = "([!\"#$%&'()*+,./:;<=>?@[\\\\\\]^_`{|}~-]*)";

	this.titleCaps = function(title){
		var parts = [], split = /[:.;?!] |(?: |^)["Ò]/g, index = 0;

		while (true) {
			var m = split.exec(title);

			parts.push( title.substring(index, m ? m.index : title.length)
				.replace(/\b([A-Za-z][a-z.'Õ]*)\b/g, function(all){
					return /[A-Za-z]\.[A-Za-z]/.test(all) ? all : upper(all);
				})
				.replace(RegExp("\\b" + small + "\\b", "ig"), lower)
				.replace(RegExp("^" + punct + small + "\\b", "ig"), function(all, punct, word){
					return punct + upper(word);
				})
				.replace(RegExp("\\b" + small + punct + "$", "ig"), upper));

			index = split.lastIndex;

			if ( m ) parts.push( m[0] );
			else break;
		}

		return parts.join("").replace(/ V(s?)\. /ig, " v$1. ")
			.replace(/(['Õ])S\b/ig, "$1s")
			.replace(/\b(AT&T|Q&A)\b/ig, function(all){
				return all.toUpperCase();
			});
	};

	function lower(word){
		return word.toLowerCase();
	}

	function upper(word){
	  return word.substr(0,1).toUpperCase() + word.substr(1);
	}
})();

$(function(){

  var mediaQueries =  $('style'),
      timer,
      url = new RegExp("^(http[s]?:\\/\\/(www\\.)?|ftp:\\/\\/(www\\.)?|www\\.){1}([0-9A-Za-z-\\.@:%_\+~#=]+)+((\\.[a-zA-Z]{2,3})+)(/(.)*)?(\\?(.)*)?");

  function setMediaQuery() {
    mediaQueries.html(mediaQueries.html().replace(/\(([^\)]+)\)/,'(max-width: ' + ($('.meta-header').width() + 258) + 'px)'))
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

  $(".quote").click(function(){
    $("#comment_body").val("<i>Written by " + $(this).siblings(".comment-meta").children("a").find("b").html() + ":</i>\n > " + $(this).siblings(".comment-body").html() + $("#comment_body").val())
    $("html, body").animate({ scrollTop: $(document).height() }, "fast");
  });

  // Auto-fill the title field
  function fetchTitle() {
    setTimeout(function(){
      if (url.test($("#post_url").val()) && $("#post_title").val() == "") {
        $.ajax({
          url: "/posts/fetch-title",
          data: {
            url: encodeURI($("#post_url").val())
          },
          success: function(data){
            if (data) {
              $("#post_title").val(titleCaps(htmlDecode(data)))
            }
          }
        })
      }
    },0)
  }

  $("#post_url").on("paste, keydown",fetchTitle)

  // Bookmarklet tooltip
  $("#bookmarklet").hover(function(){
    $(document).mousemove(function(e){
        $("#dragme").css({
        "display": "inline",
        "top": e.pageY + 10,
        "left": e.pageX + 10
      })
    });
  }, function(){
    $("#dragme").css("display","none")
    $(document).off("mousemove")
  })

  // Toggle upvotes/downvotes/total
  $(".suffrage span").click(function(){
    var str,
      $this = $(this)

    clearTimeout(timer)
    timer = setTimeout(function(){
      $(".suffrage span").each(function(){
        $(this).html($(this).attr("data-total")).removeAttr("class")
      })
    }, 1500)

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