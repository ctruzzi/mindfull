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
		//debugger;
		//If show-text-btn-off then we show, else we hide. 
		if($(this).hasClass("show-text-btn-off")) {
			//Show stuff
			$(".image-overlay-text").show("slide", { direction: "down" }, 1000);
		} else {
			//Hide stuff
			$(".image-overlay-text").hide("slide", { direction: "down" }, 1000);
		}
		
		isShowText = !isShowText
	  	event.preventDefault(); // Prevent link from following its href
	});

	pageSetListeners();
	clazzPageSetListeners();
	scrollSetListeners();

	//Setting some overlay
	var $overlay = $('<div class="ui-widget-overlay" id="custom-overlay" style="z-index:1002;"><div id="overlay-popup"></div></div>').hide().appendTo('body');
})


function pageSetListeners() {
	$('.image-box').on({
		mouseenter: mouseImageEnter,
		mouseleave: mouseImageLeave
	});

	$('.arrow-overlay').on({click: arrowClick})
	
	$('.image-box').draggable({ 
		containment: "#page-canvas", 
		scroll: true, 
		scrollSensitivity: 100 
	}).bind( "dragstart", function(event, ui) {
		$('#entry-trash').show()
		ui.helper.data("originalPositionForDelete", ui.originalPosition)
	}).bind( "dragstop", function(event, ui) {
		$('#entry-trash').fadeOut(600)
	});

	//Controls save button click
	$('#save-all-btn').click(function(event){
		updatePageEntries();
	});

	//manages nofities
	$("#notice").notify({
	    speed: 500,
	    expires: 5000
	    //expires: false
	});

}

function scrollSetListeners() {
	$('.mini-box').on({click: dontgetSelectedPage});
}


function dontgetSelectedPage() {
	//Check if object has class of selected, if so return false. else return true
	if($(this).hasClass('mini-box-selected')) {
		return false;
	} else {
		return true
	}
}

function clazzPageSetListeners() {
	$('a.clazz-add').on({click: addSectionListener})
	$('li.add-section-button').on({click: ignoreGlobal})
	$('.class_button').on({click: clazzPopup})
	
	$(document).on({click: hideAllAddSection})
}

//Simply hide all of the ones shown.
function hideAllAddSection() {
	$(".add-section-button").each(function(index, item) {
		theChildren = $(item).children();
		$(theChildren[0]).css("display", "none")
		$(theChildren[1]).html("+")
	});
}

function hideAddSection(id) {
	var anchor = $("#clazz-add-" + id)
	div_form = $(anchor.siblings("div")[0])
	div_form.css("display", "none")
	var input = $(div_form.find(".section_title")[0])
	input.val("")
	anchor.html("+")
}

function ignoreGlobal() {
	event.stopPropagation(); 
}

function addSectionListener() {
	var anchor = $(this);
	div_form = $(anchor.siblings("div")[0])
	if(div_form.css("display") == "none") {
		//Display
		div_form.css("display", "block")
		div_form.find(".section_title")[0].focus()
		anchor.html("-")
	} else {
		//Hide
		hideAddSection(anchor.attr("data-clazz-id"))
	}
	event.stopPropagation(); 
	return false;
}

function clazzPopup() {
	$( "#clazz-popup" ).dialog({ height: 140, modal: true, title: "Create New Class"} );
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

function updatePageEntries() {
	page_id = $('#page-canvas').attr("data-page-id")
	json_message = gatherPageUpdates("page-canvas");
	$.ajax({
		type: "PUT",
		url: "/page_notes/" + page_id + ".json",
		contentType: "application/json",
		dataType: "JSON",
		data: JSON.stringify({"notes": json_message}),
	    beforeSend: function(x) {
            if (x && x.overrideMimeType) {
              x.overrideMimeType("application/j-son;charset=UTF-8");
            }
            setOverlayDimensionsToCurrentDocumentDimensions();
				$('#custom-overlay').fadeIn();
          }
	}).success(function(data) {
		setOverlayDimensionsToCurrentDocumentDimensions();
			$('#custom-overlay').fadeOut();
	});			
	$.ajaxSettings.accepts.html = $.ajaxSettings.accepts.script;
}

function gatherPageUpdates(parent_id) {	
	var json_objects = new Array();
	$("#" + parent_id).children(".image-box").each(function(index, image_obj){
		image_obj = $(image_obj)
		var json_object = {note_id: parseInt(image_obj.attr("data-entry-id")), attributes: {imageid:parseInt(image_obj.attr("data-current-img-loc")), left:image_obj.css("left"), top:image_obj.css("top")}};
		if(image_obj.data('img-choices')) {
			json_object.attributes.optional_images = image_obj.data('img-choices')
		}
		json_objects.push(json_object);
	});
	return json_objects;
}

function gatherEntryRecreate(parent_id) {	
	image_obj = $("#" + parent_id).children(".image-box")
	if(image_obj) {
		image_obj = $(image_obj[0])
		var json_object = {note_id: parseInt(image_obj.attr("data-entry-id")), 
			attributes: {
				image:image_obj.attr("data-current-img-loc"), 
				custom_css:"left:" + image_obj.css("left") + ";top:" + image_obj.css("top") + ";", 
				optional_images:image_obj.data('img-choices'),
				text: image_obj.children('.image-overlay-text').text()
			}
		};
		return json_object;
	} else {
		return "";
	}
}