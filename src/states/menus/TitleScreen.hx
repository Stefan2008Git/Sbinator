package states.menus;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.addons.display.FlxBackdrop;
import flixel.addons.display.FlxGridOverlay;
import flixel.math.FlxMath;
import flixel.text.FlxText;
import flixel.tweens.FlxTween;
import flixel.tweens.FlxEase;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;

class TitleScreen extends FlxState
{
    var bg:FlxSprite;
    var checker:FlxBackdrop;
    var bg2:FlxSprite;
    var stefanGuy:FlxSprite;
    var button1:FlxSprite;
    var button2:FlxSprite;
    var button3:FlxSprite;
    public static var gameVersion:String = "1.0.0";
    var sbinatorText:FlxText;
    var creatorName:FlxText;
    var gameLogo:FlxSprite;
    var controls:Bool = true;

    override public function create()
    {
        super.create();

        #if DISCORD_ALLOWED
		// Updating Discord Rich Presence
		DiscordClient.changePresence("In Title Menu", null);
		#end

        bg = new FlxSprite().loadGraphic("assets/images/mainMenu/bg.png");
        bg.scrollFactor.set();
        bg.screenCenter();
        bg.alpha = 0.7;
        add(bg);

        checker = new FlxBackdrop(FlxGridOverlay.createGrid(80, 80, 160, 160, true, FlxColor.BLACK, 0x0));
        checker.velocity.set(28, 28);
        checker.screenCenter();
        checker.alpha = 0.6;
        add(checker);

        bg2 = new FlxSprite(720, -800).makeGraphic(FlxG.width - 720, FlxG.height, FlxColor.BLACK);
		bg2.alpha = 0.25;
		add(bg2);

        stefanGuy = new FlxSprite().loadGraphic("assets/images/mainMenu/stefan2008.png");
        stefanGuy.scrollFactor.set();
        stefanGuy.x = -2000;
        stefanGuy.screenCenter(Y);
        stefanGuy.scale.set(1.2, 1.2);
        add(stefanGuy);

        button1 = new FlxSprite().loadGraphic("assets/images/mainMenu/button1.png");
        button1.scrollFactor.set();
        button1.x = 190;
        button1.y = -150;
        button1.scale.set(0.7, 0.7);
        add(button1);

        button2 = new FlxSprite().loadGraphic("assets/images/mainMenu/button2.png");
        button2.scrollFactor.set();
        button2.x = 190;
        button2.y = -150;
        button2.scale.set(0.7, 0.7);
        add(button2);

        button3 = new FlxSprite().loadGraphic("assets/images/mainMenu/button3.png");
        button3.scrollFactor.set();
        button3.x = 190;
        button3.y = -150;
        button3.scale.set(0.7, 0.7);
        add(button3);

        sbinatorText = new FlxText(5, FlxG.height - -28, 0, "Sbinator " + gameVersion, 16);
        sbinatorText.scrollFactor.set();
        sbinatorText.setFormat("assets/fonts/bahnschrift.ttf", 20, FlxColor.WHITE, LEFT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
        add(sbinatorText);

        creatorName = new FlxText(1170, FlxG.height - -28, 0, "Stefan2008", 16);
        creatorName.scrollFactor.set();
        creatorName.setFormat("assets/fonts/bahnschrift.ttf", 20, FlxColor.GREEN, RIGHT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
        add(creatorName);

        gameLogo = new FlxSprite().loadGraphic("assets/images/mainMenu/logo.png");
        gameLogo.scrollFactor.set();
        gameLogo.x = 210;
        gameLogo.y = -150;
        gameLogo.scale.set(1.4, 1.4);
        add(gameLogo);

        new FlxTimer().start(0.5, function(tmr:FlxTimer) {
            FlxTween.tween(sbinatorText, {y: 690}, 2, {ease: FlxEase.expoInOut});
        });

        new FlxTimer().start(0.7, function(tmr:FlxTimer) {
            FlxTween.tween(creatorName, {y: 690}, 2, {ease: FlxEase.expoInOut});
        });

        new FlxTimer().start(0.85, function(tmr:FlxTimer) {
            FlxTween.tween(bg2, {y: -3}, 2, {ease: FlxEase.expoInOut});
        });

        new FlxTimer().start(0.95, function(tmr:FlxTimer) {
            FlxTween.tween(stefanGuy, {x: 885}, 2, {ease: FlxEase.expoInOut});
        });

        new FlxTimer().start(1.1, function(tmr:FlxTimer) {
            FlxTween.tween(button1, {y: 300}, 2, {ease: FlxEase.expoInOut});
        });

        new FlxTimer().start(1.4, function(tmr:FlxTimer) {
            FlxTween.tween(button2, {y: 400}, 2, {ease: FlxEase.expoInOut});
        });

        new FlxTimer().start(1.7, function(tmr:FlxTimer) {
            FlxTween.tween(button3, {y: 500}, 2, {ease: FlxEase.expoInOut});
        });

        new FlxTimer().start(2, function(tmr:FlxTimer) {
            FlxTween.tween(gameLogo, {y: 100}, 2, {ease: FlxEase.expoInOut});
        });

        new FlxTimer().start(5, function(tmr:FlxTimer) {
            controls = true;
        });
    }

    override public function update(elapsed:Float)
    {
        if (FlxG.mouse.overlaps(creatorName) && controls)
        {
            if (FlxG.mouse.justReleased) FlxG.openURL("https://www.youtube.com/@stefan2008official");
        }


        if (FlxG.mouse.overlaps(gameLogo) && controls)
        {
            if (FlxG.mouse.justReleased) FlxG.openURL("https://github.com/Stefan2008Git/Sbinator");
        }

        if (FlxG.mouse.overlaps(button1) && controls)
        {
            if (FlxG.mouse.justReleased)
            {
                StateHandler.switchToNewState(new PlayState());
            }
        }

        if (FlxG.mouse.overlaps(button2) && controls)
        {
            if (FlxG.mouse.justReleased)
            {
                StateHandler.switchToNewState(new CreditsMenu());
            }
        }

        if (FlxG.mouse.overlaps(button3) && controls)
        {
            if (FlxG.mouse.justReleased)
            {
                openSubState(new PopUpEvent("Closing game Confirmation",
				"Are you sure you want to exit the whole game?", [
				{
					text: "Yes",
					callback: function()
					{
						lime.system.System.exit(1);
					}
				},
                    {
                        text: "No",
                        callback: function()
                        {
                            closeSubState();
                        }
                    }
                ], false, true));
            }
        }

        super.update(elapsed);
    }
}
