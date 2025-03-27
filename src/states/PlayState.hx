package states;

import flixel.FlxCamera;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.addons.effects.FlxTrail;
import flixel.group.FlxGroup;
import flixel.group.FlxSpriteGroup;
import flixel.math.FlxMath;
import flixel.util.FlxCollision;
import flixel.util.FlxColor;

class PlayState extends StateHandler
{
    var bg:FlxSprite;
    var bg2:FlxSprite;
    public var player:Player;
    public var playerTrail:FlxTrail;
    var levelBound:FlxGroup;
    public var cameraGame:FlxCamera;
    public var gameUiGroup:FlxSpriteGroup;
    static public var mainInstance:PlayState;
    var cameraMode:FlxCameraFollowStyle = FlxCameraFollowStyle.TOPDOWN_TIGHT;

    override public function create()
    {
        // SRequired for Player class file to call for player trail
        mainInstance = this;

        #if DISCORD_ALLOWED
		// Updating Discord Rich Presence
		DiscordClient.changePresence("In Game", null);
		#end

        cameraGame = new FlxCamera();
        FlxG.cameras.add(cameraGame);

        gameUiGroup = new FlxSpriteGroup();
        add(gameUiGroup);

        bg = new FlxSprite("assets/images/game/in-game/world/skybox.png");
        bg.screenCenter();
        gameUiGroup.add(bg);

        bg2 = new FlxSprite("assets/images/game/in-game/world/grass.png");
        bg2.screenCenter(X);
        gameUiGroup.add(bg2);

        player = new Player(5, 70, 1, 1);
        add(player);

        playerTrail = new FlxTrail(player, 6, 0, 0.4, 0.02);
        playerTrail.visible = false;
        add(playerTrail);

        // FlxG.camera.setScrollBoundsRect(0, 0, true);
        FlxG.camera.follow(player, cameraMode);

        // Without this, the player will fall from camera wall, so keeping this for now
        levelBound = FlxCollision.createCameraWall(cameraGame, false, 1);

        gameUiGroup.cameras = [cameraGame];

        super.create();
    }

    override public function update(elapsed:Float)
    {
        final justPressed = FlxG.keys.justPressed;

		FlxG.collide(player, levelBound);
		FlxG.camera.follow(player, cameraMode);

		if (player.isTouching(DOWN) && justPressed.SPACE)
		{
            player.velocity.y = -180;
            FlxG.sound.play("assets/sounds/jump.ogg");
        }

		if (justPressed.ESCAPE) openSubState(new PauseMenu());

		if (justPressed.R) openSubState(new GameOver());

        super.update(elapsed);
    }
}
