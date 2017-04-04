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
    };

    $('#combatant_table a[name$="_initiative"]').on('save', function(e, params) {
      updateField( $(this), params );
      updateInitiativeOrder( $(this), params );
    });

    function updateEnemyCondition(item, current_hit_points){
      var field_name = item.attr("name").replace("_current","")+"_field";
      var current_hit_points = parseInt(current_hit_points);
      var total_hit_points = parseInt($("#" + field_name).val());
      if( current_hit_points <= 0 ){
        item.closest("tr").remove();
      } else if( current_hit_points <= total_hit_points/2 ){
        item.closest("td").addClass("danger");
      } else{
        item.closest("td").removeClass("danger");
      }
    };

    $('#combatant_table a[name$="_current_hit_points"]').on('save', function(e, params) {
      updateField( $(this), params );
      updateEnemyCondition($(this), params.newValue);
    });

    function setupCurrentTurn(){
      if( $("#combat_current_turn").val() ){
        $("tr#" + $("#combat_current_turn").val()).addClass("info")
      }
    };

    function setupEnemyConditions(){
      $("a[name^='enemy_']").each(function(){
        updateEnemyCondition($(this), $(this).html())
      });
    };

    function updateRound(){
      var hidden_field = $("#combat_current_round")
      hidden_field.val(parseInt(hidden_field.val()) + 1);
      $("caption span").html(hidden_field.val());
    }

    function updateTurn(item){
      $("#combat_current_turn").val(item.attr("id"));
      $("#combat_form").submit();
    }

    $("#begin_combat_btn").click(function(e){
      e.preventDefault();
      var trs = $("tbody tr");
      var selected_item = $("tbody tr.info")

      var index = 0;
      if( selected_item.index() < trs.size() - 1){
       index = selected_item.index() + 1;
      } else{
        updateRound();
      }

      selected_item.removeClass("info");
      var new_selected_item = $("tbody tr:eq("+ index +")");
      new_selected_item.addClass("info");
      updateTurn(new_selected_item);
    });

    setupCurrentTurn();
    setupEnemyConditions();

});
