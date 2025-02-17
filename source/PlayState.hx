package;

import flixel.FlxCamera;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.group.FlxGroup;
import flixel.math.FlxMath;
import flixel.util.FlxCollision;
import flixel.util.FlxColor;

class PlayState extends FlxState
{
    var bg:FlxSprite;
    var player:Player;
    var levelBound:FlxGroup;
    public var cameraGame:FlxCamera;

    override public function create()
    {
        super.create();

        #if DISCORD_ALLOWED
		// Updating Discord Rich Presence
		DiscordClient.changePresence("In Game", null);
		#end

        openSubState(new PopUpEvent("Unfinished menu", "This menu is currently in work-in-progress, but you can test it!", [
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

        cameraGame = new FlxCamera();
        FlxG.cameras.add(cameraGame);

        bgColor = FlxColor.GREEN;

        player = new Player();
        add(player);

        levelBound = FlxCollision.createCameraWall(FlxG.camera, true, 1);
    }

    override public function update(elapsed:Float)
    {
        final justPressed = FlxG.keys.justPressed;

		FlxG.collide(player, levelBound);

		if (player.isTouching(DOWN) && justPressed.SPACE)
		{
            player.velocity.y = -180;
            FlxG.sound.play("assets/sounds/jump.ogg");
        }

		if (justPressed.ESCAPE) openSubState(new PauseMenu());

        super.update(elapsed);
    }
}
