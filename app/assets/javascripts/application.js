// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//
//= require jquery
//= require jquery_ujs
//= require_tree .

$(document).ready(function() {
	addStyle();
	resize();
	scrollerWidth();

	$('#show-text-btn').click(function(event){
		$(this).toggleClass("show-text-btn-on").toggleClass("show-text-btn-off")
		$(".image-overlay-text").toggle("slide", { direction: "down" }, 1000);
	  	event.preventDefault(); // Prevent link from following its href
	});

/*
	$('.image-box').hover(
		function(event) {
			debugger;
		},
		function(event) {
			debugger;
		}) */
})

$(window).resize(function() {
	resize();
});

jQuery(function($) {
	$('.delete_clazz').bind('ajax:success', function() {  
	    $(this).closest('tr').fadeOut(); 
	});
});	


function scrollerWidth() {
	var sum=0;
	$('#class-scroller-container-zero').children('ul').each( function(index, list){ sum += $(list).width(); });
	if(sum <= $('#class-scroller-container').width()) {
		$('#class-scroller-container-zero').width('100%');
		$('#class-scroller-container').css('overflow-x', 'hidden')
	} else {
		$('#class-scroller-container-zero').width(sum);
		$('#class-scroller-container').css('overflow-x', 'scroll')
	}
}

function addStyle() {
	if(!$.browser.msie) {
		$('#content').addClass('content-none-ie');
	}
}

function resize() {
	if($("#content").outerHeight() < $("body").height() - $("#header").height() - $("#footer").height()) {
		$("#content").height(($("body").height() - $("#header").height()) - $("#footer").height() - ($("#content").outerHeight() - $("#content").height()) - 1);
		$("#left-gradient").height($("body").height() - $("#header").height() - $("#footer").height());
	} else {
		$("#right-gradient").height($("#content").outerHeight());
	}
}