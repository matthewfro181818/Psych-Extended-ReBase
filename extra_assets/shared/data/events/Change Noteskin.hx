import funkin.backend.system.Flags;

var skin:String = "game/notes/default";
var antialiasing:Bool = true;

function onEvent(event) {
    var event = event.event;
    if (event.name != "Change Noteskin") return;
    var strumline = strumLines.members[event.params[0]];
    skin = event.params[1];
    antialiasing = event.params[2];

    for (strum in strumline) {
        updateStrums(strum);
        updateNotes(strumline.notes);
    }
}

function updateNotes(noteGroup:StrumLine) {
    for (note in noteGroup.members) {
        var noteAnims = note.animation;
        var anim = noteAnims.name;
        var noteAnimPrefix = ["purple", "blue", "green", "red"];
        var animPrefix = noteAnimPrefix[note.strumID % noteAnimPrefix.length];

        note.frames = Paths.getFrames(skin);

        noteAnims.addByPrefix('scroll', animPrefix + '0');
        noteAnims.addByPrefix('hold', animPrefix + ' hold piece');
        noteAnims.addByPrefix('holdend', animPrefix + ' hold end');
        if (noteAnims.exists("holdend") != true)
            noteAnims.addByPrefix("holdend", "pruple end hold"); //I HATE YOU DAVID BROWN!!! /j
            


        note.antialiasing = antialiasing;
        note.animation.play(anim);

        note.updateHitbox();
        
    }
}

function updateStrums(strum:Strum) {
    strum.frames = Paths.getFrames(skin);
    var strumline = strum.strumLine;
    var strumAnimPrefix = strumline.strumAnimPrefix;
    var animPrefix = strumAnimPrefix[strum.ID % strumAnimPrefix.length];

    strum.animation.addByPrefix('static', 'arrow' + animPrefix.toUpperCase());
    strum.animation.addByPrefix('pressed', animPrefix +' press', 24, false);
    strum.animation.addByPrefix('confirm', animPrefix +' confirm', 24, false);

    strum.antialiasing = antialiasing;
    strum.animation.play('static');

    strum.updateHitbox();
}