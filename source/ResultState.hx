package;

import flixel.FlxG;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.ui.FlxButton;

class ResultState extends FlxState
{
	public var result:Int;
	public var endText:FlxText;
	public var menuButton:FlxButton;

	override public function create()
	{
		super.create();
		menuButton = new FlxButton(0, 0, "Main Menu", clickMenu);
		add(menuButton);
		if (result == 1)
		{
			endText = new FlxText(0, 0, 0, "You Win", 25, false);
		}
		else if (result == 2)
		{
			endText = new FlxText(0, 0, 0, "You Lose", 25, false);
		}

		add(endText);

		endText.screenCenter();
		endText.y -= 100;
		menuButton.screenCenter();
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);
	}

	public function setResult(_result:Int)
	{
		result = _result;
	}

	function clickMenu()
	{
		FlxG.switchState(new MenuState());
	}
}
