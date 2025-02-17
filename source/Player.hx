package;

import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;

class Player extends FlxSprite
{
    final speedValue:Int = 280;
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

        if (left && right)
        {
            velocity.x = 0;
        }
        else if (left)
        {
            velocity.x = -speedValue;
        }
        else if (right)
        {
            velocity.x = speedValue;
        }

        if (shift && left && right)
        {
            velocity.x = speedValue / 2.8;
        }
    }
}
