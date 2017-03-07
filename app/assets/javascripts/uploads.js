$(document).ready(function() {
   var jq_members = $("input#members_json");
   if (jq_members.length > 0 && /\S/.test(jq_members.val())) {
       var members = JSON.parse(jq_members.val());
       $("#members_autocomp").autocomplete({
           source: Object.keys(members)
       })
   }
})
