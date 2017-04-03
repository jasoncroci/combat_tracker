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

    function updateField(item, params){
      var field_id = item.attr("name") + "_field";
      $("#" + field_id).val(params.newValue)
    }

    function updateInitiativeOrder(item, params){
      trs = $("tbody tr");
      trs.each(function(i,tr){
        var current_item = $(this).find("a[name$='_initiative']");

        if( parseInt(params.newValue) > parseInt(current_item.html()) ){
          current_item.closest("tr").before(item.closest("tr"));
          return false;
        }

        // Lowest init
        if( i === trs.length-1){
          current_item.closest("tr").after(item.closest("tr"));
        }
      });
    }

    $('#combatant_table a[name$="_initiative"]').on('save', function(e, params) {
      updateField( $(this), params );
      updateInitiativeOrder( $(this), params );
    });

    $('#combatant_table a[name$="_current_hit_points"]').on('save', function(e, params) {
      updateField( $(this), params );
    });

});
