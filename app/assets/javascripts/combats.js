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
  };

  this.App.combat.startCombat = function(){
    var trs = $("tbody tr");
    first_turn_tr = trs.filter("[data-visible='true']:first");
    first_turn_tr.addClass("info");
    App.combat.updateTurn(first_turn_tr);
  };

  this.App.combat.nextTurn = function(){
    var current_turn = $("#combat_current_turn").val();
    var selected_item = $("tr#" + current_turn);
    var new_selected_item = selected_item.nextAll("[data-visible='true']").filter(":first");

    if(!new_selected_item.length){
      new_selected_item = trs.filter("[data-visible='true']:first");
      var hidden_field = $("#combat_current_round")
      hidden_field.val(parseInt(hidden_field.val()) + 1);
      App.combat.updateRound(hidden_field.val());
    }

    selected_item.removeClass("info");
    new_selected_item.addClass("info");
    App.combat.updateTurn(new_selected_item);
  };

  this.App.combat.updateCombatantCondition = function(item, current_hit_points, total_hit_points, remove_from_play){
    var current_hit_points = parseInt(current_hit_points);
    var total_hit_points = parseInt(total_hit_points);
    if( current_hit_points <= 0 && remove_from_play ){
      item.closest("tr").remove();
    } else if( current_hit_points <= total_hit_points/2 ){
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
    var hit_point_field = $("#" + identity + "_current_hit_points_field");
    // only update character's hp if user
    if(identity.indexOf("character") > -1 || App.util.isAuthor(App.combat.config.id)){
      hit_point_elem.html(current_hit_points);
    }
    hit_point_field.val(current_hit_points)
    App.combat.updateCombatantCondition(hit_point_elem, hit_point_field.val(), total_hit_points, remove_from_play);
  };

  this.App.combat.updateCombatantPresence = function(identity, visible){
    $("tr#" + identity).toggle(visible);
  };

  this.App.combat.updateUI = function(config, data){
    App.combat.config = config;
    App.combat.updateRound(data.current_round);
    App.combat.updateCurrentTurn(data.current_turn);

    $.each(data.enemies, function( index, enemy ) {
      App.combat.updateInitiative("enemy_" + enemy.id, enemy.initiative);
      App.combat.updateInitiativeOrder( $("tr#enemy_" + enemy.id).closest("tr"), enemy.initiative );
      App.combat.updateHitPoints("enemy_" + enemy.id, enemy.current_hit_points, enemy.hit_points, true);
      if(!App.util.isAuthor(App.combat.config.id)){
        App.combat.updateCombatantPresence("enemy_" + enemy.id, enemy.visible);
      }
    });

    $.each(data.characters, function( index, character ) {
      App.combat.updateInitiative("character_" + character.id, character.initiative);
      App.combat.updateInitiativeOrder( $("tr#character_" + character.id).closest("tr"), character.initiative );
      App.combat.updateHitPoints("character_" + character.id, character.current_hit_points, character.hit_points, false);
      if(!App.util.isAuthor(App.combat.config.id)){
        App.combat.updateCombatantPresence("character_" + character.id, character.visible);
      }
    });
  };
}).call(this);


$(document).ready(function() {
  App.combat.updateCurrentTurn($("#combat_current_turn").val());

  $("a[name$='_current_hit_points']").each(function(){
      var field_name = $(this).attr("name").replace("_current","")+"_field";
      App.combat.updateCombatantCondition(
        $(this),
        $("#" + $(this).attr("name") + "_field").val(),
        $("#" + field_name).val(),
        $(this).attr("name").indexOf("enemy") > -1
      );
  });

  $("#begin_combat_btn").click(function(e){
    e.preventDefault();
    var current_turn = $("#combat_current_turn").val();
    if( current_turn == ""){
      App.combat.startCombat();
    } else{
      App.combat.nextTurn();
    }
    $(this).html("Next");
  });

  $('#combatant_table td[name$="_presence"]').on('click', function(e, params) {
    $(this).find("span").toggle();
    var visible = $(this).find("span:visible").attr("data-visible");
    var tr = $(this).closest("tr");
    tr.attr("data-visible", visible);
    var field = $("#" + tr.attr("id") + "_visible_field");
    field.val(visible);
      //visible === "true" ? $(this).show() : $(this).hide();
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

  $('#combatant_table a[name$="_current_hit_points"]').on('shown', function(e, editable) {
    setTimeout(function() { editable.input.$input.select(); }, 0);
  });

  $('#combatant_table a[name$="_current_hit_points"]').on('save', function(e, params) {
    var field_name = $(this).attr("name").replace("_current","")+"_field";
    var newValue = parseInt($(this).html()) + parseInt(params.newValue);
    params.newValue = newValue
    App.combat.updateField( $(this).attr("name"), params.newValue );
    App.combat.updateCombatantCondition(
      $(this),
      params.newValue,
      $("#" + field_name).val(),
      $(this).attr("name").indexOf("enemy") > -1
    );
  });

});
