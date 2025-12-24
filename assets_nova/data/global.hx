import hxvlc.util.Handle;

function new() {
    Handle.initAsync([]);
    
    if (FlxG.save.data.modcharts == null)
        FlxG.save.data.modcharts = true;
}

function destroy() {
    Handle.dispose();
}