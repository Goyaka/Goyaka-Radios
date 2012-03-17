$(document).ready ->
	$('.participant').tooltip();
	$('img').lazyload();
	
	ajaxsuccess = (data)->
		node = $('#' + data['post_id'] + '-like-action')
		node.html("Successful AJAX call")
				
	$('.like-button').click ->
		$(this).html('Liking..') 
		$.ajax this.href,
		    type: 'GET',
		    dataType: 'json', 
		    success: ajaxsuccess 
				
		return false
