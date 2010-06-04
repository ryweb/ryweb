
$(document).ready(function(){

	/* Cornerit */
	$("#content").corner('bottom 5px');
	$("#calendar-min").corner('8px');
	
	/* Leiskan säätöä */
	$('#main ul, #main ol, #main table').each(function(){
		if(isEmpty($(this).attr('class')) && isEmpty($(this).attr('id'))) {
			$(this).attr('class', this.nodeName.toLowerCase());
		}
	});
	$("#nav li:first").css('background', 'transparent');
	$("#nav a.current").parent('li').next('li').css('background', 'transparent');
	$("#logo a").css('height', $("#logo").height());
	$("#calendar tbody tr:even, #calendar-min tbody tr:even, , .table tr:even").addClass('even');
		
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