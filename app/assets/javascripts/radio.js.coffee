$(document).ready ->
	$('.participant').tooltip();
	$('img').lazyload();
	
	ajaxsuccess = (data)->
		node = $('#' + data['post_id'] + '-like-action')
		node.html("Successful AJAX call")
		markup = '<li><a href="http://www.facebook.com/${fbid}" class="participant" rel="tooltip" data-original-title="${name}"><img src="http://graph.facebook.com/${fbid}/picture?type=square" data-src="http://graph.facebook.com/${fbid}/picture?type=square" alt="${name}"></a></li>'
		$.tmpl(markup, current_user).prependTo('#' + data['post_id'] + '-like-people');
		like_count = Number($('#' + data['post_id'] + '-like-count').html())
		$('#' + data['post_id'] + '-like-count').html(like_count + 1)

	$('.like-button').click ->
		$(this).html('Liking..') 
		$.ajax this.href,
		    type: 'GET',
		    dataType: 'json', 
		    success: ajaxsuccess 
				
		return false
