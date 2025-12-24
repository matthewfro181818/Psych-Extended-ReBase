//Just a simple fix so that important lines such as "I FUCKING HATE EVERYTHING!!!" or the lyrics arent inaudible even if you miss
function create() {
    muteVocalsOnMiss = false;
}

function beatHit(curBeat:Int) {
    switch (curBeat) {
        case 96 | 240 | 896:
            muteVocalsOnMiss = true;
        case 232 | 820 | 1154:
            muteVocalsOnMiss = false;
            unmuteVocals();
            
    }
}

function unmuteVocals() {
    if (vocals != null)
        vocals.volume = 1;
}