package;

import PlayState;
import flixel.FlxSprite;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;

class Platform extends FlxSprite
{
	public var timer:flixel.util.FlxTimer;

	public function new(?x:Float = 0, ?y:Float = 0)
	{
		super(x, y);
		loadGraphic(AssetPaths.platform__png, true, 96, 16);
		animation.add("crumble", ([0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11]), 4, false);

		solid = true;
		immovable = true;

		PlayState.platformAlive = true;
		animation.play("crumble");
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);
		platformLife();
	}

	public function platformLife()
	{
		if (animation.finished)
		{
			onTimer();
		}
	}

	public function onTimer()
	{
		this.kill();
		PlayState.platformAlive = false;
	}
}
