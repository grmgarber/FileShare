$(document).ready(function() {
    jq_tn = $("#accordion_tab_number");
    var tab_num = jq_tn.length > 0 ? JSON.parse(jq_tn.val()) : 0;
    $("#accordion" ).accordion({
       active: tab_num
   });
   setup_autocomplete();
});
