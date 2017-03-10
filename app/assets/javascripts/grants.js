// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
// You can use CoffeeScript in this file: http://coffeescript.org/

$(function() {
    $("#grants-form-container").on(
        "ajax:success",
        "a[data-remote]",
        function (e, data, status, xhr) {
            flash_notice('User ' + $(e.target).parent().find('span').text() + ' can no longer view this upload');
            $(e.target).parent().remove();   // ensure that grant (email) is removed from the DOM upon AJAX return
        }
    );

    $("#grants-form-container").on('submit','form',function(e,data,status,xhr) {
        var email = $(this).find("input#email");
        e.preventDefault();
        if (/^\s*$/.test(email.val())) {
            flash_alert("Enter email address!");
            return false;
        }
        $.post( $(this).attr('action'),
                {email: email.val()},
                function(data,textStatus,jqXHR) {
                    switch (jQuery.type(data)) {
                        case "string":
                            $(e.target).parent().html(data);
                            flash_notice("User " + email.val() + " given read-only access to this upload");
                            break;
                        case "object":
                            flash_alert(data.error);
                    }
                }
        );
    });
});
