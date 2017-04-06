//turn to inline mode
$.fn.editable.defaults.mode = 'inline';
$.fn.editable.defaults.ajaxOptions = {type: "PUT"};

(function() {
  this.App || (this.App = {});
  this.App.combat || (this.App.combat = {});

  this.App.combat.setupCurrentTurn = function(){
    console.log("App.combat.setupCurrentTurn")
    if( $("#combat_current_turn").val() ){
      $("tr#" + $("#combat_current_turn").val()).addClass("info")
    }
  };

  this.App.combat.updateField = function(item, params){
    var field_id = item.attr("name") + "_field";
    $("#" + field_id).val(params.newValue)
  };

  this.App.combat.updateInitiativeOrder = function(item, params){
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

  this.App.combat.updateRound = function(){
    var hidden_field = $("#combat_current_round")
    hidden_field.val(parseInt(hidden_field.val()) + 1);
    $("caption span").html(hidden_field.val());
  };

  this.App.combat.updateTurn = function(item){
    $("#combat_current_turn").val(item.attr("id"));
    $("#combat_form").submit();
  }

  this.App.combat.nextTurn = function(){
    var trs = $("tbody tr");
    var selected_item = $("tbody tr.info")

    var index = 0;
    if( selected_item.index() < trs.size() - 1){
     index = selected_item.index() + 1;
    } else{
      App.combat.updateRound();
    }

    selected_item.removeClass("info");
    var new_selected_item = $("tbody tr:eq("+ index +")");
    new_selected_item.addClass("info");
    App.combat.updateTurn(new_selected_item);
  };

  this.App.combat.updateEnemyCondition = function(item, current_hit_points){
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

  this.App.combat.setupEnemyConditions = function(){
    $("a[name^='enemy_']").each(function(){
      App.combat.updateEnemyCondition($(this), $(this).html())
    });
  };


}).call(this);


$(document).ready(function() {
  App.combat.setupCurrentTurn();
  App.combat.setupEnemyConditions();

  $("#begin_combat_btn").click(function(e){
    e.preventDefault();
    App.combat.nextTurn();
  });

  $('#combatant_table a[data-type="text"]').editable({
    params: function(params) {
      //originally params contain pk, name and value
      params.combat = {};
      params.combat[params["name"]] = params["value"]
      return params;
    }
  });

  $('#combatant_table a[name$="_initiative"]').on('save', function(e, params) {
    App.combat.updateField( $(this), params );
    App.combat.updateInitiativeOrder( $(this), params );
  });

  $('#combatant_table a[name$="_current_hit_points"]').on('save', function(e, params) {
    App.combat.updateField( $(this), params );
    App.combat.updateEnemyCondition($(this), params.newValue);
  });

});
