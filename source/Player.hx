package;

import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.util.FlxCollision;

class Player extends FlxSprite
{
	private static final MAX_SPEED:Int = 150;
	private static final ACCELERATION:Int = 350;
	private static final JUMP_SPEED:Int = -200;
	private static final DRAG:Int = 400;
	private static final GRAVITY:Int = 300;
	private static final FALL_SPEED:Int = 300;
	private static final SLIDE_SPEED:Int = 100;

	public var onWall:Bool = false;

	public function new(?x:Float = 0, ?y:Float = 0)
	{
		super(x, y);

		health = 3;
		drag.x = DRAG;
		acceleration.y = GRAVITY;
		maxVelocity.set(MAX_SPEED, FALL_SPEED);
		loadGraphics();
	}

	override public function update(elapsed:Float)
	{
		movement();
		animate();

		FlxG.collide(this, PlayState.walls);

		super.update(elapsed);
	}

	private function loadGraphics()
	{
		loadGraphic(AssetPaths.playerSheet__png, true, 40, 40);
		animation.add("idle", [0, 1], 1, false);
		animation.add("running", [2, 3, 4, 5, 6, 7, 8], 24, false);
	}

	private function movement()
	{
		acceleration.x = 0;

		if (FlxG.keys.anyPressed([LEFT, A]))
		{
			flipX = true;
			acceleration.x -= ACCELERATION;
		}
		else if (FlxG.keys.anyPressed([RIGHT, D]))
		{
			flipX = false;
			acceleration.x += ACCELERATION;
		}

		if (velocity.y == 0 && FlxG.keys.justPressed.SPACE)
		{
			if ((isTouching(FlxObject.FLOOR) || onWall))
			{
				if (FlxG.keys.pressed.SPACE)
				{
					velocity.y = JUMP_SPEED;
				}
				else
				{
					velocity.y = JUMP_SPEED / 2;
				}
			}
		}
		if (x < 0)
		{
			x = 0;
		}
	}

	private function animate()
	{
		if (velocity.x == 0 && velocity.y == 0)
		{
			animation.play("idle");
		}
		if (FlxG.keys.anyPressed([LEFT, RIGHT, A, D]) && isTouching(FlxObject.FLOOR))
		{
			animation.play("running");
		}
	}

	// private function wallJump(player:Player, walls:FlxTypedGroup<Wall>)
	// {
	// 	PlayState.walls.forEach(function(wall:Wall):Void
	// 	{
	// 		if (FlxCollision.pixelPerfectCheck(player, wall, 1))
	// 		{
	// 			onWall = true;
	// 			acceleration.y = SLIDE_SPEED;
	// 		}
	// 		else
	// 		{
	// 			onWall = false;
	// 			acceleration.y = GRAVITY;
	// 		}
	// 	});
	// }
}
