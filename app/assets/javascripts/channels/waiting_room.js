App.waiting_room = App.cable.subscriptions.create('WaitingRoomChannel', {
  connected: function(){
    console.log('Connected to waiting room channel');
  },
  received: function(data) {
    console.log(data);
  }
});
