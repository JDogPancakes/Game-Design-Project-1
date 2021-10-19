package;

import PlayState;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.math.FlxAngle;
import flixel.math.FlxPoint;
import flixel.system.FlxSound;
import flixel.tweens.FlxTween;

class Projectile extends FlxSprite
{
	private static final SPEED:Int = 400;

	var liveSound:FlxSound;

	public function new(?x:Float = 0, ?y:Float = 0, target:FlxPoint)
	{
		super(x + 20, y + 20);
		liveSound = FlxG.sound.load(AssetPaths.liveLost__wav);
		loadGraphics();
		velocity.x = SPEED;
		velocity.rotate(FlxPoint.weak(0, 0), FlxAngle.angleBetweenPoint(this, target, true));
	}

	override public function update(elapsed:Float)
	{
		FlxG.collide(this, PlayState.walls, death);
		FlxG.collide(this, PlayState.boss, damageBoss);

		super.update(elapsed);
	}

	public function death(proj:Projectile, walls:FlxTypedGroup<Wall>)
	{
		kill();
	}

	public function damageBoss(proj:Projectile, boss:Boss)
	{
		proj.kill();
		boss.takeDamage(1);
		liveSound.play();
	}

	private function loadGraphics()
	{
		loadGraphic(AssetPaths.projectileSheet__png, true, 16, 16);
		animation.add("spinning", [0, 1], 24, true);
		animation.play("spinning");
	}
}
