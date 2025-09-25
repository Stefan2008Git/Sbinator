echo Hello and welcome to our setup game script. This is not gonna take a while to finish setuping depending on your internet speed
sleep 5
echo Making Haxelib directory on home folder and setuping it
mkdir ~/.local/share/haxelib && haxelib setup ~/.local/share/haxelib
sleep 2
echo Downloading and installing all required libraries for compiling our game "(Note that this will depend on your internet speed once again)"..
haxelib install flixel
haxelib install flixel-addons
haxelib install flixel-ui
haxelib install lime
haxelib install lime-samples
haxelib install openfl
haxelib install hxcpp
haxelib install hxdiscord_rpc
sleep 2
echo All required libraries for Haxelib are downloaded and installed successfully. Setuping Lime for better compiling instead using haxelib run every time..
haxelib run lime setup
sleep 1
echo Setup is done. You can check library list here
haxelib list
