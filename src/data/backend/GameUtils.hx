package data.backend;

import flixel.graphics.FlxGraphic;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.util.FlxColor;
import openfl.utils.Assets;

using StringTools;

class EngineConfiguration
{
    public static var gameVersion:String = "1.0.0";



    // Path system is unfinished currently!!!!
    /*public static function getPathFolder(pathKey:String, ?library:String):String
    {
		var pathArray:Array<String> = pathKey.split("/").copy();
		var loopCount = 0;
		pathKey = "";

		for (folder in pathArray)
		{
			var truFolder:String = folder;

			if(folder.startsWith("_"))
				truFolder = folder.substr(1);

			loopCount++;
			pathKey += truFolder + (loopCount == pathArray.length ? "" : "/");
		}

		if(library != null) library = (library.startsWith("_") ? library.split("_")[1] : library);
		if(library == null) return 'assets/$pathKey'; else return 'assets/$library/$pathKey';
	}

    public static function newBitmap(file:String, ?BitmapData = null)
    {
        bitmap = Assets.getBitmapData(file);

        var newGraphicBitmap:FlxGraphic = new FlxGraphic.fromBitmapData(file);
        newGraphicBitmap.persist = true;
        newGraphicBitmap.destroyOnUse = false;
        return newGraphicBitmap;
    }

    inline static public function image(imageFile:String, ?bitmapImage:BitmapData = null)
    {
        bitmapImage = Assets.getBitmapData(getPathFolder('assets/'+imageFile+'.png'));

        var newBitImage = newBitmap(getPathFolder('assets/'+file+'.png'), bitmap);
        return newBitImage;
    }

    inline static public function getSparrowAtlas(atlasFile:String, ?bitmapAtlas:BitmapData = null)
    {
        var atlasImage = image(file);
        return FlxAtlasFrames.fromSparrow(atlasImage.getPathFolder('assets/'+atlasFile+'.xml'));
    }

    public static function font(fontKey:String, ?fontLibrary:String):String
    {
        return getPath('fonts/$fontKey', fontLibrary);
    }*/

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