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

	isShowText = false;
	isChanging = false;
	$('#show-text-btn').click(function(event){
		$(this).toggleClass("show-text-btn-on").toggleClass("show-text-btn-off")
		$(".image-overlay-text").toggle("slide", { direction: "down" }, 1000);
		isShowText = !isShowText
	  	event.preventDefault(); // Prevent link from following its href
	});

	pageSetListeners();

	//Setting some overlay
	var $overlay = $('<div class="ui-widget-overlay" id="custom-overlay" style="z-index:999;"></div>').hide().appendTo('body');

    $('#save-all-btn').click(function(){
        //$('#custom-overlay').fadeIn();
        //setOverlayDimensionsToCurrentDocumentDimensions(); //remember to call this when the document dimensions change
    });
})


function pageSetListeners() {
	$('.image-box').on({
		mouseenter: mouseImageEnter,
		mouseleave: mouseImageLeave
	});

	$('.arrow-overlay').on({click: arrowClick})
	$('.image-box').draggable({ containment: "#page-canvas", scroll: true, scrollSensitivity: 100 });
}

function mouseImageEnter() {
	if(!isShowText)
		$(this).children('.arrow-overlay').show(); 
}

function mouseImageLeave() {
	if(!isShowText)
		$(this).children('.arrow-overlay').hide();
}

function arrowClick() {
	if(!isChanging) {
		isChanging = true;

		isBack = $(this).attr('class').indexOf("right-arrow") < 0; //false if less then 0
		parent = $(this).parent();
		parent_id = $(this).parent().attr("id");
		image_id = 'display-image-' + parent_id;
		img_index = parseInt(parent.attr("data-current-img-loc"))
		img_opt_length = parseInt(parent.attr("data-img-count"))

		if(isBack) {
			img_index = --img_index < 0 ? img_opt_length - 1 : img_index;
		} else {
			img_index = ++img_index > img_opt_length - 1 ? 0 : img_index;
		}

		// img_array[img_index];
		new_img = $('#optional-images-' + parent_id + '-'+img_index).val()
		size = new_img.match(/_[0-9]+x[0-9]+./)[0].replace(/[_.]/g, "").split("x")
		//size = new_img.substring(new_img.lastIndexOf("_")+1,new_img.lastIndexOf(".")).split("x")
		image_tag = '<img alt="img" width="' + size[0] + '" height="' + size[1] +'"  id="' + image_id + '-new" src="/assets/' + new_img + '" style="float: left; display:none" >'

		$(image_tag).appendTo("#" + parent_id)

		$('#'+image_id).fadeOut('slow', function() {
			$('#' +image_id +'-new').fadeIn('slow', function() {
				$('#'+image_id).remove();
				this.id = image_id;
				isChanging = false;
			});
		});
		parent.attr("data-current-img-loc", img_index);
	}
}

function setOverlayDimensionsToCurrentDocumentDimensions() {
    $('#custom-overlay').width($(document).width());
    $('#custom-overlay').height($(document).height());
}

$(window).resize(function() {
	resize();
	setOverlayDimensionsToCurrentDocumentDimensions();
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