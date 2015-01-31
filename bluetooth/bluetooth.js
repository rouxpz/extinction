var tessel = require('tessel'),
    blelib = require('ble-ble113a'),
    ble = blelib.use(tessel.port['A']),
    port = tessel.port['GPIO'],
    firstPin = port.pin['G4'],
    secondPin = port.pin['G5'];


var counter = 0;

function motor(first, second){  // Right now sending the same to each bc only 1 diode; with 2, greater variation
  console.log('Motor called');
  firstPin.pwmDutyCycle(first/1000);
  secondPin.pwmDutyCycle(second/1000);
}

function zeroOut(){
  counter = 0; // Reset counter so next 50s takes in new data
}


// Once the module is ready

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
        console.log('Count sent');
      }
    });
    console.log('Counter', counter);
    zeroOut();
  }

  function sendMotor(){
    pubnub.history({
      channel: "extinction",
      count: 10,
      callback: function(m){
        console.log('history:', m);
        var data = m[0],
            highest = 0;

        for (var i = 0, l = data.length; i < l; i++){
          (data[i] > highest) && (highest = data[i]);
        }

        switch(true){
          case (counter <= (highest * 0.25)):
            console.log('1');
            motor(500, 500);
            break;

          case (counter < (highest * 0.35)):
            console.log('2');
            motor(650, 650);
            break;

          case (counter < (highest * .75)):
            console.log('3');
            motor(800, 800);
            break;

          case (counter >= (highest * .75)):
            console.log('4');
            motor(1000, 1000);
            break;

          default:
            console.log('Switch error');
        }
      }
    });
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
  // motor(650, 650); // Testing motor only

  // Bluetooth
  console.log('Scanning...'); 
  ble.startScanning({allowDuplicates:true});
  setInterval(sendMotor, 55000);
  setInterval(countClearSend, 50000);

});

ble.on('discover', function(peripheral) {
  counter++;
  console.log("Discovered peripheral!", counter);
});
