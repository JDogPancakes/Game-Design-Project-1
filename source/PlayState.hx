package;

import Platform;
import Player;
import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.math.FlxPoint;
import flixel.ui.FlxBar;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;

class PlayState extends FlxState
{
	public static var player:FlxSprite;

	public static var boss:FlxSprite;

	public static var platform:FlxSprite;

	public var floor:FlxObject;
	public var wall:Wall;

	public var attacks:Array<Int>;
	public var projectile:EnemyProjectile;
	public var target:FlxPoint;
	public var currentAttack:Int;
	public var healthBarBoss:FlxBar;
	public var healthBarPlayer:FlxBar;
	public var background:FlxSprite;

	public static var walls:FlxTypedGroup<Wall>;
	public static var enemyProjectiles:FlxTypedGroup<EnemyProjectile>;
	public static var platformAlive:Bool;

	override public function create()
	{
		player = new Player(0, FlxG.height - 41);
		boss = new Boss(FlxG.width - 170, FlxG.height - 150);
		platformAlive = false;
		walls = new FlxTypedGroup<Wall>();
		enemyProjectiles = new FlxTypedGroup<EnemyProjectile>();
		healthBarBoss = new FlxBar(20, 10, LEFT_TO_RIGHT, 600, 40, boss, "health", 0, 500, true);
		healthBarBoss.createFilledBar(FlxColor.GRAY, FlxColor.RED, true, FlxColor.GREEN);
		healthBarBoss.setCallbacks(endGameWin, null, false);

		healthBarPlayer = new FlxBar(player.x - 10, player.y + 30, LEFT_TO_RIGHT, 50, 10, player, "health", 0, 5, true);
		healthBarPlayer.createFilledBar(FlxColor.GRAY, FlxColor.RED, true, FlxColor.GREEN);
		healthBarPlayer.setCallbacks(endGameLose, null, false);

		background = new FlxSprite(-500, -300);
		background.loadGraphic(AssetPaths.pxArt__png);
		background.scale.set(0.5, 0.5);
		add(background);

		createMap();

		add(player);
		add(boss);
		add(walls);
		add(floor);
		add(healthBarBoss);
		add(healthBarPlayer);
		add(enemyProjectiles);

		var startTimer = new FlxTimer();
		startTimer.start(3, holdAndLoad);

		super.create();
	}

	override public function update(elapsed:Float)
	{
		FlxG.collide(floor, player);
		FlxG.collide(platform, player);

		healthBarPlayer.setPosition(player.x, player.y - 30);

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

	public function holdAndLoad(timer:FlxTimer)
	{
		timer.destroy();
		loadAttacks();
		startAttacks();
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

	public function startAttacks()
	{
		var attackTimer = new FlxTimer();
		attackTimer.start(5, playAttacks, 0);
		currentAttack = 0;
	}

	private function playAttacks(timer:FlxTimer)
	{
		switch attacks[currentAttack]
		{
			case 1:
				boss.animation.play("up");
				var upTimer = new FlxTimer();
				upTimer.start(2, upAttack);
			case 2:
				boss.animation.play("forward");
				var forwardTimer = new FlxTimer();
				forwardTimer.start(2, startForwardAttack);
			case 3:
				boss.animation.play("down");
				var waitTimer = new FlxTimer();
				waitTimer.start(2, downAttack);
		}

		if (currentAttack == attacks.length - 1)
		{
			currentAttack = 0;
		}
		else
		{
			currentAttack++;
		}
	}

	public function upAttack(timer:FlxTimer)
	{
		target = new FlxPoint(PlayState.player.x, PlayState.player.y);

		for (x in 1...20)
		{
			projectile = new EnemyProjectile(x * 32, 0, UP, target);
			enemyProjectiles.add(projectile);
		}

		boss.animation.play("reverseUp");
	}

	public function startForwardAttack(timer:FlxTimer)
	{
		var repeatTimer = new FlxTimer();
		repeatTimer.start(0.25, forwardAttack, 8);
		var animationTimer = new FlxTimer();
		animationTimer.start(2, undoForwardAttack);
	}

	private function forwardAttack(timer:FlxTimer)
	{
		target = new FlxPoint(PlayState.player.x, PlayState.player.y);
		projectile = new EnemyProjectile(boss.x, boss.y + 117, FORWARD, target);
		enemyProjectiles.add(projectile);
	}

	private function undoForwardAttack(timer:FlxTimer)
	{
		boss.animation.play("reverseForwardDown");
	}

	public function downAttack(timer:FlxTimer)
	{
		target = new FlxPoint(PlayState.player.x, PlayState.player.y);
		projectile = new EnemyProjectile(boss.x, boss.y + 117, DOWN, target);
		enemyProjectiles.add(projectile);
		boss.animation.play("reverseForwardDown");
	}

	public function endGameWin()
	{
		var state = new ResultState();
		state.setResult(1);
		FlxG.switchState(state);
	}

	public function endGameLose()
	{
		var state = new ResultState();
		state.setResult(2);
		FlxG.switchState(state);
	}
}
