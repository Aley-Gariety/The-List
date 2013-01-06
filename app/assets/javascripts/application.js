//= require jquery

$(function(){
  $('style').html($('style').html().replace(/\(([^\)]+)\)/,'(max-width: ' + ($('h1').width() + $('.meta-header').width() + 60) + 'px)'))
});