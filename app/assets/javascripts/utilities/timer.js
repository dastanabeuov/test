document.addEventListener('turbolinks:load', function () {
  var timer = document.querySelector('.timer')
  if (timer) {
    var step = 1000;
    var timerDown = timer.dataset.time;
    var form = document.querySelector('form');

    setInterval(function () {
      if (timerDown > 0) {
        timerDown -= 1;
      } else {
        alert('Время вышло!');
        form.submit();
      }

      var time = parseInt(timerDown / 60) + ":" +  timerDown % 60;
      timer.innerHTML = time
    }, step)
  }
})