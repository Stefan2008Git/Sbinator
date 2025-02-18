package states.menus;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxSubState;
import flixel.addons.display.FlxBackdrop;
import flixel.addons.display.FlxGridOverlay;
import flixel.tweens.FlxTween;
import flixel.tweens.FlxEase;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;

class PauseMenu extends FlxSubState
{
    var bg:FlxSprite;
    var checker:FlxBackdrop;
    var bg2:FlxSprite;
    var button1:FlxSprite;
    var button2:FlxSprite;
    var button3:FlxSprite;

    override public function create()
    {
        #if DISCORD_ALLOWED
		// Updating Discord Rich Presence
		DiscordClient.changePresence("In Pause Menu", null);
		#end

        bg = new FlxSprite().makeGraphic(FlxG.width, FlxG.height, FlxColor.BLACK);
        bg.alpha = 0;
        add(bg);

        checker = new FlxBackdrop(FlxGridOverlay.createGrid(80, 80, 160, 160, true, FlxColor.GRAY, 0x0));
        checker.velocity.set(15, 15);
        checker.screenCenter();
        checker.alpha = 0;
        add(checker);

        bg2 = new FlxSprite(720, -800).makeGraphic(FlxG.width - 720, FlxG.height, FlxColor.BLACK);
		bg2.alpha = 0.25;
		add(bg2);

		button1 = new FlxSprite().loadGraphic("assets/images/pauseMenu/button1.png");
        button1.scrollFactor.set();
        button1.x = 190;
        button1.y = -150;
        button1.scale.set(0.7, 0.7);
        add(button1);

        button2 = new FlxSprite().loadGraphic("assets/images/pauseMenu/button2.png");
        button2.scrollFactor.set();
        button2.x = 190;
        button2.y = -150;
        button2.scale.set(0.7, 0.7);
        add(button2);

        button3 = new FlxSprite().loadGraphic("assets/images/pauseMenu/button3.png");
        button3.scrollFactor.set();
        button3.x = 190;
        button3.y = -150;
        button3.scale.set(0.7, 0.7);
        add(button3);

		new FlxTimer().start(0.6, function(tmr:FlxTimer) {
            FlxTween.tween(bg, {alpha: 0.6}, 0.7, {ease: FlxEase.quartInOut});
        });

        new FlxTimer().start(0.6, function(tmr:FlxTimer) {
            FlxTween.tween(checker, {alpha: 0.6}, 0.7, {ease: FlxEase.quartInOut});
        });

        new FlxTimer().start(0.7, function(tmr:FlxTimer) {
            checker.velocity.set(28, 28);
        });

		new FlxTimer().start(0.85, function(tmr:FlxTimer) {
            FlxTween.tween(bg2, {y: -3}, 2, {ease: FlxEase.expoInOut});
        });

        new FlxTimer().start(0.95, function(tmr:FlxTimer) {
            FlxTween.tween(button1, {y: 300}, 2, {ease: FlxEase.expoInOut});
        });

        new FlxTimer().start(1.2, function(tmr:FlxTimer) {
            FlxTween.tween(button2, {y: 400}, 2, {ease: FlxEase.expoInOut});
        });

        new FlxTimer().start(1.4, function(tmr:FlxTimer) {
            FlxTween.tween(button3, {y: 500}, 2, {ease: FlxEase.expoInOut});
        });

        super.create();
    }

    override function update(elapsed:Float)
    {
        if (FlxG.mouse.overlaps(button1))
        {
            if (FlxG.mouse.justPressed) close();
        }

        if (FlxG.mouse.overlaps(button2))
        {
            if (FlxG.mouse.justPressed) FlxG.resetState();
        }

        if (FlxG.mouse.overlaps(button3))
        {
            if (FlxG.mouse.justPressed) FlxG.switchState(TitleScreen.new);
        }

        super.update(elapsed);
    }
}
