#if (!macro)

// Important
import data.Discord.DiscordClient;
import data.Player;
import data.PopUp.PopUpEvent;
import data.backend.GameUtils.ControlsHandler;
import data.backend.GameUtils.EngineConfiguration;
import data.backend.GameUtils.DataHandler;
import data.backend.GameUtils.Paths;
import data.backend.FramePerSecond;
import data.backend.HiddenProcess;
import transition.Transition;
import transition.StateHandler;
import transition.SubstateHandler;

// States
import states.InitState;
import states.game.PlayState;
import states.menus.CreditsMenu;
import states.menus.TitleScreen;
import states.modules.CrashHandlerState;

// Submenus
import substates.game.GameOver;
import substates.game.PauseMenu;
import substates.options.OptionsMenu;

// Other
#if sys
import sys.*;
import sys.io.*;
#elseif js
import js.html.*;
#end
#end
