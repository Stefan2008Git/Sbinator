#if (!macro)

// Important
import data.AssetPaths;
import data.Discord.DiscordClient;
import data.Player;
import data.PopUp.PopUpEvent;
import data.backend.GameUtils.EngineConfiguration;
import data.backend.FramePerSecond;
import data.backend.HiddenProcess;
import data.backend.Memory;
import transition.Transition;
import transition.StateHandler;

// States
import states.PlayState;
import states.InitState;
import states.menus.CreditsMenu;
import states.menus.PauseMenu;
import states.menus.TitleScreen;
import states.modules.CrashHandlerState;
import states.submenus.GameOver;

// Other
#if sys
import sys.*;
import sys.io.*;
#elseif js
import js.html.*;
#end
#end
