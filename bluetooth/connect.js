var pubnub = require('pubnub').init({
  publish_key: 'pub-c-c68b82e8-a483-44c6-9efb-29ee321615df',
  subscribe_key: 'sub-c-fc32499e-a8b4-11e4-bf84-0619f8945a4f'
});

setInterval(function(){
  pubnub.publish({
  channel: "extinction",
  error: function(e){console.log("Pubnub error")},
  message: 'hi',
  callback: function(){console.log('Msg sent')}
});
}, 1000);