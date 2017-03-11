$(document).ready(function() {
   $("#accordion" ).accordion({
       active: JSON.parse($("#accordion_tab_number").val())
   });
   setup_autocomplete();
});
