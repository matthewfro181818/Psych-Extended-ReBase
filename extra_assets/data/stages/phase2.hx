//
var time:Float = 0.0;
function update(elapsed) {
    time += elapsed;
    cubes.y += Math.sin(time * 2) / 4;
    morecubes.y -= Math.sin(time / 2) / 6;
}