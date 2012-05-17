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

 jQuery(function($) {
	$('.delete_clazz').bind('ajax:success', function() {  
	    $(this).closest('tr').fadeOut(); 
	});
	$('.create_clazz').bind('ajax:success', function(data, status, xhr) {  
	    
		$("#close").click(function(){
			hidePopup();
		});

		$("#overlayEffect").click(function(){
			hidePopup();
		});

		$("#clazz-create-submit").click(function(){
			hidePopup();
		});
		$("form#clazz-create-submit").bind('ajax:success', function() {  
		    alert("aahhhh");
		}).bind('ajax:before', function() {
			alert("hello")
		});  

		$("#overlayEffect").fadeIn("slow");
		$("#popupContainer").fadeIn("slow");
		$("#close").fadeIn("slow");
	    center();
		var popup = true;
		$( ".draggable" ).draggable();

		function center(){
			var windowWidth = document.documentElement.clientWidth;
			var windowHeight = document.documentElement.clientHeight;
			var popupHeight = $("#popupContainer").height();
			var popupWidth = $("#popupContainer").width();
			$("#popupContainer").css({
				"position": "absolute",
				"top": windowHeight/2-popupHeight/2,
				"left": windowWidth/2-popupWidth/2
			});

			}
		function hidePopup(){
			if(popup==true){
				$("#overlayEffect").fadeOut("slow");
				$("#popupContainer").fadeOut("slow");
				$("#close").fadeOut("slow");
				popup = false;
			}
		}

	});

	
});
