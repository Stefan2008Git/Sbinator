package states;

import flixel.FlxG;
import flixel.FlxGame;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.sound.FlxSound;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.util.FlxTimer;

class InitState extends FlxState
{
    var sbinator:FlxSprite;
    var pop:FlxSound;

    override function create()
    {
        #if DISCORD_ALLOWED
		// Updating Discord Rich Presence
		DiscordClient.changePresence("In Initialization", null);
		#end

        new FlxTimer().start(0.1, function(tmr:FlxTimer)
        {
            doAThing();
        });

        super.create();
    }

    public function doAThing()
    {   
        pop = FlxG.sound.load(Paths.soundPath("pop"));

		sbinator = new FlxSprite().loadGraphic(Paths.imagePath('sbinator'));
		sbinator.scrollFactor.set();
		sbinator.screenCenter();
		sbinator.alpha = 0;
		sbinator.active = true;
		sbinator.scale.set(0.01, 0.01);
		add(sbinator);

		new FlxTimer().start(3, function(tmr:FlxTimer)
        {
            sbinator.alpha = 0.2;
        });

        new FlxTimer().start(5, function(tmr:FlxTimer)
        {
            FlxTween.tween(sbinator, {alpha: 1, "scale.x": 0.1, "scale.y": 0.1}, 1.3, {ease: FlxEase.expoOut, onComplete: _ -> onInitDone()});
        });
    }

    public function onInitDone()
    {        
        sbinator.active = false;
        sbinator.alpha = 0;
        pop.play();
        pop.onComplete = function()                
        {
            StateHandler.switchToNewState(new TitleScreen());
        }
    }
}
