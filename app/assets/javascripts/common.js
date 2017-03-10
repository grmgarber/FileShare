$(function(){
    $(document).ajaxStart(function () {
       $('img#ajax-loader').css('display','block')
    });
    $(document).ajaxStop(function () {
        $('img#ajax-loader').css('display','none')
    });
});