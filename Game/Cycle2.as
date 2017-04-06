package Game{
    import flash.media.*;
	import flash.events.*;
	import flash.utils.Timer;
	import mx.containers.Box;
	import mx.controls.*;
	import mx.core.*;
	import mx.events.FlexEvent;
	import flash.media.*;
	import flash.display.*;
	import flash.geom.*;

	public class Cycle2 extends UIComponent{
		private var location:LightPoint;	// Current x and y coordinates for cycle
		private var pointing:LightPoint;	// Angle the cycle is facing and it's traction as a vector
		private var velocity:LightPoint;	// Vector from 0,0 with direction and speed
		private var trail:Node;
		private var speed:Number;
		private var trailPixels:Object;
		public var trailLength:int;
		private var game:Game;
		private var allowance:int = 5;
		private var allowanceLeft:int;
		public var cycleImage:Bitmap;
		private var score:int;
		public var friction:Number;
		public var render:Boolean;
		public var scale:Number;

		public static var RIGHT:int = 1;	// Enumerated Directions
		public static var LEFT:int = 2;
		public static var UP:int = 3;
		public static var DOWN:int = 4;

		private var i:int;	// Commonly used variables start here
		private var j:int;
		private var k:int;
		private var tenArray:Array;
		private var carColor:String;

		public var blowupB:Boolean;

		[Embed(source="slowdown.mp3")]
	 	public var slowSound:Class;
	    public var slow:Sound = new slowSound() as Sound;
	    [Embed(source="speedup.mp3")]
	 	public var fastSound:Class;
	    public var fast:Sound = new fastSound() as Sound;

	    [Embed(source="CyclePurple.png")]
	     private var CyclePurple:Class;
	    [Embed(source="CycleRed.png")]
	     private var CycleRed:Class;
	    [Embed(source="CycleWhite.png")]
	     private var CycleWhite:Class;
	    [Embed(source="CycleYellow.png")]
	     private var CycleYellow:Class;

		// initHeading is an angle in radians of the starting direction
		public function Cycle2(initXLocation:int, initYLocation:int, initHeading:Number, initTraction:Number, initSpeed:Number, game:Game, carColor:String, score:int){
			render = true;
			this.carColor = carColor;
			friction = game.options.friction;
			trailLength = game.options.trailLength;
			location = new LightPoint(initXLocation, initYLocation);
			velocity = new LightPoint(Math.cos(initHeading) * initSpeed, Math.sin(initHeading) * initSpeed);
			pointing = new LightPoint(Math.cos(initHeading) * initTraction, Math.sin(initHeading) * initTraction);
			tenArray = new Array(10);
			trail = new Node(new LightPoint(initXLocation, initYLocation));
			var cur:Node = trail;
			for(i = 0; i < trailLength; i++){
				cur.setNext(new Node(new LightPoint(initXLocation, initYLocation)));
				cur = cur.getNext();
			}
			allowanceLeft = allowance;
			cur.setNext(trail);
			speed = game.options.speed;
			trailPixels = new Object();
			this.game = game;
			this.score = score;
			scale = 1;

			blowupB = false;

			if(carColor === "purple"){
				cycleImage = new Bitmap((new CyclePurple()).bitmapData);
			}else if(carColor === "red"){
				cycleImage = new Bitmap((new CycleRed()).bitmapData);
			}else if(carColor === "white"){
				cycleImage = new Bitmap((new CycleWhite()).bitmapData);
			}else{
				cycleImage = new Bitmap((new CycleYellow()).bitmapData);
			}
			cycleImage.scaleX = .33;
			cycleImage.scaleY = .33;
			var mat:Matrix = cycleImage.transform.matrix;
			mat.translate(-cycleImage.width, -cycleImage.height / 2);
			mat.rotate(Math.PI);
			cycleImage.transform.matrix = mat;
			addChild(cycleImage);
		}

		public function changeHeading(direction:int):void{
			if(direction === RIGHT){
				pointing = pointing.rotate(0, 0, Math.PI / 10);
			}else if(direction === LEFT){
				pointing = pointing.rotate(0, 0, -Math.PI / 10);
			}else if(direction === UP){
				speedUp();
			}else if(direction === DOWN){
				slowDown();
			}
		}

		public function reset(initXLocation:int, initYLocation:int, initHeading:Number, initTraction:Number, initSpeed:Number): void{
			trailLength = game.options.trailLength;
			friction = game.options.friction;
			location = new LightPoint(initXLocation, initYLocation);
			velocity = new LightPoint(Math.cos(initHeading) * initSpeed, Math.sin(initHeading) * initSpeed);
			pointing = new LightPoint(Math.cos(initHeading) * initTraction, Math.sin(initHeading) * initTraction);
			tenArray = new Array(10);
			trail = new Node(new LightPoint(initXLocation, initYLocation));
			var cur:Node = trail;
			for(i = 0; i < trailLength; i++){
				cur.setNext(new Node(new LightPoint(initXLocation, initYLocation)));
				cur = cur.getNext();
			}
			allowanceLeft = allowance;
			cur.setNext(trail);
			speed = game.options.speed;
			trailPixels = new Object();
			blowupB = false;
			render = true;

			cycleImage.scaleX = .33;
			cycleImage.scaleY = .33;
		}

		public function speedUp():void {
			if(speed < 10){
				speed++;
				if(game.options.sound){
        			fast.play();
        		}
			}
		}

		public function slowDown():void {
			if(speed > 3){
				speed--;
				if(game.options.sound){
        			slow.play();
        		}
			}
		}

		private function findCircuits(testPoints:Array):Boolean{
			for(i = 0; i < testPoints.length; i++){
				var test:LightPoint = testPoints[i];
				for(j = -3; j <= 3; j++){
					test = new LightPoint(testPoints[i].getX() + j * Math.cos(Math.PI / 2 + Math.atan2(pointing.getY(), pointing.getX())),
							testPoints[i].getY() + j * Math.sin(Math.PI / 2 + Math.atan2(pointing.getY(), pointing.getX())));
					if(test.hash() in trailPixels){
						var points:Array = new Array(0);
						var node:Node = trail;
						while(node.getData().hash() != test.hash()) node = node.getNext();
						points.push(node.getData());
						node = node.getNext();
						while(node.getData().hash() != testPoints[i].hash()){
							points.push(node.getData());
							node = node.getNext();
						}
//						for(k = 0; k < points.length; k++){
//							points[k] = new LightPoint(points[k].getX(), points[k].getY());
//						}
						if(points.length > 20){
							game.gui.addHole(points);
							node = trail.getNext();
							while(node.getData().hash() != test.hash()){
								delete trailPixels[node.getData().hash()];
								node.setData(test);
								node = node.getNext();
							}
							return true;
						}
					}
				}
			}
			return false;
		}

		private function fillCracks(point1:LightPoint, point2:LightPoint):Array{
			var ret:Array = new Array(0);
			var slope:Number = (point1.getY() - point2.getY()) / (point1.getX() - point2.getX());
			var maxX:int = Math.max(Math.round(point1.getX()), Math.round(point2.getX()));
			var minX:int = Math.min(Math.round(point1.getX()), Math.round(point2.getX()));
			var maxY:int = Math.max(Math.round(point1.getY()), Math.round(point2.getY()));
			var minY:int = Math.min(Math.round(point1.getY()), Math.round(point2.getY()));
			for(i = minX + 1; i < maxX; i++){
				ret.push(new LightPoint(i, (i - point1.getX()) * slope + point1.getY()));
			}
			for(i = minY + 1; i < maxY; i++){
				for(j = 0; j < ret.length; j++){
					if(ret[j].getY() === i){
						i++;
						break;
					}
				}
				if(ret[j] !== i){
					ret.push(new LightPoint((i - point1.getY())/slope + point1.getX(), i));
				}
			}
			return ret;
		}

		public function getTrail():Node{
			return trail;
		}

		public function getLocation():LightPoint{
			return location;
		}

		public function getX():Number{
			return location.getX();
		}

		public function getY():Number{
			return location.getY();
		}

		public function getHeading():Number{
			return Math.atan2(pointing.getY(), pointing.getX());
		}

		public function getVelocity():LightPoint{
			return velocity;
		}

		public function getScore():int{ return score; }

		public function blowup():void{
			score++;
			render = false;
			if(game.options.sound) game.gui.explode.play();
			game.gui.scoreBox.updateScores();
		}


		// Should be called every frame
		public function update():void{
			var frictionUse:int = friction;
			var diversion:Number = Math.abs((Math.atan2(velocity.getY(), velocity.getX()) + Math.PI * 2) % (Math.PI * 2) - (Math.atan2(pointing.getY(), pointing.getX()) + Math.PI * 2) % (Math.PI * 2));
			diversion = Math.min(diversion, Math.PI * 2 - diversion);
			var magnitude:Number = Math.sqrt(Math.pow(velocity.getX(), 2) + Math.pow(velocity.getY(), 2));
			if(diversion > Math.PI / 4 && magnitude > 5) frictionUse *= .05;
			velocity = new LightPoint(velocity.getX() + pointing.getX() * frictionUse, velocity.getY() + pointing.getY() * frictionUse);
			if(magnitude > speed){
				velocity = new LightPoint(velocity.getX() * speed / magnitude, velocity.getY() * speed / magnitude);
			}

			var next:LightPoint = location.plus(velocity);
			trail = trail.getNext();
			if(trail.getData().hash() in trailPixels){
				delete trailPixels[trail.getData().hash()];
			}
			trail.setData(location);
			if(game.gui.checkBounds(location.getX(), location.getY(), true)){
				allowanceLeft--;
				if(allowanceLeft <= 0){
					game.gui.checkBounds(location.getX(), location.getY(), false);
					blowupB = true;
				}
			}else{
				allowanceLeft = allowance;
			}
			var gaps:Array = fillCracks(location, next);
			for(i = 0; i < gaps.length; i++){
				trail = trail.getNext();
				if(trail.getData().hash() in trailPixels){
					delete trailPixels[trail.getData().hash()];
				}
				trail.setData(gaps[i]);
				if(game.gui.checkBounds(gaps[i].getX(), gaps[i].getY(), true)){
					allowanceLeft--;
					if(allowanceLeft <= 0){
						game.gui.checkBounds(gaps[i].getX(), gaps[i].getY(), false);
						blowupB = true;
					}
				}else{
					allowanceLeft = allowance;
				}
			}
			location = next;
			if(findCircuits(gaps)){
				location = location.plus(new LightPoint(Math.cos(Math.atan2(velocity.getY(), velocity.getX())) * 8, Math.sin(Math.atan2(velocity.getY(), velocity.getX())) * 8));
			}
			trailPixels[location.hash()] = true;
			for(i = 0; i < gaps.length; i++) trailPixels[gaps[i].hash()] = true;
			gaps.push(location);
			if(blowupB) blowup();
		}
	}
}