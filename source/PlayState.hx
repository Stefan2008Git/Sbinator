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

		if (justPressed.U) setLerp(.1);
		if (justPressed.J) setLerp(-.1);

		if (justPressed.I) setLead(.5);
		if (justPressed.K) setLead(-.5);

		if (justPressed.O) setZoom(.1);
		if (justPressed.L) setZoom(-.1);

		if (justPressed.M) FlxG.camera.shake();

		FlxG.collide(player, levelBound);

		if (player.isTouching(DOWN) && justPressed.SPACE) player.velocity.y = -300;

		if (justPressed.ESCAPE) openSubState(new PauseMenu());

        super.update(elapsed);
    }

    public function setZoom(delta:Float)
	{
		final newZoom = FlxG.camera.zoom + delta;
		FlxG.camera.zoom = FlxMath.bound(Math.round(newZoom * 10) / 10, 0.5, 4);
	}

	function setLead(delta:Float)
	{
		var cam = FlxG.camera;
		cam.followLead.x += delta;
		cam.followLead.y += delta;

		if (cam.followLead.x < 0)
		{
			cam.followLead.x = 0;
			cam.followLead.y = 0;
		}
	}

	function setLerp(delta:Float)
	{
		var cam = FlxG.camera;
		cam.followLerp += delta;
		cam.followLerp = Math.round(10 * cam.followLerp) / 10; // adding or subtracting .1 causes roundoff errors
	}
}
