package;
import flixel.FlxSprite;
import flixel.input.FlxPointer;
import flixel.math.FlxPoint;
import flixel.system.FlxAssets.FlxGraphicAsset;
import flixel.tweens.FlxTween;
import flixel.math.FlxVelocity;
import flixel.util.FlxTimer;
import flixel.math.FlxAngle;
import flixel.math.FlxMath;
import flixel.math.FlxRandom;
/**
 * ...
 * @author ...
 */
class Squirrel extends FlxSprite 
{

	//Speed of the Squirrel with Random gen var to get different speed
	
	public var Sspeed:Float = 350;
	//Random number that determines the action of the Squirrel
	public var ActionRNG:Int;
	
	 
	public function new(?X:Float=0, ?Y:Float=0, ?SimpleGraphic:FlxGraphicAsset, AIMove:Int) 
	{
		var _ran:FlxRandom = new FlxRandom();
		Sspeed =  _ran.float(250, 400);
		super(X, Y, SimpleGraphic);
		ActionRNG = AIMove;
		
		loadGraphic("assets/images/Squirrel.png", true, 32, 32);
		animation.add("SqFly", [0, 1, 2, 3, 4, 5, 6], 20, true);
		animation.play("SqFly");
		
	}
	
	public function move(player:Bird)
	{
		if (ActionRNG == 1 )
		{
			movetoTarget(player);
		}
		else if (ActionRNG == 2|| ActionRNG == 3 || ActionRNG == 4)
		{
			velocity.set( -1 * Sspeed, 0 );
		}
		else if (ActionRNG == 5)
		{
			this.x = 640;
			this.y = 100;
			var point:FlxPoint = new FlxPoint(0, 280);
			FlxVelocity.moveTowardsPoint(this,  point, Sspeed);
			
		}
		else if (ActionRNG == 6)
		{
			this.x = 640;
			this.y = 280;
			var point:FlxPoint = new FlxPoint(0, 100);
			FlxVelocity.moveTowardsPoint(this,  point, Sspeed);
		}
	}
	
	function movetoTarget(player:Bird)
	{
		var angle:Float = FlxAngle.angleBetween(this , player, false);
		velocity.set( Sspeed * FlxMath.fastCos(angle), Sspeed * FlxMath.fastSin(angle));
		
		
	}
	public function dropdead()
	{
		velocity.set( -1 * Sspeed/ 3, 3 * Sspeed);
	}
	function waitAttack1(Timer:FlxTimer):Void
	{
		velocity.set(-1 * Sspeed, -50);
	}
		function waitAttack2(Timer:FlxTimer):Void
	{
		velocity.set(-1 * Sspeed, 50);
	}
	
	
	public function checkdead():Void
	{
		if (this.x < -20 || this.y < -50 || this.y > 680)
		{
			destroy();
		}
		
	}

	
}