package states.menus;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.addons.display.FlxBackdrop;
import flixel.addons.display.FlxGridOverlay;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.group.FlxGroup;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.text.FlxText;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.util.FlxColor;

using StringTools;

class CreditsMenu extends StateHandler
{
    // Base menu stuff
    var bg:FlxSprite;
    var checker:FlxBackdrop;
    var secondBg:FlxSprite;
    var button:FlxSprite;

    // Credit icon stuff
    var creditsName:FlxText;
    var creditsDesc:FlxText;
    var creditsIcon:FlxSprite;
    var creditsList:Array<String> = ['stefan2008', 'maysLastPlays', 'coreCat'];
    var creditsGroup:FlxTypedGroup<FlxSprite>;
    var leftArrow:FlxSprite;
    var rightArrow:FlxSprite;
    var currentSelector:Int = 1;

    override public function create()
    {
        #if DISCORD_ALLOWED
		// Updating Discord Rich Presence
		DiscordClient.changePresence("In Credits Menu", null);
		#end

		bg = new FlxSprite().makeGraphic(FlxG.width, FlxG.height, 0xFF0c5c00);
		bg.alpha = 0.8;
		add(bg);

		checker = new FlxBackdrop(FlxGridOverlay.createGrid(80, 80, 160, 160, true, FlxColor.BLACK, 0x0));
        checker.velocity.set(18, 18);
        checker.screenCenter();
        checker.alpha = 0.6;
        add(checker);

        secondBg = new FlxSprite(720, -800).makeGraphic(FlxG.width - 720, FlxG.height, FlxColor.BLACK);
		secondBg.alpha = 0.25;
		add(secondBg);

		creditsName = new FlxText(0, 0, FlxG.width, "");
		creditsName.setFormat("assets/fonts/bahnschrift.ttf", 24, FlxColor.WHITE, CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
        creditsName.scrollFactor.set(0, 0);
        creditsName.borderSize = 2;
        creditsName.antialiasing = true;
        creditsName.screenCenter(X);
        creditsName.y = FlxG.height - 60;
        add(creditsName);

        creditsDesc = new FlxText(0, 0, FlxG.width, "");
        creditsDesc.setFormat("assets/fonts/bahnschrift.ttf", 24, FlxColor.WHITE, CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
        creditsDesc.scrollFactor.set(0, 0);
        creditsDesc.borderSize = 2;
        creditsDesc.antialiasing = true;
        creditsDesc.screenCenter(X);
        creditsDesc.y = FlxG.height - 38;
        add(creditsDesc);

		creditsGroup = new FlxTypedGroup<FlxSprite>();
		add(creditsGroup);

		for (i in 0...creditsList.length)
		{
            creditsIcon = new FlxSprite().loadGraphic("assets/images/creditsMenu/credits/" + creditsList[i] + ".png");
            creditsIcon.scrollFactor.set();
            creditsIcon.screenCenter();
            creditsIcon.scale.set(0.2, 0.2);
            creditsIcon.updateHitbox();
            creditsIcon.ID = i;
            creditsGroup.add(creditsIcon);
		}

		leftArrow = new FlxSprite();
		leftArrow.frames = FlxAtlasFrames.fromSparrow("assets/images/creditsMenu/arrows.png", "assets/images/creditsMenu/arrows.xml");
		leftArrow.screenCenter();
		leftArrow.animation.addByPrefix('leftIdle', "arrow left", 24);
		leftArrow.animation.addByPrefix('pressLeft', "arrow push left", 24);
		leftArrow.x = 50;
		leftArrow.animation.play('leftIdle');
		leftArrow.updateHitbox();
		add(leftArrow);

		rightArrow = new FlxSprite();
		rightArrow.frames = FlxAtlasFrames.fromSparrow("assets/images/creditsMenu/arrows.png", "assets/images/creditsMenu/arrows.xml");
		rightArrow.screenCenter();
		rightArrow.animation.addByPrefix('rightIdle', "arrow right", 24);
		rightArrow.animation.addByPrefix('pressRight', "arrow push right", 24, false);
		rightArrow.x += 550;
		rightArrow.animation.play('rightIdle');
		rightArrow.updateHitbox();
		add(rightArrow);

		button = new FlxSprite().loadGraphic("assets/images/creditsMenu/button.png");
        button.scrollFactor.set();
        button.y = 650;
        button.x = 10;
        button.scale.set(0.5, 0.5);
        button.updateHitbox();
        add(button);

        changeTheSelection();

		super.create();
    }

    var hoveringIcon:Bool = false;
    override public function update(elapsed:Float)
    {
        if (FlxG.mouse.overlaps(button))
        {
            if (FlxG.mouse.justReleased) StateHandler.switchToNewState(new TitleScreen());
        }

        if (FlxG.mouse.overlaps(creditsGroup)) hoveringIcon = true; else hoveringIcon = false;

        for (creditIconSpr in creditsGroup.members)
        {
            if (FlxG.mouse.overlaps(creditIconSpr))
            {
                if (FlxG.mouse.justPressed)
                {
                    switch (creditsList[creditIconSpr.ID])
                    {
                        case "stefan2008": FlxG.openURL("https://www.youtube.com/@stefan2008official");
                        case "maysLastPlays": FlxG.openURL("https://www.youtube.com/@MaysLastPlay");
                        case "coreCat": FlxG.openURL("https://www.youtube.com/@core5570r");
                    }
                }

                switch (creditsList[creditIconSpr.ID])
                {
                    case 'stefan2008':
                        creditsName.text = "Stefan2008";
                        creditsDesc.text = "Creator, programmer and artist";

                    case 'maysLastPlays':
                        creditsName.text = "MaysLastPlay";
                        creditsDesc.text = "First contributor of our project";

                    case 'coreCat':
                        creditsName.text = "CoreCat";
                        creditsDesc.text = "For pop-up event code";
                }
            } else if (!hoveringIcon) {
                creditsName.text = "";
                creditsDesc.text = "";
            }
        }

        if (FlxG.mouse.overlaps(leftArrow)) {
            if (FlxG.mouse.justPressed) changeTheSelection(-1);
        } else if (FlxG.mouse.overlaps(rightArrow)) {
            if (FlxG.mouse.justPressed) changeTheSelection(1);
        }

        super.update(elapsed);
    }

    function changeTheSelection(changer:Int = 0)
    {
        currentSelector += changer;

        switch (changer)
        {
            case -1: leftArrow.animation.play("pressLeft");
            case 1: rightArrow.animation.play("pressRight");
        }

        if (currentSelector < 0) currentSelector = creditsList.length - 1;
        if (currentSelector >= creditsList.length) currentSelector = 0;
    }
}
