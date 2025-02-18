package data;

import flixel.FlxG;
import flixel.FlxSprite;

class Player extends FlxSprite
{
    final speedValue:Int = 180;
    final gravityValue:Int = 280;

    public function new (xPosition:Int = 0, yPosition:Int = 0)
    {
        super(xPosition, yPosition, "assets/images/game/in-game/stefan2008.png");
        drag.x = speedValue + 8;

        acceleration.y = gravityValue;
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
            velocity.x = 0;
        }
        else if (left)
        {
            velocity.x = -speedValue / 2.8;
            facing = LEFT;
            setFacingFlip(RIGHT, true, false);
        }
        else if (right)
        {
            velocity.x = speedValue / 2.8;
            facing = RIGHT;
            setFacingFlip(LEFT, false, false);
        }

        // Sprinting function
        if (shift && left)
        {
            velocity.x = -speedValue;
            facing = LEFT;
            setFacingFlip(RIGHT, true, false);
        }
        else if (shift && right)
        {
            velocity.x = speedValue;
            facing = RIGHT;
            setFacingFlip(LEFT, false, false);
        }
    }
}
