App.combat = App.cable.subscriptions.create('CombatChannel', {
  connected: function(){
  },
  received: function(data) {
    App.combat.updateUI(data);
  }
});
