package states.game;

import flixel.FlxCamera;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.addons.effects.FlxTrail;
import flixel.group.FlxGroup;
import flixel.group.FlxSpriteGroup;
import flixel.math.FlxMath;
import flixel.text.FlxText;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.ui.FlxBar;
import flixel.util.FlxCollision;
import flixel.util.FlxColor;
import flixel.util.FlxSpriteUtil;

class PlayState extends StateHandler
{
    // In-game stuff
    var bg:FlxSprite;
    var bg2:FlxSprite;
    public var player:Player;
    public var playerTrail:FlxTrail;
    var bar:FlxSprite;
    var icon:FlxSprite;
    var scoreText:FlxText;
    public var testScore:Int = 0;
    var healthBarSprite:FlxSprite;
    var healthBar:FlxBar;
    var health:Float = 1;
    var maxHealth:Float = 2;

    // Backend
    var levelBound:FlxGroup;
    public var cameraGame:FlxCamera;
    public var gameGroup:FlxSpriteGroup;
    public var cameraUi:FlxCamera;
    public var uiGameGroup:FlxSpriteGroup;
    static public var mainInstance:PlayState;
    var cameraMode:FlxCameraFollowStyle = FlxCameraFollowStyle.TOPDOWN_TIGHT;
    var cameraZoomingDecay:Float = 1;
    var defaultCameraZoom:Float = 1.05;

    override public function create()
    {   
        // Required for Player class file to call for player trail
        mainInstance = this;

        #if DISCORD_ALLOWED
		// Updating Discord Rich Presence
		DiscordClient.changePresence("In Game", null);
		#end
        
        // Camera related stuff
        cameraGame = new FlxCamera();
        FlxG.cameras.add(cameraGame, false);
        gameGroup = new FlxSpriteGroup();
        add(gameGroup);
        cameraGame.bgColor.alpha = 0;

        // In-game UI related stuff
        cameraUi = new FlxCamera();
        FlxG.cameras.add(cameraUi, false);
        uiGameGroup = new FlxSpriteGroup();
        add(uiGameGroup);
        cameraUi.bgColor.alpha = 0;

        bg = new FlxSprite(Paths.imagePath("game/in-game/world/skybox"));
        bg.screenCenter();
        gameGroup.add(bg);

        bg2 = new FlxSprite(Paths.imagePath("game/in-game/world/grass"));
        bg2.screenCenter(X);
        gameGroup.add(bg2);

        player = new Player(5, 70, 0.8, 0.8);
        player.updateHitbox();
        gameGroup.add(player);

        playerTrail = new FlxTrail(player, 6, 0, 0.4, 0.02);
        playerTrail.visible = false;
        gameGroup.add(playerTrail);

        bar = FlxSpriteUtil.drawRoundRect(new FlxSprite(80, 645).makeGraphic(400, 40, FlxColor.TRANSPARENT), 0, 0, 200, 40, 10, 10, FlxColor.BLACK);
        bar.alpha = 0.6;
        bar.updateHitbox();
        uiGameGroup.add(bar);

        scoreText = new FlxText(150, bar.y + 5, FlxG.width, "", 12);
        scoreText.setFormat(Paths.fontPath("bahnschrift.ttf"), 20, FlxColor.WHITE, FlxTextAlign.LEFT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
        scoreText.borderSize = 2;
        scoreText.borderQuality = 2;
        scoreText.text = "Score: 0";
        uiGameGroup.add(scoreText);

        icon = new FlxSprite(15, bar.y + -45).loadGraphic(Paths.imagePath("game/in-game/icon-stefan"));
        icon.scale.set(0.4, 0.4);
        icon.updateHitbox();
        uiGameGroup.add(icon);

        healthBarSprite = new FlxSprite(0, FlxG.height * 0.9).loadGraphic(Paths.imagePath("game/in-game/health"));
        healthBarSprite.scrollFactor.set();
        healthBarSprite.scale.set(0.8, 0.8);
        healthBarSprite.updateHitbox();
        healthBarSprite.screenCenter(X);
        uiGameGroup.add(healthBarSprite);

        healthBar = new FlxBar(healthBarSprite.x + 4, healthBarSprite.y + 4, LEFT_TO_RIGHT, Std.int(healthBarSprite.width - 8), Std.int(healthBarSprite.height - 8), this, 'health', 0, maxHealth);
        healthBar.createFilledBar(FlxColor.RED, FlxColor.GREEN);
        healthBar.screenCenter(X);
        uiGameGroup.add(healthBar);

        FlxG.camera.setScrollBoundsRect(0, 0, true);
        FlxG.camera.follow(player, cameraMode);
        FlxG.camera.zoom = defaultCameraZoom;

        // Without this, the player will fall from camera wall, so keeping this for now
        levelBound = FlxCollision.createCameraWall(cameraGame, true, 1);

        gameGroup.cameras = [cameraGame];
        uiGameGroup.cameras = [cameraUi];

        super.create();
    }

    override public function update(elapsed:Float)
    {
        final justPressed = FlxG.keys.justPressed;

		FlxG.collide(player, levelBound);
		FlxG.camera.follow(player, cameraMode);

		if (justPressed.ESCAPE) pauseTheGame();

        if (justPressed.X) health -= 1 else if (justPressed.P) health += 1;
        if (health <= 0) gameOver();

		scoreText.text = "Score: " + testScore;

        FlxG.camera.zoom = FlxMath.lerp(defaultCameraZoom, FlxG.camera.zoom, Math.exp(-elapsed * 3.125 * cameraZoomingDecay));
		cameraGame.zoom = FlxMath.lerp(1, cameraGame.zoom, Math.exp(-elapsed * 3.125 * cameraZoomingDecay));

        super.update(elapsed);
    }

    function pauseTheGame()
    {
        FlxG.camera.followLerp = 0;
		persistentUpdate = false;
		persistentDraw = true;

        openSubState(new PauseMenu());
    }

    function gameOver()
    {   
        FlxG.camera.followLerp = 0;
        persistentUpdate = false;
		persistentDraw = true;

        openSubState(new GameOver());
    }
}
