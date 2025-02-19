package states.modules;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.addons.display.FlxBackdrop;
import flixel.addons.display.FlxGridOverlay;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import lime.app.Application;

class CrashHandlerState extends StateHandler
{
    var errorMessage:String = '';
    var bg:FlxSprite;
    var checker:FlxBackdrop;
    var title:FlxText;
    var crashText:FlxText;
    var controlsCheck:Bool = false;
    public static var randomErrorMessages:Array<String> = [
        "SBINATOR OCCURED A CRASH!!",
        "Uncaught Error", // Suggested by MaysLastPlays
        "null object reference", // Suggested by riirai_luna (Luna)
        "Null What the..." // Suggested by Rafi
    ];

    public function new(errorMessage:String)
    {
        super();
        this.errorMessage = errorMessage;
    }

    override public function create()
    {
        super.create();

        Application.current.window.title = "Sbinator " + TitleScreen.gameVersion + " crash handler!";

        bg = new FlxSprite().makeGraphic(FlxG.width, FlxG.height, FlxColor.GREEN);
        bg.alpha = 0.6;
        add(bg);

        checker = new FlxBackdrop(FlxGridOverlay.createGrid(80, 80, 160, 160, true, FlxColor.BLACK, 0x0));
        checker.velocity.set(18, 18);
        checker.screenCenter();
        checker.alpha = 0.4;
        add(checker);

        title = new FlxText(0, 16, 0, randomErrorMessages[FlxG.random.int(0, randomErrorMessages.length)]);
        title.setFormat("assets/fonts/bahnschrift.ttf", 36, FlxColor.RED, CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
        title.screenCenter(X);
        add(title);

        crashText = new FlxText(24, title.y + title.height + 16, FlxG.width - 24, errorMessage);
        crashText.setFormat("assets/fonts/bahnschrift.ttf", 24, FlxColor.ORANGE, LEFT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
        add(crashText);
    }

    override public function update(elapsed:Float)
    {
        Application.current.window.title = "Sbinator";
        if (FlxG.keys.justPressed.ESCAPE) StateHandler.switchToNewState(new TitleScreen());
        super.update(elapsed);
    }
}
