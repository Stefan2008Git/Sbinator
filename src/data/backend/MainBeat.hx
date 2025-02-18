package data.backend;

import flixel.FlxG;
import flixel.addons.ui.FlxUIState;

class MainBeat extends FlxUIState
{
    override public function create()
    {
        super.create();
        openSubState(new Transition(true));
    }
}
