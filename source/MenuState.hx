package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.ui.FlxButton;

class MenuState extends FlxState
{
	var oneButton:FlxButton;
	var twoButton:FlxButton;
	var background:FlxSprite;

	override public function create()
	{
		super.create();

		background = new FlxSprite(-500, -300);
		background.loadGraphic(AssetPaths.pxArt__png);
		background.scale.set(0.5, 0.5);
		add(background);

		oneButton = new FlxButton(0, 0, "Play", clickPlay);
		add(oneButton);
		oneButton.screenCenter();
		oneButton.setPosition(oneButton.getPosition().x - 50, oneButton.getPosition().y);

		twoButton = new FlxButton(0, 0, "How to Play", clickRules);
		add(twoButton);
		twoButton.screenCenter();
		twoButton.setPosition(twoButton.getPosition().x + 50, twoButton.getPosition().y);
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);
	}

	function clickPlay()
	{
		FlxG.switchState(new PlayState());
	}

	function clickRules()
	{
		FlxG.switchState(new RulesState());
	}
}
