package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.ui.FlxButton;

class RulesState extends FlxState
{
	var oneButton:FlxButton;
	var twoButton:FlxButton;
	var background:FlxSprite;

	override public function create()
	{
		super.create();

		background = new FlxSprite(0, 0);
		background.loadGraphic(AssetPaths.rules__png);
		add(background);

		oneButton = new FlxButton(50, 50, "Main Menu", clickMenu);
		add(oneButton);
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);
	}

	function clickMenu()
	{
		FlxG.switchState(new MenuState());
	}
}
