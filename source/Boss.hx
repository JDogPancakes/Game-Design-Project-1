package;

import flixel.FlxG;
import flixel.FlxSprite;

class Boss extends FlxSprite
{
	public var attacks:Array<Int>;

	public function new(?x:Float = 0, ?y:Float = 0)
	{
		super(x, y);
		health = 100;

		loadGraphics();
		loadAttacks();
		playAttacks();
	}

	override public function update(elapsed:Float) {}

	public function loadGraphics()
	{
		loadGraphic(AssetPaths.Slime_Boss_4__png, true, 170, 150);
		animation.add("forward", ([0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13]), 12);
		animation.add("down", ([0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 15, 16, 17, 18, 19, 20, 21]), 12);
		animation.add("up", ([22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32, 33]), 12);
		animation.add("reverseForwardDown", ([13, 12, 11, 10, 9, 8, 7, 6, 5, 4, 3, 2, 1, 0]), 12);
		animation.add("reverseUp", ([33, 32, 31, 30, 29, 28, 27, 26, 25, 24, 23, 22]), 12);
	}

	public function loadAttacks()
	{
		attacks = new Array();
		for (x in 1...100)
		{
			var randNum = FlxG.random.int(1, 3);
			attacks.push(randNum);
		}
	}

	public function playAttacks() {}

	public function upAttack() {}

	public function forwardAttack() {}

	public function downAttack() {}
}
