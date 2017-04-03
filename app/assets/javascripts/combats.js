//turn to inline mode
$.fn.editable.defaults.mode = 'inline';
$.fn.editable.defaults.ajaxOptions = {type: "PUT"};

$(document).ready(function() {

    $('#combatant_table a[data-type="text"]').editable({
      // success: function(response, newValue) {
      //   console.log('SUCXCCC')
      //   console.log(response);
      //   console.log(newValue);
      // },
      params: function(params) {
        //originally params contain pk, name and value
        params.combat = {};
        params.combat[params["name"]] = params["value"]
        return params;
      }
    });

    $('#combatant_table a[data-type="text"]').on('save', function(e, params) {
      var field_id = $(this).attr("name") + "_field";
      $("#" + field_id).val(params.newValue)
    });


});
