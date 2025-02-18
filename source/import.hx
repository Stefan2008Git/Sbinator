#if (!macro)

// Important
import data.Player;
import data.Discord.DiscordClient;
import data.PopUp.PopUpEvent;
import data.AssetPaths;
import data.backend.FramePerSecond;
import data.backend.Memory;
import data.backend.CrashHander.Crash;

// States
import states.PlayState;
import states.InitState;
import states.menus.CreditsMenu;
import states.menus.CreditsMenu.CreditsMeta;
import states.menus.PauseMenu;
import states.menus.TitleScreen;

// Other
#if sys
import sys.*;
import sys.io.*;
#elseif js
import js.html.*;
#end
#end
