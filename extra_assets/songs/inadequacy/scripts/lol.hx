var ntsc:CustomShader = new CustomShader("flixel-ntsc");
var multiply:CustomShader = new CustomShader("color multiply");

var titleCard:FunkinSprite;

function create() {
    camGame.visible = false;
    camHUD.alpha = 0;

    if(!Options.gameplayShaders) return;
    FlxG.camera.addShader(multiply);
    multiply.mult = 1.0;
    FlxG.camera.addShader(ntsc);
}

function postCreate() {
    songWatermark.text += "\nOur final song, Dave.";
    songWatermark.y -= songWatermark.height / 2;

    titleCard = new FunkinSprite().loadGraphic(Paths.image("game/songCard"));
    titleCard.alpha = 0;
    titleCard.antialiasing = true;
    titleCard.scale.set(0.9, 0.9);
    titleCard.cameras = [camHUD];
    titleCard.screenCenter();
}

function stepHit(step) {
    switch(step) {
        case 384 | 960: 
            camHUD.alpha = 1;
            if (step == 960)
                camGame.alpha = 1;
        case 912:
            for (cam in [camHUD, camGame])
                FlxTween.tween(cam, {alpha: 0}, 1);
        case 3296:
            FlxTween.tween(camHUD, {alpha: 0}, 1, {onComplete: function() {
                for (hudElem in [healthBar, healthBarBG, iconP1, iconP2, comboGroup, songWatermark])
                    hudElem.alpha = 0;
                setStrumlineAlpha(cpu, 0);
            }});
        case 3568:
            FlxTween.tween(camHUD, {alpha: 1}, 1);
        case 3840:
            for (hudElem in [healthBar, healthBarBG, iconP1, iconP2, comboGroup, songWatermark])
                    hudElem.alpha = 1;
            setStrumlineAlpha(cpu, 1);
            
            camGame.shake(0.007, (Conductor.stepCrochet / 1000) * 512);
        case 4352: 
            FlxG.camera.stopShake();

            if(!Options.gameplayShaders) return;
            FlxG.camera.removeShader(ntsc);
    }
}

function onDadHit(NoteHitEvent) {
    if(health >= 0.1) {
        health -= 0.01;
    }
}

function onGameOver() FlxG.camera.stopShake();

function update(elapsed) {
    if(!Options.gameplayShaders) return;
    if (multiply != null && multiply.mult > 1.0)
        multiply.mult = CoolUtil.fpsLerp(multiply.mult, 1.0, 0.04);
}

function multiplyPulse(value) {
    if(!Options.gameplayShaders) return;
    multiply.mult = Std.parseFloat(value);
}

function songCard() {
    add(titleCard);
    titleCard.alpha = 1;
    new FlxTimer().start(1.5, function () {
        FlxTween.tween(titleCard, {alpha: 0}, 2);
    });
}

function setStrumlineAlpha(strumLine:StrumLine, alpha:Float = 1) {
    for (strum in strumLine.members) {
        strum.alpha = alpha;
    }
}