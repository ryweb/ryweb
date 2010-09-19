// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults

jQuery(document).ready(function($){
	
	/* Buttons */
	$('a.button').each(function() {
		var Text = $(this).text();
		var Class = $(this).attr('class');
		$(this).html('<span><span>'+ Text +'</span></span>');
		if(Class.search("icon_") > 0) {
			$(this).attr('class', 'button');
			$(this).children('span').children('span').attr('class', Class +' icon');
			$(this).children('span').children('span').removeClass('button');
		}
	});
	

});