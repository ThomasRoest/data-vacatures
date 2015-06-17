$(document).ready(function(){
	$('#show-comment-form').on('click', function(){
  		$('.comment-form').removeClass('hide');
  		$(this).addClass('hide');
	});
});