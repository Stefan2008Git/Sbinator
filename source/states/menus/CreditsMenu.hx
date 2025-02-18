package states.menus;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.addons.display.FlxBackdrop;
import flixel.addons.display.FlxGridOverlay;
import flixel.text.FlxText;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.util.FlxColor;

using StringTools;
typedef CreditsMeta =
{
    var name:String;
    var ability:String;
    var description:String;
    var link:String;
}

class CreditsMenu extends FlxState
{
    var bg:FlxSprite;
    var checker:FlxBackdrop;
    var secondBg:FlxSprite;
    var iconMembers:FlxSprite;
    var arrowSymbol1:FlxSprite;
    var arrowSymbol2:FlxSprite;
    var creditsText:FlxText;
    var button:FlxSprite;
    var menionedPeople:Array<CreditsMeta> = [
        {name: "Stefan2008", ability: "Owner, programmer and artist!", description: "Made this project for fun", link: "https://www.youtube.com/@stefan2008official"},
        {name: "CoreCat", ability: "Coder", description: "For Pop-up code event!", link: "https://www.youtube.com/@core5570r"}
    ];
    var currentlySelected:Int = 0;

    override public function create()
    {
        #if DISCORD_ALLOWED
		// Updating Discord Rich Presence
		DiscordClient.changePresence("In Credits Menu", null);
		#end

		openSubState(new PopUpEvent("Unfinished menu", "This menu is currently in work-in-progress and it contains a crashes, but you can test it!", [
        {
            text: "Okay",
            callback: function()
            {
                closeSubState();
            }
				},
                    {
                        text: "Go back",
                        callback: function()
                    {
                    FlxG.switchState(TitleScreen.new);
                }
            }
        ], false, true));

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

		iconMembers = new FlxSprite().loadGraphic("assets/images/creditsMenu/People.png", true);
		iconMembers.animation.addByPrefix('Stefan2008', 'Stefan2008');
		iconMembers.animation.addByPrefix('Core', 'Core');
		iconMembers.animation.play("Stefan2008");
		iconMembers.screenCenter();
		add(iconMembers);

		arrowSymbol1 = new FlxSprite().loadGraphic("assets/images/creditsMenu/Arrow.png", true);
		arrowSymbol1.screenCenter();
		arrowSymbol1.animation.addByPrefix('left', "arrow left", 24);
		arrowSymbol1.animation.addByPrefix('press', "arrow push left", 24);
		arrowSymbol1.x -= 100;
		arrowSymbol1.animation.play('left');
		add(arrowSymbol1);

		arrowSymbol2 = new FlxSprite().loadGraphic("assets/images/creditsMenu/Arrow.png", true);
		arrowSymbol2.screenCenter();
		arrowSymbol2.animation.addByPrefix('right', "arrow right", 24);
		arrowSymbol2.animation.addByPrefix('press', "arrow push right", 24, false);
		arrowSymbol2.x += 225;
		arrowSymbol2.animation.play('right');
		add(arrowSymbol2);

		creditsText = new FlxText(0, 0, FlxG.width, "", 24);
		creditsText.setFormat("Bahnschrift", 32, FlxColor.fromRGB(200, 200, 200), CENTER);
		creditsText.borderColor = FlxColor.BLACK;
		creditsText.borderSize = 3;
		creditsText.borderStyle = FlxTextBorderStyle.OUTLINE;
		creditsText.screenCenter();
		creditsText.y += 275;
		add(creditsText);

		button = new FlxSprite().loadGraphic("assets/images/creditsMenu/button.png");
        button.scrollFactor.set();
        button.y = 625;
        button.x = -85;
        button.scale.set(0.5, 0.5);
        add(button);

		super.create();
    }

    override public function update(elapsed:Float)
    {
        final left = FlxG.keys.anyPressed([LEFT, A]);
        final right = FlxG.keys.anyPressed([RIGHT, D]);
        final press = FlxG.keys.anyPressed([ENTER, P]);

        var coolPeople = menionedPeople[currentlySelected];
        creditsText.text = coolPeople.name + "\n" + coolPeople.ability + "\n" + coolPeople.description;
        iconMembers.animation.play(coolPeople.name);

        if (left) changeIconFrame(1); else if (right) changeIconFrame(1);
        if (press && coolPeople.link == null) FlxG.openURL(coolPeople.link);

        if (FlxG.mouse.overlaps(button))
        {
            if (FlxG.mouse.justReleased) FlxG.switchState(TitleScreen.new);
        }

        super.update(elapsed);
    }

    public function changeIconFrame(intValue:Int)
    {
        currentlySelected = intValue;

        switch (intValue)
        {
            case -1: arrowSymbol1.animation.play("press");
            case 1: arrowSymbol2.animation.play("press");
        }

        if (currentlySelected < 0) currentlySelected = 2;
        if (currentlySelected > 2) currentlySelected = 8;
    }
}
