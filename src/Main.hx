package;

import flixel.FlxGame;
import flixel.FlxG;
import openfl.Lib;
import openfl.display.Sprite;
import openfl.display.StageScaleMode;

#if linux
import lime.graphics.Image;
#end

#if CRASH_HANDLER
import haxe.CallStack;
import haxe.io.Path;
import openfl.events.UncaughtErrorEvent;
#end

// Required for Date string to class call replace!
using StringTools;

class Main extends Sprite
{
	var mainGame = {
		width: 1280,
		heigh: 720,
		initialMenu: InitState,
		fps: 60,
		skipFlixelSplash: true
	};

	public static var fpsVar:FramePerSecond;
	public static var watermarkIcon:Watermark;

	public static var randomErrorMessages:Array<String> = [
        "SBINATOR OCCURRED A CRASH!!",
        "Uncaught Error", // Suggested by MaysLastPlays
        "null object reference", // Suggested by riirai_luna (Luna)
        "Null What the...", // Suggested by Rafi
        "Sbinator might not be gaming", // Suggested by riirai_luna (Luna)
        '"An error occurred."', // Suggested by core5570r (CoreCat)
        "An excpetion occurred", // Sonic CD lookin crash screen
        "Object retreival error", // FNAF 2 Deluxe Edition error code
        "Null Acess", // This is impossible to get into Flixel!
        "NullReferenceException" // C#, Unity, Java, Rust error
    ];

	public function new()
	{
		super();

		#if CRASH_HANDLER
		Lib.current.loaderInfo.uncaughtErrorEvents.addEventListener(UncaughtErrorEvent.UNCAUGHT_ERROR, onUncaughtError);
		#end

		// Since i left FNF, this is from Psych Engine because ye!
		addChild(new FlxGame(mainGame.width, mainGame.heigh, mainGame.initialMenu, mainGame.fps, mainGame.fps, mainGame.skipFlixelSplash));

		// Only Linux related thing
		#if linux
		var icon = Image.fromFile("icon.png");
		Lib.current.stage.window.setIcon(icon);
		#end

		fpsVar = new FramePerSecond();
		Lib.current.stage.align = "tl";
		Lib.current.stage.scaleMode = StageScaleMode.NO_SCALE;
		if (fpsVar != null) fpsVar.visible = true;
		addChild(fpsVar);

		var watermarkImage:String = ("assets/images/icon32_icon.png");
		if (FileSystem.exists(watermarkImage))
		{
			if (watermarkImage != null) removeChild(watermarkIcon);
		}

		watermarkIcon = new Watermark(5, Lib.current.stage.stageHeight - 5, 0.5);
		if (watermarkIcon != null) watermarkIcon.visible = true;
		addChild(watermarkIcon);

		#if DISCORD_ALLOWED
		DiscordClient.prepare();
		#end
	}

	function onUncaughtError(e:UncaughtErrorEvent):Void
	{
		e.preventDefault();
		e.stopImmediatePropagation();

		var path:String;
		var exception:String = 'Exception: ${e.error}\n';
		var stackTraceString = exception + StringTools.trim(CallStack.toString(CallStack.exceptionStack(true)));
		var dateNow:String = Date.now().toString().replace(" ", "_").replace("'", ":");

		path = 'crash/Sbinator - ${dateNow}.txt';

		#if sys
		if (!FileSystem.exists("crash/"))
			FileSystem.createDirectory("crash/");
		File.saveContent(path, '${stackTraceString}\n');
		#end

		var normalPath:String = Path.normalize(path);

		Sys.println(stackTraceString);
		Sys.println('Crash dump saved in $normalPath');

		// Requires because of latest Flixel!
		#if (flixel < "6.0.0")
		FlxG.bitmap.dumpCache();
		#end
		FlxG.bitmap.clearCache();

		#if (linux || mac) // For some unknown reason Application class failed to open pop-up window in Unix-based system, so using state class will help for bit!
		StateHandler.switchToNewState(new CrashHandlerState(stackTraceString + '\n\nCrash log created at: "${normalPath}"!'));
		#else
		Application.current.window.alert(stackTraceString, "\n\nPress OK to reset game!" + randomErrorMessages[FlxG.random.int(0, randomErrorMessages.length)], " - Sbinator v" + EngineConfiguration.gameVersion); // My friend cannot get state working on his Windows machine for some reason, so using base Application class for fix instead..
		FlxG.resetGame();
		#end
	}
}
