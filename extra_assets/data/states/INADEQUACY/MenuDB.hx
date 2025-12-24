
import flixel.addons.display.FlxBackdrop;
import flixel.FlxObject;
import funkin.editors.EditorPicker;
import funkin.menus.credits.CreditsMain;
import funkin.menus.ModSwitchMenu;
import funkin.options.OptionsMenu;

var sky, flatgrass, groundOne, hills, groundTwo:FunkinSprite;
var clouds:FlxBackdrop;
var logo:FunkinSprite;

var bgGroup:FlxSpriteGroup = new FlxSpriteGroup();
var camFollow:FlxObject = new FlxObject();
var itemGroup:FlxTypedGroup<FlxSprite> = new FlxTypedGroup();

final screenTensity:Float = 0.02;
var menuOptions:Array<String> = ["play", "extras", "options", "credits"];

function create() {
    CoolUtil.playMenuSong(true);
    FlxG.mouse.visible = true;

    add(camFollow);
    FlxG.camera.follow(camFollow, 0, 0.08);
    
    sky = new FunkinSprite().loadGraphic(getSprite("sky"));
    clouds = new FlxBackdrop().loadGraphic(getSprite("clouds_scrolling"));
    flatgrass = new FunkinSprite().loadGraphic(getSprite("flattgrass"));
    groundOne = new FunkinSprite().loadGraphic(getSprite("back_grounds_one"));
    hills = new FunkinSprite().loadGraphic(getSprite("backgrounds_two"));
    groundTwo = new FunkinSprite().loadGraphic(getSprite("ground"));

    for (sprite in [sky, clouds, flatgrass, groundOne, hills, groundTwo]) {
        sprite.scale.set(0.8, 0.8);
        sprite.updateHitbox();
        bgGroup.add(sprite);
    }
    
    sky.screenCenter(FlxAxes.X);
    sky.y = -50;
    sky.scrollFactor.set(0.2, 0.2);

    clouds.screenCenter(FlxAxes.X);
    clouds.y = -50;
    clouds.velocity.x = -20;
    clouds.scrollFactor.set(0.3, 0.3);

    flatgrass.setPosition(100, (FlxG.height / 2) - 150);
    flatgrass.scrollFactor.set(0.4, 0.4);

    groundOne.screenCenter(FlxAxes.X);
    groundOne.y = (FlxG.height / 2) + 50;
    groundOne.scrollFactor.set(0.5, 0.5);

    hills.setPosition(250, 0);
    hills.scrollFactor.set(0.8, 0.8);

    groundTwo.screenCenter(FlxAxes.X);
    groundTwo.y = FlxG.height / 2;
    groundTwo.scrollFactor.set(1.4, 1.4);
    
    for (thing in [sky, clouds, flatgrass, groundOne, hills, groundTwo])
        thing.antialiasing = true;

    add(bgGroup);

    logo = new FunkinSprite(20).loadGraphic(getSprite("logo"));
    logo.scale.set(0.7, 0.7);
    logo.updateHitbox();
    logo.y = (FlxG.height / 2) - 200;
    add(logo);
    logo.antialiasing = true;
    logo.scrollFactor.set(0, 0);

    for (i in 0...menuOptions.length) {
        var item:MenuItem = new MenuItem(20, 0, null, selectItem).loadGraphic(getSprite("selection/" + menuOptions[i]));
        item.y = (logo.y + logo.height + 50) + (60 * i);
        item.antialiasing = true;
        item.scrollFactor.set(0, 0); //ts pmo

        item.ID = i;
        item.name = menuOptions[i];

        itemGroup.add(item);
    }
    add(itemGroup);
}

function update() {
    var mouseFromCenter = FlxPoint.weak((FlxG.width / 2) - FlxG.mouse.screenX, (FlxG.height / 2) - FlxG.mouse.screenY);
    camFollow.x = (FlxG.width / 2) + (-mouseFromCenter.x * screenTensity);
    camFollow.y = (FlxG.height / 2) + (-mouseFromCenter.y * screenTensity);

    if (controls.SWITCHMOD) {
        openSubState(new ModSwitchMenu());
        persistentUpdate = false;
        persistentDraw = true;
    }

    if (FlxG.keys.justPressed.SEVEN) {
        persistentUpdate = false;
        persistentDraw = true;
        openSubState(new EditorPicker());
    }
}

function selectItem(item:String) {
    switch (item) {
        case "play":
            PlayState.loadSong("inadequacy", "hard");
            FlxG.switchState(new PlayState());
        case "extras":
            FlxG.switchState(new FreeplayState());
        case "options":
            FlxG.switchState(new OptionsMenu());
        case "credits":
            FlxG.switchState(new CreditsMain());
    }
}


//shortcut so i dont have to manually write the whole path every time
function getSprite(name:String) {
    return Paths.image("menus/MenuDB/" + name);
}

class MenuItem extends FunkinSprite {
    public var onClick:Void->Void;
    public var selected:Bool = false;
    public var name:String;

    public function new(x:Float = 0, y:Float = 0, ?SimpleGraphic:Null<FlxGraphicAsset>, ?onClick:String->Void) {
        super(x, y);
        this.onClick = onClick;
    }

    public function update(elapsed:Float) {
        super.update(elapsed);
        if(FlxG.mouse.overlaps(this)) {

            if (FlxG.mouse.justPressed)
                onClick(name);
            
            scale.set(CoolUtil.fpsLerp(scale.x, 1.05, 0.5), CoolUtil.fpsLerp(scale.y, 1.05, 0.3));
            alpha = 1;

            if (!selected)
                FlxG.sound.play(Paths.sound("menu/scroll"));
            selected = true;

        } else {
            scale.set(CoolUtil.fpsLerp(scale.x, 1, 0.5), CoolUtil.fpsLerp(scale.y, 1, 0.5));
            alpha = 0.5;
            selected = false;

        }
    }

}