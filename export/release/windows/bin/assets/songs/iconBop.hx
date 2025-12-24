//CODE BY I exist, resourced by ya boi Hyper, HScript port by Jikken

final bpmbased = false;
var iconhp, iconhp2;
final speed = 0.35;
final transition = 'quintOut';

function create()
    doIconBop = false; //Disable default codename icon bop

function beatHit() {
    if (!doIconBop && !startingSong) {
        for (icon in [iconP1, iconP2])
            FlxTween.cancelTweensOf(icon);

        iconP1.scale.set(iconhp, iconP1.scale.y / iconhp);
        iconP2.scale.set(iconhp2, iconP2.scale.y / iconhp2);

        var duration = bpmbased ? Conductor.crochet/1500 : speed;

        for (icon in [iconP1, iconP2])
            FlxTween.tween(icon, {"scale.x": icon.defaultScale, "scale.y": icon.defaultScale}, duration, {ease: CoolUtil.flxeaseFromString(transition)});
    }
}

function postUpdate() {
    iconhp = healthBar.percent / 35 * 0.5 + 1;
    iconhp2 = -healthBar.percent / 35 * 0.5 + 2.5;

    iconP1.origin.set(0, (-iconP1.height * iconP1.defaultScale) + iconP1.height);
    iconP2.origin.set(iconP2.frameWidth, (-iconP2.height * iconP2.defaultScale) + iconP2.height);
}