App.waiting_room = App.cable.subscriptions.create('WaitingRoomChannel', {
  connected: function(){
  },
  received: function(data) {
    if(data.url){
      window.location.href = data.url
    }
  }
});
