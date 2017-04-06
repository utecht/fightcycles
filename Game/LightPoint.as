package Game{

	public class LightPoint {
		private var x:Number;    //The x location
		private var y:Number;    //The y location

		public function LightPoint(x:Number, y:Number){
			this.x = x;
			this.y = y;
		}

		public function getX():Number{ return x; }
		public function getY():Number{ return y; }

		public function setX(x:Number):void { this.x = x; }
		public function setY(y:Number):void { this.y = y; }

		public function hash():String{
			return "" + (Math.round(x) * 1000 + Math.round(y));
		}

		public function toString():String {
			return "X: " + Math.round(this.x) + " Y: " + Math.round(this.y);
		}

		public function plus(point:LightPoint):LightPoint{
			return new LightPoint(x + point.x, y + point.y);
		}

		public function minus(point:LightPoint):LightPoint{
			return new LightPoint(x - point.x, y - point.y);
		}

		public function rotate(centerX:int, centerY:int, angle:Number):LightPoint{
			var ret:LightPoint = new LightPoint(x, y);
			ret.x -= centerX;
			ret.y -= centerY;
			angle += Math.atan2(y, x);
			var magnitude:Number = Math.sqrt(Math.pow(x, 2) + Math.pow(y, 2));
			ret.x = Math.cos(angle) * magnitude + centerX;
			ret.y = Math.sin(angle) * magnitude + centerY;
			return ret;
		}

		public static function distance(point1:LightPoint, point2:LightPoint):Number{
			return Math.sqrt(Math.pow(point1.getX() - point2.getX(), 2) + Math.pow(point1.getY() - point2.getY(), 2));
		}
	}
}