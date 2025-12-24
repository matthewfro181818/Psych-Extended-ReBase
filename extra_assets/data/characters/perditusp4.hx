
var time = 0.0;
function update(elapsed) {

    time += elapsed;

    y -= (Math.sin(time) * 0.4);
}