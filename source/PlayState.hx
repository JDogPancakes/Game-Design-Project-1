package;

import Platform;
import Player;
import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.group.FlxGroup.FlxTypedGroup;

class PlayState extends FlxState
{
	public var player:FlxSprite;
	public var boss:FlxSprite;
	public var platform:FlxSprite;
	public var floor:FlxObject;
	public var wall:Wall;

	public static var walls:FlxTypedGroup<Wall>;
	public static var platformAlive:Bool;

	override public function create()
	{
		player = new Player(0, FlxG.height - 41);
		boss = new Boss(FlxG.width - 170, FlxG.height - 150);
		platformAlive = false;
		walls = new FlxTypedGroup<Wall>();

		createMap();

		add(player);
		add(boss);
		add(walls);
		add(floor);

		super.create();
	}

	override public function update(elapsed:Float)
	{
		FlxG.collide(floor, player);
		FlxG.collide(platform, player);

		platformCreation();
		shoot();

		if (FlxG.keys.justPressed.ENTER)
			FlxG.fullscreen = !FlxG.fullscreen;

		super.update(elapsed);
	}

	public function platformCreation()
	{
		if (FlxG.mouse.justPressedRight && !platformAlive)
		{
			platform = new Platform(FlxG.mouse.x - 48, FlxG.mouse.y - 10);
			add(platform);
		}
	}

	public function shoot()
	{
		if (FlxG.mouse.justPressed)
		{
			var mousePos = FlxG.mouse.getPosition();
			add(new Projectile(player.x, player.y, mousePos));
		}
	}

	public function createMap()
	{
		floor = new FlxObject(0, FlxG.height, FlxG.width, 1);
		floor.immovable = true;
		floor.solid = true;
		for (x in 1...4)
		{
			var wallX = FlxG.random.int(20, FlxG.width - 200);
			var wallY = FlxG.random.int(20, FlxG.height - 50);
			var wall = new Wall(wallX, wallY);
			walls.add(wall);
		}
	}
}
