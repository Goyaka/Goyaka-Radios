$(document).ready ->
	$('.participant').tooltip();
	$('.like-button').tooltip();
	
	$('img').lazyload();
	
	ajaxsuccess = (data)->
		node = $('#' + data['post_id'] + '-like-action')
		node.find('img').attr('src','/assets/done.png')
		like_count = $('#' + data['post_id'] + '-like-count').html()
        
		
		markup = '<li><a href="http://www.facebook.com/${fbid}" class="participant" rel="tooltip" data-original-title="${name}"><img src="http://graph.facebook.com/${fbid}/picture?type=square" data-src="http://graph.facebook.com/${fbid}/picture?type=square" alt="${name}"></a></li>'
		$.tmpl(markup, current_user).prependTo('#' + data['post_id'] + '-like-people')
		$('#' + data['post_id'] + '-like-people').parent().effect("highlight", {}, 3000);
		
		if like_count == 0 
			$('#' + data['post_id'] + '-like-count').html('You ')
		else
			$('#' + data['post_id'] + '-like-count').html('You and ' + like_count + ' others ')
			
		removeButton =->
			$('#' + data['post_id'] + '-like-action').remove()
			
		setTimeout(removeButton, 6000)
		$('.participant').tooltip();
		

	$('.like-button').click ->
		$(this).find('img').attr('src','/assets/ajax-loader.gif')
		$(this).removeClass('btn')
		$(this).addClass('btn-loading') 
		$.ajax this.href,
		    type: 'GET',
		    dataType: 'json', 
		    success: ajaxsuccess 
				
		return false
