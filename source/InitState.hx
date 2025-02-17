package;

import flixel.FlxG;
import flixel.FlxGame;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.util.FlxTimer;

class InitState extends FlxState
{
    var stefan2008:FlxSprite;

    override function create()
    {
        super.create();

        #if DISCORD_ALLOWED
		// Updating Discord Rich Presence
		DiscordClient.changePresence("In Initialization", null);
		#end

        new FlxTimer().start(0.1, function(tmr:FlxTimer)
        {
            doAThing();
        });
    }

    public function doAThing()
    {
		stefan2008 = new FlxSprite().loadGraphic('assets/images/stefan2008.png');
		stefan2008.scrollFactor.set();
		stefan2008.screenCenter();
		stefan2008.alpha = 0;
		stefan2008.active = true;
		stefan2008.scale.set(0.1, 0.1);
		add(stefan2008);

		new FlxTimer().start(3, function(tmr:FlxTimer)
        {
            stefan2008.alpha = 0.2;
        });

        new FlxTimer().start(10, function(tmr:FlxTimer)
        {
            FlxTween.tween(stefan2008, {alpha: 1, "scale.x": 0.4, "scale.y": 0.4}, 1.3, {ease: FlxEase.expoOut, onComplete: _ -> onInitDone()});
        });
    }

    public function onInitDone()
    {
        new FlxTimer().start(1, function(tmr:FlxTimer)
        {
            FlxG.sound.play('assets/sounds/pop.ogg');
            stefan2008.active = false;
            stefan2008.alpha = 0;
        });

        new FlxTimer().start(3, function(tmr:FlxTimer)
        {
            FlxG.switchState(TitleScreen.new);
        });
    }
}
