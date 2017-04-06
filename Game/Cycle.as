package Game{
	public class Cycle{
		private var game:Game;
		public var location:LightPoint;
		public var heading:Number;
		private var velocity:LightPoint;
		public var trail:Array;
		private var friction:Number;
		private var traillength:int = 500;
		private var trailWidth:int = 1;
		private var trailIndex:int;
		private var trailDelay:int = 10;
		public var pointSet:Object;
		private var currentPoint:LightPoint;
		private var fillWork:Array;
		private var speed:int;

		public function Cycle(initx:Number, inity:Number, initHeading:Number, initxvel:Number, inityvel:Number, game:Game){
			this.game = game;
			currentPoint = location = new LightPoint(initx, inity);
			heading = initHeading;
			velocity = new LightPoint(initxvel, inityvel);
			trail = new Array(traillength * trailWidth);
			var i:int;
			for(i = 0; i < traillength * trailWidth; i++) trail[i] = new LightPoint(-50 - i * 3,-50 - i * 3);
			trailIndex = 0;
			friction = 1;
			pointSet = new Object();
			fillWork = new Array();
			speed = 5;
		}

		// 1 = left, 2 = right
		public function changeHeading(direction:int):void{
			var left:int = 1;
			var right:int = 2;
			if(direction === left){
				heading += (90 * Math.PI / 180);
			}else if(direction === right){
				heading -= (90 * Math.PI / 180);
			}
		}

		private function checkCircuits(depth:int):void{
			var i:Number;
			var j:Number;
			var k:Number;
			var l:Number;
			var test:LightPoint;
//			for(i = 0; i < depth; i++){
//				pointSet[trail[(trailIndex - i - trailDelay * trailWidth)%(trailWidth*traillength)].hash().toString()] = 1;
//			}
			for(i = -1; i <= 1; i++){
				for(j = -1; j <= 1; j++){
					for(l = 0; l < depth; l+=2){
						test = new LightPoint(Math.round(trail[(trailIndex - l)%trail.length].x + i), Math.round(currentPoint.y + j));
						for(k = trailIndex + 1; k < trailIndex - 10 + trail.length; k++){
							if(test.hash() === trail[k%trail.length].hash()){
								game.window.setMessage("" + k%trail.length);
								break;
							}
						}
					}
				}
			}
		}

		private function fillCracks(point1:LightPoint, point2:LightPoint):int{
			var i:int;
			var j:int;
			var found:int = 0;
			var slope:Number = (point1.y - point2.y) / (point1.x - point2.x);
			var maxX:int = Math.max(Math.round(point1.x), Math.round(point2.x));
			var minX:int = Math.min(Math.round(point1.x), Math.round(point2.x));
			var maxY:int = Math.max(Math.round(point1.y), Math.round(point2.y));
			var minY:int = Math.min(Math.round(point1.y), Math.round(point2.y));
			for(i = minX + 1; i < maxX; i++){
				fillWork[found] = new LightPoint(i, (i - point1.x) * slope + point1.y);
				found++;
			}
			for(i = minY + 1; i < maxY; i++){
				for(j = 0; j < found; j++){
					if(fillWork[j].y === i){
						i++;
						break;
					}
				}
				if(fillWork[j] !== i){
					fillWork[found] = new LightPoint((i - point1.y)/slope + point1.x, i);
					found++;
				}
			}
			return found;
		}

		// Should be called every frame
		public function update():void{
			var i:int;
			var xvel:Number = Math.cos(heading) * friction + velocity.x;
			var yvel:Number = Math.sin(heading) * friction + velocity.y;
			var newAngle:Number = (xvel === 0) ? 0 : Math.atan2(yvel,xvel);
			velocity.x = Math.cos(newAngle) * speed;
			velocity.y = Math.sin(newAngle) * speed;

			location.x += velocity.x;
			location.y += velocity.y;
			trailIndex += trailWidth;

//			if(trail[trailIndex%(traillength * trailWidth)].hash() in pointSet){
//				delete pointSet[trail[trailIndex%(traillength * trailWidth)].hash()];
//			}
			var next:LightPoint = new LightPoint(location.x, location.y);
			trail[trailIndex%(traillength * trailWidth)] = currentPoint;

			var found:int = fillCracks(currentPoint, next);
			for(i = 0; i < found; i++){
				trailIndex++;
				trail[trailIndex%(traillength * trailWidth)] = fillWork[i];
			}
			currentPoint = next;
			checkCircuits(found + 1);
		}
	}
}