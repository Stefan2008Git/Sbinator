package states;

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
    var testScoreTxt:FlxText;
    public var testScore:Int = 0;
    var healthBarSprite:FlxSprite;
    var healthBar:FlxBar;
    var health:Float = 1;
    var maxHealth:Float = 2;

    // Backend
    var levelBound:FlxGroup;
    public var cameraGame:FlxCamera;
    public var gameUiGroup:FlxSpriteGroup;
    static public var mainInstance:PlayState;
    var cameraMode:FlxCameraFollowStyle = FlxCameraFollowStyle.TOPDOWN_TIGHT;

    override public function create()
    {
        // Required for Player class file to call for player trail
        mainInstance = this;

        #if DISCORD_ALLOWED
		// Updating Discord Rich Presence
		DiscordClient.changePresence("In Game", null);
		#end

        cameraGame = new FlxCamera();
        FlxG.cameras.add(cameraGame);

        gameUiGroup = new FlxSpriteGroup();
        add(gameUiGroup);

        bg = new FlxSprite(Paths.imagePath("game/in-game/world/skybox"));
        bg.screenCenter();
        gameUiGroup.add(bg);

        bg2 = new FlxSprite(Paths.imagePath("game/in-game/world/grass"));
        bg2.screenCenter(X);
        gameUiGroup.add(bg2);

        player = new Player(5, 70, 1, 1);
        player.updateHitbox();
        gameUiGroup.add(player);

        playerTrail = new FlxTrail(player, 6, 0, 0.4, 0.02);
        playerTrail.visible = false;
        add(playerTrail);

        bar = FlxSpriteUtil.drawRoundRect(new FlxSprite(80, 700).makeGraphic(400, 40, FlxColor.TRANSPARENT), 0, 0, 200, 40, 10, 10, FlxColor.BLACK);
        bar.alpha = 0.6;
        bar.updateHitbox();
        add(bar);

        testScoreTxt = new FlxText(150, bar.y + 1, FlxG.width, "", 12);
        testScoreTxt.setFormat(Paths.fontPath("bahnschrift.ttf"), 20, FlxColor.WHITE, FlxTextAlign.LEFT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
        testScoreTxt.borderSize = 2;
        testScoreTxt.borderQuality = 2;
        testScoreTxt.text = "Score: 0";
        add(testScoreTxt);

        icon = new FlxSprite(15, bar.y).loadGraphic(Paths.imagePath("game/in-game/icon-stefan"));
        icon.scale.set(0.4, 0.4);
        icon.updateHitbox();
        add(icon);

        healthBarSprite = new FlxSprite(0, FlxG.height * 0.9).loadGraphic(Paths.imagePath("game/in-game/health"));
        healthBarSprite.scrollFactor.set();
        healthBarSprite.scale.set(0.8, 0.8);
        healthBarSprite.updateHitbox();
        healthBarSprite.screenCenter(X);
        add(healthBarSprite);

        healthBar = new FlxBar(healthBarSprite.x + 4, healthBarSprite.y + 4, LEFT_TO_RIGHT, Std.int(healthBarSprite.width - 8), Std.int(healthBarSprite.height - 8), this, 'health', 0, maxHealth);
        healthBar.createFilledBar(FlxColor.RED, FlxColor.GREEN);
        add(healthBar);

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

		if (justPressed.ESCAPE) openSubState(new PauseMenu());

        if (justPressed.X) health -= 1 else if (justPressed.P) health += 1;
        if (health <= 0) openSubState(new GameOver());

		testScoreTxt.text = "Score: " + testScore;

        super.update(elapsed);
    }

    override function beatTheHit()
    {
        FlxTween.tween(cameraGame, {zoom: 1.05}, 0.3, {ease: FlxEase.quadOut, type: BACKWARD});
        super.beatTheHit();
    }
}
