angular

.module('timerApp', [])

.controller('TimerController', function($scope, $timeout) {
  var timer, stepTimeout;

  timer = this;

  $scope.intervals = [10,5,10,5];
  $scope.reps = 2;

  timer.start = function(intervals, reps) {
    timer.intervals = intervals;
    timer.reps = reps;

    timer.repIndex = 0;
    timer.intervalIndex = 0;
    timer.timeRemaining = intervals[0];

    $timeout.cancel(stepTimeout);
    speak();
    nextStep();
  };

  function step() {
    timer.timeRemaining--;
    if ( timer.timeRemaining === 0 ) {
      timer.intervalIndex = ( timer.intervalIndex + 1 ) % timer.intervals.length;
      if ( timer.intervalIndex === 0 ) {
        timer.repIndex++;
      }
      if ( timer.repIndex < timer.reps ) {
        timer.timeRemaining = timer.intervals[timer.intervalIndex];
        speak();
      }
    }
    nextStep();
  }

  function nextStep() {
    if ( timer.repIndex < timer.reps ) {
      stepTimeout = $timeout( function() { step(); }, 1000 );
    }
  }

  function speak() {
    var offset = 0;

    function play(id, duration) {
      $timeout( function() {
        document.getElementById(id).play();
      }, offset );
      offset += duration;
    }

    play('audio-count-'+(timer.intervalIndex + 1), 500);
    play('audio-interval', 700);
    play('audio-rep', 300);
    play('audio-'+(timer.repIndex + 1));
  }

});
