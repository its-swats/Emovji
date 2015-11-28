$(document).ready(function() {
	formHandler();
	logoutHandler();
	deleteAccountHandler();
	submitAjaxRequest();
	emojiClickHandler();
	voteHandler();
});

var formHandler = function() {
	$('body').on('click', '.popup_form', function(event) {
		event.preventDefault();
		var targetUrl = $(this).attr('href')
		var response = $.ajax({
			method: 'GET',
			url: targetUrl
		});
		response.done(function(data) {
			clearForms();
			$('.show_form').append(data);
		});
	});
}

var logoutHandler = function() {
	$('body').on('click', '#log_out', function(event) {
		event.preventDefault();
		var userId = $(this).attr('href').match(/\d+/)
		var response = $.ajax({
			method: 'DELETE',
			url: '/sessions/' + userId
		});
		response.done(function() {
			location.reload();
		});
		response.fail(function() {
			console.log('Logout Failed');
		});
	});
}

var deleteAccountHandler = function() {
	$('.show_form').on('click', 'form button#delete_account', function(event) {
		var userId = $(this).parent().attr('action').match(/\d+/)
		event.preventDefault();
		var response = $.ajax({
			type: 'DELETE',
			url: '/users/' + userId
		});
		response.done(function() {
			location.reload();
		});
	});
}

var clearForms = function () {
	$('.show_form').empty();
}


var emojiClickHandler = function() {
	$('.jumbotron a').on('click', function(event){
		event.preventDefault();
		if ($(this).hasClass('selected')) {
			$(this).removeClass('selected');
		} else { 
			$(this).parent().parent().children().children().removeClass('selected');
			$(this).addClass('selected');
		};
	});
}

var voteHandler = function() { 
	$('body').on('click', '#myModal .vote', function(event){ 
		event.preventDefault();
		var twilioNumber = $('#twilio_number').val();
		console.log(twilioNumber);
		var response = $.ajax({
			method: 'post',
			url: $(this).attr('href'),
			data: {type: $(this).attr('id'), title: $('#title').text(), number: twilioNumber}


		})
	})
}
