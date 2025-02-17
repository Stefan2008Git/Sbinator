package;

import flixel.FlxGame;
import openfl.Lib;
import openfl.display.Sprite;
import openfl.display.StageScaleMode;

#if linux
import lime.graphics.Image;
#end

class Main extends Sprite
{
	var game = {
		width: 1280,
		heigh: 720,
		initialMenu: InitState,
		fps: 60,
		skipFlixelSplash: true
	};

	public static var fpsVar:FramePerSecond;

	public function new()
	{
		super();

		// Since i left FNF, this is from Psych Engine because ye!
		addChild(new FlxGame(game.width, game.heigh, game.initialMenu, game.fps, game.fps, game.skipFlixelSplash));

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

		#if DISCORD_ALLOWED
		DiscordClient.prepare();
		#end
	}
}
