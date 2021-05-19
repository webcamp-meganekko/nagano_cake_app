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
//= require jquery_ujs
//
//= require jquery
//= require rails-ujs
//= require activestorage
//= require turbolinks
//= require_tree .


$(window).on('turbolinks:load',function(){
$("#splash").delay(1500).fadeOut('slow',function(){//ローディングエリア（splashエリア）を1.5秒でフェードアウトする記述
$('body').addClass('appear');//フェードアウト後bodyにappearクラス付与
var h = $(window).height();//ブラウザの高さを取得
$(".splashbg").css({
"border-width":h,//ボーダーの太さにブラウザの高さを代入
"animation-name":"backBoxAnime"//animation-nameを定義
});
});
$("#splash-logo").delay(1200).fadeOut('slow');//ロゴを1.2秒でフェードアウトする記述
});
