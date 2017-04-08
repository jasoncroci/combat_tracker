//= require cable.js
//= require ./channels/combat.js
//= require_self

//turn to inline mode
$.fn.editable.defaults.mode = 'inline';
$.fn.editable.defaults.ajaxOptions = {type: "PUT"};

(function() {
  this.App || (this.App = {});
  this.App.combat || (this.App.combat = {});

  this.App.combat.updateCurrentTurn = function(current_turn){
    if( current_turn ){
      $("tbody tr").each(function(){
        if($(this).attr("id") === current_turn){
          $(this).addClass("info");
        } else{
          $(this).removeClass("info");
        }
      });
    }
  };

  this.App.combat.updateField = function(identity, value){
    var field_id = identity + "_field";
    $("#" + field_id).val(value);
  };

  this.App.combat.updateInitiativeOrder = function(identity_row, initiative){
    trs = $("tbody tr");
    trs.each(function(i,tr){
      var current_item = $(this).find("a[name$='_initiative']");

      if( parseInt(initiative) > parseInt(current_item.html()) ){
        current_item.closest("tr").before(identity_row);
        return false;
      }

      // Lowest init
      if( i === trs.length-1){
        current_item.closest("tr").after(identity_row);
      }
    });
  };

  this.App.combat.updateRound = function(current_round){
    $("caption span").html(current_round);
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
      var hidden_field = $("#combat_current_round")
      hidden_field.val(parseInt(hidden_field.val()) + 1);
      App.combat.updateRound(hidden_field.val());
    }

    selected_item.removeClass("info");
    var new_selected_item = $("tbody tr:eq("+ index +")");
    new_selected_item.addClass("info");
    App.combat.updateTurn(new_selected_item);
  };

  this.App.combat.updateEnemyCondition = function(item, current_hit_points, total_hit_points, remove_from_play){
    var current_hit_points = parseInt(current_hit_points);
    var total_hit_points = parseInt(total_hit_points);
    if( current_hit_points <= 0 && remove_from_play ){
      item.closest("tr").remove();
    } else if( current_hit_points <= total_hit_points/2 ){
      //item.closest("td").addClass("danger");
      item.addClass("bloodied")
      item.closest("tr").find("[name$='_name']").addClass("bloodied");
    } else{
      item.removeClass("bloodied")
      item.closest("tr").find("[name$='_name']").removeClass("bloodied");
    }
  };

  this.App.combat.updateInitiative = function(identity, initiative){
    var initiative_elem = $("a[name='" + identity + "_initiative']");
    initiative_elem.html(initiative);
  };

  this.App.combat.updateHitPoints = function(identity, current_hit_points, total_hit_points, remove_from_play){
    var hit_point_elem = $("a[name='" + identity + "_current_hit_points']");
    hit_point_elem.html(current_hit_points);
    App.combat.updateEnemyCondition(hit_point_elem, hit_point_elem.html(), total_hit_points, remove_from_play)
  };

  this.App.combat.updateUI = function(data){
    App.combat.updateRound(data.current_round);
    App.combat.updateCurrentTurn(data.current_turn);

    $.each(data.enemies, function( index, enemy ) {
      App.combat.updateInitiative("enemy_" + enemy.id, enemy.initiative);
      App.combat.updateInitiativeOrder( $("tr#enemy_" + enemy.id).closest("tr"), enemy.initiative );
      App.combat.updateHitPoints("enemy_" + enemy.id, enemy.current_hit_points, enemy.hit_points, true);
    });

    $.each(data.characters, function( index, character ) {
      console.log(character)
      App.combat.updateInitiative("character_" + character.id, character.initiative);
      App.combat.updateInitiativeOrder( $("tr#character_" + character.id).closest("tr"), character.initiative );
      App.combat.updateHitPoints("character_" + character.id, character.current_hit_points, character.hit_points, false);
    });
  };


}).call(this);


$(document).ready(function() {
  App.combat.updateCurrentTurn($("#combat_current_turn").val());

  $("a[name$='_current_hit_points']").each(function(){
      var field_name = $(this).attr("name").replace("_current","")+"_field";
      App.combat.updateEnemyCondition(
        $(this),
        $(this).html(),
        $("#" + field_name).val(),
        $(this).attr("name").indexOf("enemy") > -1
      );
  });

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
    App.combat.updateField( $(this).attr("name"), params.newValue );
    App.combat.updateInitiativeOrder( $(this).closest("tr"), params.newValue );
  });

  $('#combatant_table a[name$="_current_hit_points"]').on('save', function(e, params) {
    var field_name = $(this).attr("name").replace("_current","")+"_field";
    App.combat.updateField( $(this).attr("name"), params.newValue );
    App.combat.updateEnemyCondition(
      $(this),
      params.newValue,
      $("#" + field_name).val(),
      $(this).attr("name").indexOf("enemy") > -1
    );
  });

});
