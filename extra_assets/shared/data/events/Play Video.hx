import hxvlc.flixel.FlxVideoSprite;

var videoMap:Map<String, FlxVideoSprite> = [];
public static var currentVideos:Array<FlxVideoSprite> = [];

var DebugMode:Bool = false; //Disables videos, just for playtesting charts

public var videoCam:FlxCamera = new FlxCamera();
videoCam.bgColor = 0;


FlxG.cameras.insert(videoCam, 1, false);

function create() {
    if (DebugMode) return;
    for (event in SONG.events)
        if (event.name == "Play Video") {
            var video:FlxVideoSprite = new FlxVideoSprite();
            setupVideoSprite(video);
            videoMap.set(event.params[0], video);

            if (video.load(Paths.video(event.params[0]))) {
                add(video);

                if (FlxG.signals.focusGained.has(video.resume))
                    FlxG.signals.focusGained.remove(video.resume);

                new FlxTimer().start(0.1, function() {
                    video.play();
                    video.pause();
                });
            }
        }
}

function setupVideoSprite(video:FlxVideoSprite) {
    video.bitmap.onFormatSetup.add(function():Void {
        if (video.bitmap != null && video.bitmap.bitmapData != null) {
            final scale:Float = Math.min(FlxG.width / video.bitmap.bitmapData.width, FlxG.height / video.bitmap.bitmapData.height);

            video.setGraphicSize(video.bitmap.bitmapData.width * scale, video.bitmap.bitmapData.height * scale);
            video.updateHitbox();
            video.screenCenter();
        }
    });
    video.bitmap.onEndReached.add(video.destroy);

    video.cameras = [videoCam];
    video.antialiasing = true;
    video.alpha = 0;
}

function onEvent(event) {
    if (DebugMode) return;
    var event = event.event; //DEAR CHRIST
    if (event.name == "Play Video") {
        var video = videoMap.get(event.params[0]);
        video.bitmap.position = 0.0; //idk if this does shit but what the hell
        video.alpha = 1;

        video.resume();
        currentVideos.push(video);
    }
}

function onGamePause()
    for (video in currentVideos)
        if (video != null) 
            video.pause();

function onSubstateClose()
    for (video in currentVideos)
        if (paused && video != null)
            video.resume();

function onFocus()
    for (video in currentVideos)
        if (!paused && video != null)
            video.resume();

function onGameOver()
    DESTROYALLVIDEOSRAHHHH();

function destroy()
    DESTROYALLVIDEOSRAHHHH();

function DESTROYALLVIDEOSRAHHHH() {
    for (video in currentVideos)
        if (video != null)
            video.destroy();
}