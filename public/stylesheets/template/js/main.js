
$(document).ready(function(){

	/* Cornerit */
	$("#content").corner('bottom 5px');
	$(".calendar-min").corner('8px');
	
	/* #Lisätään oletustyylit main-divin sisällä oleville listoille ja taulukoille, joilla ei omaa tyyliä */
	$('#main ul, #main ol, #main table').each(function(){
		if(isEmpty($(this).attr('class')) && isEmpty($(this).attr('id'))) {
			$(this).attr('class', this.nodeName.toLowerCase());
		}
	});
	/* Navin ekasta linkistä taustakuva pois */
	$("#nav li:first").css('background', 'transparent');
	
	/* Navin aktiivisen linkin seuraavasta linkistä taustakuva pois */
	$("#nav a.current").parent('li').next('li').css('background', 'transparent');
	$("#calendar tbody tr:even, .calendar-min tbody tr:even, , .table tr:even").addClass('even');
	
	/* Logon keskitys */
	setTimeout(function() {
		$('#logo').vAlign();	
	}, 300);
		
	/* Jos #column tyhjä sisältöalueen leveys 100% */
	if($('#column').html().trim() == '')
		$('#main').css('width', '100%');
	
	/* Mainospaikan nurkat kuntoon */
	$('#big_news').wrapInner('<div class="content" />');
	$('<div class="corner-lb"></div><div class="corner-lt"></div><div class="clear"></div>').appendTo('#big_news');
	$('<div class="bottom"></div>').appendTo('#big_news .content');
	
});

/* Email-suojaus */
function email_antispam(End, Domain, Name) {
	document.write("<a href=\"mailto: "+ Name +"\u0040"+ Domain +"\u002e"+End+"\">"+Name+"\u0040"+Domain);
	document.write("\u002e"+End+"</a>");
}

function isEmpty(inputStr) {
	if ( null == inputStr || "" == inputStr )
		return true;
	else
		return false;
}

(function ($) {
// VERTICALLY ALIGN FUNCTION
$.fn.vAlign = function() {
	return this.each(function(i){
	var ah = $(this).height();
	var ph = $(this).parent().height();
	var mh = (ph - ah) / 2;
	$(this).css('margin-top', mh);
	});
};
})(jQuery);