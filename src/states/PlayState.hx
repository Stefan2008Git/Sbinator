package states;

import flixel.FlxCamera;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.addons.display.FlxBackdrop;
import flixel.addons.effects.FlxTrail;
import flixel.group.FlxGroup;
import flixel.math.FlxMath;
import flixel.util.FlxCollision;
import flixel.util.FlxColor;

class PlayState extends MainBeat
{
    var bg:FlxBackdrop;
    var player:Player;
    var playerTrail:FlxTrail;
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
                    StateHandler.switchToNewState(new TitleScreen());
                }
            }
        ], false, true));

        cameraGame = new FlxCamera();
        FlxG.cameras.add(cameraGame);

        bg = new FlxBackdrop("assets/images/game/in-game/skybox.png");
        add(bg);

        player = new Player();
        add(player);

        playerTrail = new FlxTrail(player, 6, 0, 0.4, 0.02);
        add(playerTrail);

        FlxG.camera.setScrollBoundsRect(0, 0, true);
        FlxG.camera.follow(player, FlxCameraFollowStyle.LOCKON);
        levelBound = FlxCollision.createCameraWall(cameraGame, false, 1);
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
