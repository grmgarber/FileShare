// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
// You can use CoffeeScript in this file: http://coffeescript.org/

$(function() {
    function setup_remove_handler() {
        $("a[data-remote]").on(
            "ajax:success",
            function (e, data, status, xhr) {
                $(e.target).parent().remove();   // ensure that grant (email) is removed from the DOM upon AJAX return
                alert("Viewer " + $(e.target).parent().find('span').html() + ' removed successfully');
            }
        );
    }
    setup_remove_handler();

    // If the submit handler below is commented out, Add operation will still work as regular post-back

    $("#grants-form-container form").on('submit',function(e,data,status,xhr) {
        e.preventDefault();
        $.post($(this).attr('action'),
               {email: $(this).find("input#email").val()},
               function(data,textStatus,jqXHR) {
                   switch (jQuery.type(data)) {
                       case "string":
                          $(e.target).parent().html(data);
                          setup_remove_handler();  // again, because the initial form has been replaced
                         break;
                      case "object":
                         alert(data.error);
                  }
               }
        );
    })
});