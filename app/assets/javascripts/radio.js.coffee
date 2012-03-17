$(document).ready ->
	$('.participant').tooltip();
	$('img').lazyload();
	$('.like-button').click -> 
		$.ajax this.href,
		    type: 'GET'
		    dataType: 'json' 
			error: (jqXHR, textStatus, errorThrown) ->
		        $('body').append "AJAX Error: #{textStatus}"
		    success: (data, textStatus, jqXHR) ->
		        $('body').append "Successful AJAX call: #{data}"
