App.combat = App.cable.subscriptions.create('CombatChannel', {
  connected: function(){
  },
  received: function(data) {
    if(data.url){
      window.location.href = data.url
    } else{
      App.combat.updateUI(data.current_user, data.message);
    }
  }
});
