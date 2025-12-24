function onEvent(e) {
    var event = e.event;
    if (event.name == "centerCamera") {
        FlxTween.cancelTweensOf(camFollow, ["x", "y"]);

        var dadCamPos = dad.getCameraPosition();
        var bfCamPos = boyfriend.getCameraPosition();

        var midPoint:FlxPoint = FlxPoint.get((bfCamPos.x + dadCamPos.x) / 2, (bfCamPos.y + dadCamPos.y) / 2);
        curCameraTarget = -1;

        if (!event.params[0]) {
            camGame.followLerp = 0.04;
            
            camFollow.x = midPoint.x;
            camFollow.y = midPoint.y;
        } else {
            camGame.followLerp = 1;
            FlxTween.tween(camFollow, {x: midPoint.x, y: midPoint.y}, (Conductor.stepCrochet / 1000) * event.params[1], {ease: CoolUtil.flxeaseFromString(event.params[2], event.params[3]), onComplete: function() {
                camGame.followLerp = 0.04;
            }});
        }
    }
}