package data;

import flixel.FlxG;
import flixel.FlxSprite;

class Player extends FlxSprite
{
    final speedValue:Int = 180;
    final gravityValue:Int = 280;

    public function new (xPosition:Int = 0, yPosition:Int = 0, scaleX:Float = 0, scaleY:Float = 0)
    {
        super(xPosition, yPosition, "assets/images/game/in-game/stefan.png");
        drag.x = speedValue + 8;

        acceleration.y = gravityValue;

        this.scale.x = scaleX;
        this.scale.y = scaleY;
    }

    override function update(elapsed:Float)
    {
        playerMovement();
        super.update(elapsed);
    }

    private function playerMovement()
    {
        final left = FlxG.keys.anyPressed([LEFT, A]);
        final right = FlxG.keys.anyPressed([RIGHT, D]);
        final shift = FlxG.keys.anyPressed([SHIFT]);

        // Walking function
        if (left && right)
        {
            PlayState.mainInstance.playerTrail.visible = false;
            velocity.x = 0;
        }
        else if (left)
        {
            PlayState.mainInstance.playerTrail.visible = false;
            velocity.x = -speedValue / 1.7;
            facing = LEFT;
            setFacingFlip(RIGHT, true, false);
        }
        else if (right)
        {
            PlayState.mainInstance.playerTrail.visible = false;
            velocity.x = speedValue / 1.7;
            facing = RIGHT;
            setFacingFlip(LEFT, false, false);
        }

        // Sprinting function
        if (shift && left && right)
        {
            velocity.x = 0;
            PlayState.mainInstance.playerTrail.visible = false;
        }
        else if (shift && left)
        {
            velocity.x = -speedValue;
            facing = LEFT;
            setFacingFlip(RIGHT, true, false);
            PlayState.mainInstance.playerTrail.visible = true;
        }
        else if (shift && right)
        {
            velocity.x = speedValue;
            facing = RIGHT;
            setFacingFlip(LEFT, false, false);
            PlayState.mainInstance.playerTrail.visible = true;
        }
    }
}
