import flixel.addons.display.FlxBackdrop;
import openfl.display.BlendMode;

var fog:FlxBackdrop;

function postCreate() {
    fog = new FlxBackdrop(fogtemp.pixels, FlxAxes.X);
    fog.velocity.x = -5000;
    fog.scale.set(fogtemp.scale.x, fogtemp.scale.y);
    fog.scrollFactor.set(fogtemp.scrollFactor.x, fogtemp.scrollFactor.y);
    fog.antialiasing = true;
    insert(members.indexOf(fogtemp) + 1, fog);
    remove(fogtemp);

    moon.blend = BlendMode.ADD;
}

var time:Float = 0.0;
function update(elapsed) {
    time += elapsed;
    gates.y += Math.sin(time * 2) / 4;
    gates2.y -= Math.sin(time * 2) / 8;
}

function destroy() {
    fog.destroy();
}