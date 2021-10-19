package;

import flixel.FlxSprite;
import flixel.math.FlxAngle;
import flixel.math.FlxPoint;

enum ProjType
{
	UP;
	FORWARD;
	DOWN;
}

class EnemyProjectile extends FlxSprite
{
	public function new(?x:Float = 0, ?y:Float = 0, type:ProjType, target:FlxPoint)
	{
		super(x, y);
		switch type
		{
			case UP:
				velocity.y = 200;
			case FORWARD:
				loadGraphic(AssetPaths.forwardBullet__png);
				velocity.x = 100;
				velocity.rotate(FlxPoint.weak(0, 0), FlxAngle.angleBetweenPoint(this, target, true));
			case DOWN:
				loadGraphic(AssetPaths.groundAttackSheet__png, true, 32, 32);
				animation.add("moving", [0, 1, 2, 3, 4], 4, false);
				animation.play("moving");
				velocity.x = -200;
		}
	}
}
