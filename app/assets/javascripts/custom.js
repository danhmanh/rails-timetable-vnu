$(document).on('turbolinks:load', function(){
  $(".alert").delay(2000).slideUp(500, function(){
        $(".alert").alert('close');
    });
  });