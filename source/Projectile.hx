package;

import PlayState;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.math.FlxAngle;
import flixel.math.FlxPoint;
import flixel.tweens.FlxTween;

class Projectile extends FlxSprite
{
	private static final SPEED:Int = 400;

	public function new(?x:Float = 0, ?y:Float = 0, target:FlxPoint)
	{
		super(x + 20, y + 20);
		loadGraphic(AssetPaths.projectile__png);

		velocity.x = SPEED;
		velocity.rotate(FlxPoint.weak(0, 0), FlxAngle.angleBetweenPoint(this, target, true));
	}

	override public function update(elapsed:Float)
	{
		FlxG.collide(this, PlayState.walls, death);

		super.update(elapsed);
	}

	public function death(proj:Projectile, walls:FlxTypedGroup<Wall>)
	{
		kill();
	}
}
