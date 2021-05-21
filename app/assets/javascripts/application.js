// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.

//= require jquery3
//= require popper
//= require bootstrap-sprockets
//= require jquery
//
//= require jquery
//= require rails-ujs
//= require activestorage
//= require turbolinks
//= require_tree .


$(window).on('turbolinks:load',function(){
  $("#splash").delay(4000).fadeOut(800);//ローディング画面を1.5秒（1500ms）待機してからフェードアウト
  $("#splash_logo").delay(1200).fadeOut('slow',function(){
      $("#splash_logo2").css('opacity','1');
      $("#splash_logo2").addClass('fadeUp');
  });
});

$(function(){
  var time = 300;

  var image = $('.filter');
  image.filter(':nth-child(1)')
  .on('mouseover',function(){
    $(this).find('strong, span').stop(true).animate({
      opacity:'1'
    },time);
  })
  .on('mouseout', function(){
    $(this).find('strong, span').stop(true).animate({
      opacity:0
    },time);
  });
});



function fadeAnime(){

$('.fadeInUpTrigger').each(function(){
　　var elemPos = $(this).offset().top-50;
　　var scroll = $(window).scrollTop();
　　var windowHeight = $(window).height();
　　if (scroll >= elemPos - windowHeight){
　　$(this).addClass('fadeIn');
　　}else{
　　　$(this).removeClass('fadeIn');
　　}
　　});

$('.fadeInDownTrigger').each(function(){
　　var elemPos = $(this).offset().top-50; 
　　var scroll = $(window).scrollTop();
　　var windowHeight = $(window).height();
　　if (scroll >= elemPos - windowHeight){
　　$(this).addClass('fadeDown');
　　}else{
　　　$(this).removeClass('fadeDown');
　　}
　　});
}

  $(window).scroll(function (){
    fadeAnime();
  });
  
function fadeAnime(){

  $('.fadeUpTrigger').each(function(){ 
    var elemPos = $(this).offset().top-50;
    var scroll = $(window).scrollTop();
    var windowHeight = $(window).height();
    if (scroll >= elemPos - windowHeight){
    $(this).addClass('fadeUp');
    }else{
    $(this).removeClass('fadeUp');
    }
    });
}

  $(window).scroll(function (){
    fadeAnime();
  });

	$(window).on('load', function(){
		delayScrollAnime();
	});