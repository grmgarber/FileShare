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