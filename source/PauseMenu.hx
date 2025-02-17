package;

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
            FlxTween.tween(bg2, {y: -5}, 2, {ease: FlxEase.expoInOut});
        });
    }

    override function update(elapsed:Float)
    {
        if (FlxG.keys.justPressed.ESCAPE) close();

        if (FlxG.keys.justPressed.BACKSPACE) FlxG.switchState(TitleScreen.new);
    }
}
