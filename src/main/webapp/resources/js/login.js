

$.noConflict();
var jb= jQuery;
jb(document).ready(function($) {
jb('#login-button').click(function(){
  jb('#login-button').fadeOut("slow",function(){
    jb("#container").fadeIn();
    TweenMax.from("#container", .4, { scale: 0, ease:Sine.easeInOut});
    TweenMax.to("#container", .4, { scale: 1, ease:Sine.easeInOut});
  });
});

jb(".close-btn").click(function(){
  TweenMax.from("#container", .4, { scale: 1, ease:Sine.easeInOut});
  TweenMax.to("#container", .4, { left:"0px", scale: 0, ease:Sine.easeInOut});
  jb("#container, #forgotten-container").fadeOut(800, function(){
    jb("#login-button").fadeIn(800);
  });
});

/* Forgotten Password */
jb('#forgotten').click(function(){
  jb("#container").fadeOut(function(){
    jb("#forgotten-container").fadeIn();
  });
});

jb('#submit').on("click",function(){
	
	$('#loginform').submit();
})

});