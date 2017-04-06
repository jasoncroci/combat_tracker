App.combat = App.cable.subscriptions.create('CombatChannel', {
  connected: function(){
    console.log('connected')
  },
  received: function(data) {
    console.log(data);
    //$("#messages").html(data["message"])
    //App.combat.nextTurn();
  }
});
