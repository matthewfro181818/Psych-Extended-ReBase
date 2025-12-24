final GOOD_ENDING_REQUIREMENT:Float = 0.6; //accuracy needed for the good ending (in decimals)
var ending:FlxSprite;
var black:FlxSprite = new FlxSprite().makeSolid(FlxG.width, FlxG.height, FlxColor.BLACK);
var noMiss:Bool = false;

function stepHit(curStep:Int) {
    if (curStep == 4616) {
        FlxTween.tween(camHUD, {alpha: 0}, 1, {onComplete: function() {
            add(black);
            black.cameras = [camHUD];

            var ending = checkEnding(accuracy);
            ending = new FlxSprite().loadGraphic(Paths.image("game/" + ending + "ending"));
            final scale = Math.min(FlxG.width / ending.width, FlxG.height / ending.height);
            ending.setGraphicSize(ending.width * scale, ending.height * scale);
            ending.antialiasing = true;
            ending.updateHitbox();
            ending.screenCenter();
            add(ending);
            ending.cameras = [camHUD];

            noMiss = true;
        }});

        
    } else if (curStep == 4868) {
        FlxTween.tween(camHUD, {alpha: 1}, 1);
    }
}

function checkEnding(acc:Float) {
    var roundedAcc = FlxMath.roundDecimal(acc, 2);
    var ending:String = (roundedAcc >= GOOD_ENDING_REQUIREMENT) ? "good" : "bad";
    return ending;
}

function onPlayerMiss(event) {
    if (!noMiss) return;
    event.cancel();
}