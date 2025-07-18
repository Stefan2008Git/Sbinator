package data.backend;

import flixel.graphics.FlxGraphic;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.system.FlxAssets;
import flixel.util.FlxColor;
import openfl.display.BitmapData;
import openfl.media.Sound;
import openfl.utils.Assets;

#if sys
import sys.FileSystem;
import sys.io.File;
#end

using StringTools;

@:keep
@:access(BitmapData)
class EngineConfiguration
{   
    // Game version
    public static var gameVersion:String = "1.0.0";

    inline public static function colorFromString(color:String):FlxColor
	{
		var hideCharacters = ~/[\t\n\r]/;
		var color:String = hideCharacters.split(color).join('').trim();
		if(color.startsWith('0x')) color = color.substring(color.length - 6);

		var colorNum:Null<FlxColor> = FlxColor.fromString(color);
		if(colorNum == null) colorNum = FlxColor.fromString('#$color');
		return colorNum != null ? colorNum : FlxColor.WHITE;
	}
}

class Paths
{   
    // Paths system
    inline public static final ROOT_FOLDER:String = "assets";
    public static var EXISTING_SOUND:Array<String> = ['.ogg', '.wav'];
    public static var currentTrackedAssets:Map<String, FlxGraphic> = [];
    public static var currentTrackedSounds:Map<String, Sound> = [];
    public static var currentTrackedLocalAssets:Array<String> = [];

    static public function getCurrentPath(folder:Null<String>, file:String)
    {
        if (folder == null) folder = ROOT_FOLDER;
        return folder + '/' + file;
    }

    static public function file(file:String, folder:String = ROOT_FOLDER)
    {
        if (#if sys FileSystem.exists(folder) && #end (folder != null && folder != ROOT_FOLDER)) return getCurrentPath(folder, file);
        return getCurrentPath(null, file);
    }

    inline static public function dataPath(key:String) 
        return file('data/$key');

    inline static public function soundPath(key:String, ?cache:Bool = true):Sound 
        return returnCurrentSound('sounds/$key', cache);

    inline static public function musicPath(key:String, ?cache:Bool = true):Sound 
        return returnCurrentSound('music/$key', cache);

    inline static public function imagePath(key:String, ?cache:Bool = true):FlxGraphic 
        return returnCurrentSprite('images/$key', cache);

    inline static public function fontPath(key:String)
        return file('fonts/$key');

    public static function returnCurrentSprite(key:String, ?cache:Bool = true):FlxGraphic
    {
        var spritePath:String = file('$key.png');
        if (Assets.exists(spritePath, IMAGE))
        {
            if (!currentTrackedAssets.exists(spritePath))
            {
                var spriteGraphic:FlxGraphic = FlxGraphic.fromBitmapData(Assets.getBitmapData(spritePath), false, spritePath, cache);
                spriteGraphic.persist = true;
                currentTrackedAssets.set(spritePath, spriteGraphic);
            }

            currentTrackedLocalAssets.push(spritePath);
            return currentTrackedAssets.get(spritePath);
        }

        // trace(spritePath);

        trace('Missing $key sprite from "images" folder of root direcotry! Attempting to do not crash the game..');
        return null;
    }

    public static function returnCurrentSound(key:String, ?cacheSound:Bool = true, ?beepNoSound:Bool = true):Sound
    {
        for (i in EXISTING_SOUND)
        {   
            // trace(file(key + i));
            if (Assets.exists(file(key + i), SOUND))
            {
                var soundPath:String = file(key + i);
                if (!currentTrackedSounds.exists(soundPath)) currentTrackedSounds.set(soundPath, Assets.getSound(soundPath, cacheSound));

                currentTrackedLocalAssets.push(soundPath);
                return currentTrackedSounds.get(soundPath);
            } 
            else if (beepNoSound)
            {
                trace('Missing $key sound from "sounds" folder of root direcotry! Playing default Flixel beep sound instead..');
                return FlxAssets.getSound("flixel/sounds/beep");
            }
        }

        trace('Missing $key sound from "sounds" folder of root direcotry! Playing default Flixel beep sound instead..');
        return null;
    }
}