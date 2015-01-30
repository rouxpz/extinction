var tessel = require('tessel'),
    blelib = require('ble-ble113a'),
    ble = blelib.use(tessel.port['A']);

var counter = 0;

ble.on('ready', function(err) {

  var pubnub = require('pubnub').init({
    publish_key: 'pub-c-c68b82e8-a483-44c6-9efb-29ee321615df',
    subscribe_key: 'sub-c-fc32499e-a8b4-11e4-bf84-0619f8945a4f'
  });

  function countClearSend(){
    pubnub.publish({
      channel: "extinction",
      error: function(e){console.log("Pubnub error");},
      message: '' + counter,
      callback: function(){console.log('Count sent', counter);}
    });
    
    console.log('Counter', counter);
    counter = 0; // Reset counter so next 5s takes in new data
  }

  console.log('Scanning...');
  ble.startScanning({allowDuplicates:true});
  setInterval(countClearSend, 50000);

});


ble.on('discover', function(peripheral) {
  counter++;
  console.log("Discovered peripheral!", counter);
});
