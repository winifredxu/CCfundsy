$(document).ready(function() {
  if (typeof(Stripe) === "undefined") {
    return;
  }

  Stripe.setPublishableKey($("meta[name='stripe-key']").attr("content"));

  $("#cc-form").submit(function(){
    $("#stripe-errors").html(""); //empty (the last error msg
    // after 'submit' action, we disable the button so user cannot repeatedly hit it.
    $("input[type='submit']").attr("disabled", true);

    card = {
      number: $("#_card_number").val(), 
      cvc: $("#_cvc").val(),
      expMonth: $("#date_month").val(),
      expYear: $("#date_year").val()
    }

    // create a token and provide a callback function
    Stripe.createToken(card, handleStripeResponse);
    return false; // return false will prevent default and stop propagation
  });

  handleStripeResponse = function(status, response) {
    if (status === 200) {
      console.log(status);   // alert(status);
      // console.log(response);

      // send token to Rails server
      $("#_stripe_token").val(response.id);
      $("#token-form").submit();

    } else {
      $("#stripe-errors").html(response.error.message);
      // if error after submit, reenable "submit" button
      $("input[type='submit']").removeAttr("disabled");
      
    }
  }

});