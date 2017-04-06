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

	public class AICycle extends UIComponent{
		private var location:LightPoint;	// Current x and y coordinates for cycle
		private var pointing:LightPoint;	// Angle the cycle is facing and it's traction as a vector
		private var velocity:LightPoint;	// Vector from 0,0 with direction and speed
		private var trail:Node;
		private var speed:Number;
		private var trailPixels:Object;
		private static var _trailLength:int = 1000;
		private var game:Game;
		private var difficulty:int;
		private var allowance:int = 5;
		private var allowanceLeft:int;
		public var cycleImage:Bitmap;
		public var blowupB:Boolean;
		private var i:int;	// Commonly used variables start here
		private var j:int;
		private var k:int;
		private var tenArray:Array;
		private var dest:Array;
		private var planStep:int;
		private var changeDir:int;
		private var curDest:LightPoint;
		public var score:int;
		public var render:Boolean;
		public var mode:int;

	    [Embed(source="AIBall.png")]
	     private var aiCycle:Class;

		// initHeading is an angle in radians of the starting direction
		public function AICycle(initXLocation:int, initYLocation:int, initHeading:Number, initTraction:Number, initSpeed:Number, game:Game){
			location = new LightPoint(initXLocation, initYLocation);
			velocity = new LightPoint(Math.cos(initHeading) * initSpeed, Math.sin(initHeading) * initSpeed);
			pointing = new LightPoint(Math.cos(initHeading) * initTraction, Math.sin(initHeading) * initTraction);
			tenArray = new Array(10);
			mode = Math.round(Math.random());
			difficulty=game.options.difficulty;
			trail = new Node(new LightPoint(initXLocation, initYLocation));
			var cur:Node = trail;
			for(i = 0; i < trailLength; i++){
				cur.setNext(new Node(new LightPoint(initXLocation, initYLocation)));
				cur = cur.getNext();
			}
			blowupB = false;
			render = true;
			allowanceLeft = allowance;
			score = 0;
			cur.setNext(trail);
			speed = 5;
			allowanceLeft = allowance;
			trailPixels = new Object();
			this.game = game;
			curDest=new LightPoint((Math.random()*300)+50,(Math.random()*300)+50);
			cycleImage = new Bitmap((new aiCycle()).bitmapData);
			cycleImage.scaleX = .1;
			cycleImage.scaleY = .1;
			var mat:Matrix = cycleImage.transform.matrix;
			mat.translate(0, -cycleImage.height / 2);
			cycleImage.transform.matrix = mat;
			addChild(cycleImage);
		}

		// called when a game ends to reset the AICycle in its initial position
		public function reset(initXLocation:int, initYLocation:int, initHeading:Number, initTraction:Number, initSpeed:Number): void{
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
			cur.setNext(trail);
			speed = 5;
			trailPixels = new Object();
			difficulty=game.options.difficulty;
			curDest=new LightPoint((Math.random()*300)+50,(Math.random()*300)+50);

			blowupB = false;
			render = true;
			allowanceLeft=allowance;

			cycleImage.scaleX = .1;
			cycleImage.scaleY = .1;
		}

		public function get trailLength():int {
			return _trailLength;
		}
		//determines what direction a given point value is on the Unit Circle,
		//based around another given point in the center
		private function radianToPoint(xpos1:Number, ypos1:Number, xpos2:Number, ypos2:Number):Number {
			   var value:Number;
			   value = Math.atan2(ypos2 - ypos1, xpos2 - xpos1);
			   return value + Math.PI;
		}
		//
		public function rangefinder(point:LightPoint):void {
			if(point.getX()>10 &&point.getX()<510 &&point.getY()>10 &&point.getY()<510){
				var newPointing:Number = radianToPoint(point.getX(), point.getY(), location.getX(), location.getY());
				changeHeading(newPointing);
				planStep++;
			}
		}

		// Takes the heading it wants to go to and changes the
		// AI cycle's pointing to match it.
		public function changeHeading(heading:Number):void{
			pointing = new LightPoint(Math.cos(heading), Math.sin(heading));
		}

		private function findCircuits(testPoints:Array):Boolean{
			for(i = 0; i < testPoints.length; i++){
				var test:LightPoint = testPoints[i];
				for(j = -2; j <= 2; j++){
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
						for(k = 0; k < points.length; k++){
							points[k] = new LightPoint(points[k].getX(), points[k].getY());
						}
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

		public function blowup():void{
			score++;
			if(game.options.sound) game.gui.explode.play();
			game.gui.scoreBox.updateScores();
			render = false;
		}

		public function getScore():int {
			return score;
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
		//determines whether the AIcycle is within 20 pixels of the chosen point
		public function pointHit():void{
			var distForm:Number = LightPoint.distance(location,curDest);
			rangefinder(curDest);
			if (distForm<=20){
				curDest=pointPicker();
			}
		}

		private function pointPicker():LightPoint{
			var ret:LightPoint = new LightPoint((Math.random()*300)+50,(Math.random()*300)+50);
			var good:Boolean = false;
			var attempts:int = 0;
			while(!good && attempts < 5){
				attempts ++;
				good = true;
				while(game.gui.checkBounds(ret.getX(), ret.getY(), true)) ret = new LightPoint((Math.random()*300)+50,(Math.random()*300)+50);
				for(k = 0; k<20; k++){
					if(game.gui.checkBounds(ret.getX() + (ret.getX() - location.getX()) * k / 20, ret.getY() - (ret.getY() - location.getY()) * k/20, true)){
						ret = new LightPoint((Math.random()*300)+50,(Math.random()*300)+50);
						good = false;
						break;
					}
				}
			}
			return ret;
		}

		private function circler():void{
			var nextLoc:LightPoint = game.cycle.getLocation().plus(game.cycle.getVelocity());
			var firstDist:Number=LightPoint.distance(location,game.cycle.getLocation());
			var nextDist:Number=LightPoint.distance(location, nextLoc);
			if(firstDist>nextDist){
				var destLoc:LightPoint = game.cycle.getLocation().plus(new LightPoint(game.cycle.getVelocity().getX()*4, game.cycle.getVelocity().getY()*4));
				rangefinder(destLoc);
			}else if(firstDist<nextDist){
				var destLoc2:LightPoint = game.cycle.getLocation().minus(new LightPoint(game.cycle.getVelocity().getX()*4, game.cycle.getVelocity().getY()*4));
				rangefinder(destLoc2);
			}
		}

		private function holeHater():void{
			//var testVelocity:LightPoint=velocity.plus(pointing);
			var testLocation:LightPoint=location.plus(pointing);
			var t:int;
			var v:int;
			for (t=0; t<5;t++){

				if(game.gui.checkBounds(testLocation.getX(), testLocation.getY(),true)){
					pointing = pointing.rotate(0,0,3*Math.PI / 4);
					pointing = pointing.plus(pointing);
					curDest=new LightPoint((Math.random()*300)+50,(Math.random()*300)+50);
					//break;
				}
				testLocation=testLocation.plus(pointing);
			}
		}

		// Should be called every frame
		public function update():void{
			if (mode===0){
				circler();
			}else if (mode===1){
				pointHit();
			}

			holeHater();

			if(Math.round(Math.random() * 125) == 1) mode = Math.round(Math.random());

			velocity = velocity.plus(pointing);
			var magnitude:Number = Math.sqrt(Math.pow(velocity.getX(), 2) + Math.pow(velocity.getY(), 2));
			if(magnitude > 5){
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