$(function(){
	var sessionEmail = $('#session_email');
	var sessionPassword = $('#password')
	var formErrors = $('.form-errors')

  $('#sessions_new_submit').on('click', function(){
  	if(sessionEmail.val().length < 1 && sessionPassword.val().length < 1){
  		formErrors.text('Voer een email & wachtwoord in');
  	} else if (sessionEmail.val().length < 1){
  		formErrors.text('Voer een email adres in');
  	} else if(sessionPassword.val().length < 1){
  		formErrors.text('Voer een wachtwoord in');
  	}
  });

  
  $('#users_new_submit').on('click', function(){
    var name = $('#user_name');
    var email = $('#user_email');
    var password = $('#password');
    var password_confirmation = $('#confirm_password');
    validateForm(name, email, password, password_confirmation);
  });

  function validateForm(name,email,password,password_confirmation){
    var input1 = name.val().length;
    var input2 = email.val().length;
    var input3 = password.val().length;
    var input4 = password_confirmation.val().length;

    var msg = '';
    if(input1 < 1){
      msg += 'Naam, ';
    }
    if(input2 < 1){
      msg += 'Email adres, ';
    }
    if(input3 < 1){
      msg += 'Wachtwoord, ';
    }
    if(input4 < 1){
      msg += 'Wachtwoord bevestiging.';
    }
    formErrors.text(msg);
  }


  $('#submit-job-form').on('click', function(){
    var company = $('#job_company');
    var place =  $('#job_place');
    var jobtitle = $('#job_title');
    var description = $('#parsed_markdown');
    validateJobform(company, place, jobtitle, description);
  });

   function validateJobform(company,place,jobtitle,description){
    var input1 = company.val().length;
    var input2 = place.val().length;
    var input3 = jobtitle.val().length;
    var input4 = description.val().length;
  
    var msg = '';
      if(input1 < 1){
        msg += 'Voeg een bedrijfsnaam toe, ';
      }
      if(input2 < 1){
        msg += 'Voeg een plaatsnaam toe, ';
      }
      if(input3 < 1){
        msg += 'Voeg een functietitel toe, ';
      }
      if(input4 < 1){
        msg += 'Voeg een functieomschrijving toe.';
      }
    formErrors.text(msg);
   }
 
   var $showCount = $('#show_count');
   var $inputText = $('#job_summary');
   var $charCountp = $('#charcount-left');

   $inputText.on('keypress', function(){
    $charCountp.removeClass('hide');
    var $inputLength = $(this).val().length;
    var counter = 250 - $inputLength;
    $showCount.text(counter);
      if(counter < 0){
        $showCount.addClass('char-counter-error');
      } else if (counter > 0) {
        $showCount.removeClass('char-counter-error');
      }
   });

   $('#sortform-courses-select').on('change', function(){
    $('#sortform-courses').submit();
   });
});