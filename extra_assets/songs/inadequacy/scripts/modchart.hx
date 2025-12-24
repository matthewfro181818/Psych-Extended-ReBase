import modchart.Manager;

function postCreate() {
	if(FlxG.save.data.modcharts) {
		add(m = new Manager());

		m.addModifier('rotate');
		m.addModifier('tornado');
        m.addModifier('drunk');
        m.addModifier('Schmovintipsy');
        m.addModifier('beat');

        for(i in ['rotateY', 'rotateZ']) {
            m.set(i, 0, 45, 0);
            m.set(i, 0, -45, 1);
        }

        for(i in ['rotateY', 'rotateZ']) {
            m.ease(i, 96, 8, 0, FlxEase.expoOut);
        }


        m.ease('rotateX', 124, 1.5, 10, FlxEase.expoOut);
        m.ease('rotateX', 125.5, 1.5, 20, FlxEase.expoOut);
        m.ease('rotateX', 127, 1.5, 30, FlxEase.expoOut);
        m.ease('rotateX', 128, 4, 0, FlxEase.quartOut);

        m.ease('rotateX', 156, 1.5, 10, FlxEase.expoOut);
        m.ease('rotateX', 157.5, 1.5, 20, FlxEase.expoOut);
        m.ease('rotateX', 159, 1.5, 30, FlxEase.expoOut);
        m.ease('rotateX', 160, 4, 0, FlxEase.quartOut);

        m.ease('tornado', 240, 4, 0.3, FlxEase.quartOut);
        m.ease('drunk', 240, 4, 0.5, FlxEase.quartOut);
        m.ease('beat', 240, 4, 0.5, FlxEase.quartOut);

        m.ease('rotateX', 368, 8, -360, FlxEase.quartOut);

        m.ease('tornado', 496, 4, 0, FlxEase.quartOut);
        m.ease('drunk', 496, 4, 0, FlxEase.quartOut);

        m.ease('rotateX', 512, 8, 0, FlxEase.expoOut);
        m.ease('tornado', 512, 4, 0.3, FlxEase.quartOut);
        m.ease('drunk', 512, 4, 0.5, FlxEase.quartOut);

        m.ease('tornado', 624, 4, 0, FlxEase.quartOut);
        m.ease('drunk', 624, 4, 0, FlxEase.quartOut);
        m.ease('beat', 624, 4, 0, FlxEase.quartOut);

        m.ease('beat', 628, 4, 0.5, FlxEase.quartOut);
        m.ease('schmovintipsy', 628, 4, 0.1, FlxEase.quartOut);
        m.ease('drunk', 628, 4, 0.1, FlxEase.quartOut);

        m.ease('schmovintipsy', 756, 4, 0, FlxEase.quartOut);
        m.ease('beat', 756, 4, 0.1, FlxEase.quartOut);
        m.ease('tornado', 756, 4, 0.5, FlxEase.quartOut);
        m.ease('rotateX', 756, 8, -45, FlxEase.quartOut);

        m.ease('rotateX', 820, 8, -360, FlxEase.quartOut);

        m.ease('tornado', 896, 4, 0.25, FlxEase.quartOut);
        m.ease('drunk', 896, 4, 0.5, FlxEase.quartOut);
        m.ease('beat', 896, 4, 0.25, FlxEase.quartOut);
        m.ease('schmovintipsy', 896, 4, 0.5, FlxEase.quartOut);

        m.ease('tornado', 960, 4, 0.5, FlxEase.quartOut);
        m.ease('drunk', 960, 4, 0.25, FlxEase.quartOut);
        m.ease('schmovintipsy', 960, 4, 0.25, FlxEase.quartOut);
        m.ease('beat', 960, 4, 0.5, FlxEase.quartOut);

        m.ease('beat', 1088, 4, 0, FlxEase.quartOut);
        m.ease('drunk', 1088, 4, 0, FlxEase.quartOut);
        m.ease('tornado', 1088, 4, 0.25, FlxEase.quartOut);
	}
}
