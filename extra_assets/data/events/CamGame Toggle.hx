function onEvent(event) {
    var event = event.event;
    if (event.name == "CamGame Toggle") {
        camGame.visible = event.params[0];
    }
}