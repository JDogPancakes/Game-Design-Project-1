package;

import EnemyProjectile;
import PlayState;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.math.FlxPoint;

class Boss extends FlxSprite
{
	public function new(?x:Float = 0, ?y:Float = 0)
	{
		super(x, y);
		health = 500;
		solid = true;
		immovable = true;

		loadGraphics();
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);
	}

	public function loadGraphics()
	{
		loadGraphic(AssetPaths.Slime_Boss_4__png, true, 170, 150);
		animation.add("forward", [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13], 7, false);
		animation.add("down", [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 15, 16, 17, 18, 19, 20, 21], 12, false);
		animation.add("up", [22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32, 33], 12, false);
		animation.add("reverseForwardDown", [13, 12, 11, 10, 9, 8, 7, 6, 5, 4, 3, 2, 1, 0], 12, false);
		animation.add("reverseUp", [33, 32, 31, 30, 29, 28, 27, 26, 25, 24, 23, 22], 12, false);
	}

	public function takeDamage(amount:Int)
	{
		health -= amount;
	}
}
