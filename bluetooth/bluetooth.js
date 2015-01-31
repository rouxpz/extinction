var tessel = require('tessel'),
    blelib = require('ble-ble113a'),
    ble = blelib.use(tessel.port['A']),
    port = tessel.port['GPIO'],
    firstPin = port.pin['G4'],
    secondPin = port.pin['G5'];


var counter = 0;

function motor(){
  console.log('Motor called');
  firstPin.pwmDutyCycle(1000/1000);
  secondPin.pwmDutyCycle(1000/1000);
}

function zeroOut(){
  counter = 0; // Reset counter so next 50s takes in new data
}

ble.on('ready', function(err) {

  // Setup

  var pubnub = require('pubnub').init({
    publish_key: 'pub-c-c68b82e8-a483-44c6-9efb-29ee321615df',
    subscribe_key: 'sub-c-fc32499e-a8b4-11e4-bf84-0619f8945a4f'
  });

  function countClearSend(){
    pubnub.publish({
      channel: "extinction",
      error: function(e){console.log("Pubnub error");},
      message: '' + counter,
      callback: function(){
        console.log('Count sent', counter);
      }
    });
    console.log('Counter', counter);
    zeroOut();
  }

  function history(){
    pubnub.history({
      channel: "extinction",
      callback: function(m){
        var messages = m[0];
        console.log('History', messages)
      }
    })
  }

  // Do all the things

  // Motor
  port.pwmFrequency(10000);
  firstPin.pull(pulldown);
  secondPin.pull(pulldown);
  motor();

  // Bluetooth
  console.log('Scanning...'); 
  ble.startScanning({allowDuplicates:true});
  setInterval(history, 10000);
  setInterval(countClearSend, 50000);

});

ble.on('discover', function(peripheral) {
  counter++;
  console.log("Discovered peripheral!", counter);
});
