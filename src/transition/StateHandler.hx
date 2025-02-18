package transition;

import flixel.FlxG;
import flixel.FlxState;
import flixel.util.typeLimit.NextState;

class StateHandler extends FlxState
{
    public static var activeState:FlxState;
    public static function switchToNewState(?target:NextState):Void
    {
        var trans = new Transition(false);
        trans.callbackFinished = function()
        {
            if(target != null) FlxG.switchState(target); else FlxG.resetState();
        };
    
        if(activeState != null) activeState.openSubState(trans);
    }
}