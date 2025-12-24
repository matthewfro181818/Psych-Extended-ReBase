var titleCard:FunkinSprite;

function postCreate() {
    titleCard = new FunkinSprite().loadGraphic(Paths.image("game/songCard"));
    titleCard.alpha = 0;
    titleCard.antialiasing = true;
    titleCard.scale.set(0.9, 0.9);
    titleCard.cameras = [camHUD];
    titleCard.screenCenter();
}

function songCard() {
    add(titleCard);
    titleCard.alpha = 1;
    new FlxTimer().start(1.5, function () {
        FlxTween.tween(titleCard, {alpha: 0}, 2);
    });
}