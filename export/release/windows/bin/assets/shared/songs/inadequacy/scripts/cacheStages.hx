import Xml;

function postCreate() {
    for (stage in ["phase1.5", "phase2", "phase3", "phase4", "phase5"])
        cacheStage(stage);
}


function cacheStage(stage:String) {
    var xml = Xml.parse(Assets.getText(Paths.xml('stages/' + stage))).firstElement();
    for (node in xml.elements()) {
        if (node.nodeName == "sprite") {
            var folder = getXMLAtt(xml, "folder");
            if (!StringTools.endsWith(folder, "/")) folder += "/";
            graphicCache.cache(Paths.image(folder + getXMLAtt(node, "sprite"), null, true));
            trace("preloaded: " + getXMLAtt(node, "sprite"));
        }
    }
}

function getXMLAtt(node:Xml, att:String):Null<String> {
        return node.exists(att) ? node.get(att) : null;
}
