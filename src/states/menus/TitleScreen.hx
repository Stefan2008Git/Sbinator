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
import lime.system.System;

class TitleScreen extends StateHandler
{
    var bg:FlxSprite;
    var checker:FlxBackdrop;
    var bg2:FlxSprite;
    var stefanGuy:FlxSprite;
    var playButton:FlxSprite;
    var creditsButton:FlxSprite;
    var exitGameButton:FlxSprite;
    var versionText:FlxText;
    var creatorName:FlxText;
    var gameLogo:FlxSprite;
    var controls:Bool = false;

    override public function create()
    {
        #if DISCORD_ALLOWED
		// Updating Discord Rich Presence
		DiscordClient.changePresence("In Title Menu", null);
		#end

        bg = new FlxSprite().makeGraphic(FlxG.width, FlxG.height, 0xFF8b0000);
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

        stefanGuy = new FlxSprite().loadGraphic(Paths.imagePath("mainMenu/stefanGuy"));
        stefanGuy.scrollFactor.set();
        stefanGuy.x = -2000;
        stefanGuy.screenCenter(Y);
        stefanGuy.scale.set(1.2, 1.2);
        add(stefanGuy);

        playButton = new FlxSprite().loadGraphic(Paths.imagePath("mainMenu/play"));
        playButton.scrollFactor.set();
        playButton.x = 190;
        playButton.y = -150;
        playButton.scale.set(0.7, 0.7);
        add(playButton);

        creditsButton = new FlxSprite().loadGraphic(Paths.imagePath("mainMenu/credits"));
        creditsButton.scrollFactor.set();
        creditsButton.x = 190;
        creditsButton.y = -150;
        creditsButton.scale.set(0.7, 0.7);
        add(creditsButton);

        exitGameButton = new FlxSprite().loadGraphic(Paths.imagePath("mainMenu/exitGame"));
        exitGameButton.scrollFactor.set();
        exitGameButton.x = 190;
        exitGameButton.y = -150;
        exitGameButton.scale.set(0.7, 0.7);
        add(exitGameButton);

        versionText = new FlxText(5, FlxG.height - -28, 0, "Sbinator " + EngineConfiguration.gameVersion + "\n" + FlxG.VERSION, 16);
        versionText.scrollFactor.set();
        versionText.setFormat(Paths.fontPath("bahnschrift.ttf"), 20, FlxColor.WHITE, LEFT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
        add(versionText);

        creatorName = new FlxText(1170, FlxG.height - -28, 0, "Stefan2008", 16);
        creatorName.scrollFactor.set();
        creatorName.setFormat(Paths.fontPath("bahnschrift.ttf"), 20, FlxColor.RED, RIGHT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
        add(creatorName);

        gameLogo = new FlxSprite(210, -150).loadGraphic(Paths.imagePath("mainMenu/logo"));
        gameLogo.scrollFactor.set();
        gameLogo.scale.set(1.4, 1.4);
        add(gameLogo);

        new FlxTimer().start(0.5, function(tmr:FlxTimer) {
            FlxTween.tween(versionText, {y: 670}, 2, {ease: FlxEase.expoInOut});
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
            FlxTween.tween(playButton, {y: 300}, 2, {ease: FlxEase.expoInOut});
        });

        new FlxTimer().start(1.4, function(tmr:FlxTimer) {
            FlxTween.tween(creditsButton, {y: 400}, 2, {ease: FlxEase.expoInOut});
        });

        new FlxTimer().start(1.7, function(tmr:FlxTimer) {
            FlxTween.tween(exitGameButton, {y: 500}, 2, {ease: FlxEase.expoInOut});
        });

        new FlxTimer().start(2, function(tmr:FlxTimer) {
            FlxTween.tween(gameLogo, {y: 100}, 2, {ease: FlxEase.expoInOut});
        });

        new FlxTimer().start(4, function(tmr:FlxTimer) {
            controls = true;
        });

        super.create();
    }

    override public function update(elapsed:Float)
    {
        if (FlxG.mouse.overlaps(gameLogo) && controls)
        {
            if (FlxG.mouse.justReleased) FlxG.openURL("https://github.com/Stefan2008Git/Sbinator");
        }

        if (FlxG.mouse.overlaps(playButton) && controls)
        {
            if (FlxG.mouse.justReleased)
            {
                StateHandler.switchToNewState(new PlayState());
                trace('Loading the game...');
            }
        }

        if (FlxG.mouse.overlaps(creditsButton) && controls)
        {
            if (FlxG.mouse.justReleased)
            {
                StateHandler.switchToNewState(new CreditsMenu());
            }
        }

        if (FlxG.mouse.overlaps(exitGameButton) && controls)
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
