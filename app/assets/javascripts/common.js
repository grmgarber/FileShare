function flash_alert(message) {
    $(".flash").html('<div class="alert">' + message + "</div>");
}

function flash_notice(message) {
    $(".flash").html('<div class="notice">' + message + "</div>");
}

$(function(){
    $(document).ajaxStart(function () {
       $('img#ajax-loader').css('display','block')
    });
    $(document).ajaxStop(function () {
        $('img#ajax-loader').css('display','none')
    });
});

/* We have to call setup_autocomplete() for both uploads_controller view (edit)
   and grants_controller as well, because the autocomplete is part of the form that gets replaced
   each time a user is added to viewers list of an upload. That's why we place it here.
 */
function setup_autocomplete() {
    $('input#email[type="text"]').autocomplete({
        source: "/uploads/" + $("#upload_id").val() + "/potential_grantees",
        minLength: 3
        // select: function(event,item) {...}
    })
}
