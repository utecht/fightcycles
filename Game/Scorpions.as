package Game{

	public class Scorpions{
		private var loc:LightPoint
		private var start:LightPoint;
		private var changedir:int;
		private var dx:int, dy:int, x:int, y:int;
		private var count:int;

		public function Scorpions(x:Number, y:Number, selection:int){
			start = new LightPoint(x, y);
			loc = new LightPoint(x + Math.round(Math.random() * 2 - 1), y + Math.round(Math.random() * 2 - 1));
			dx = dy = 0;
			count = 40;
			changedir = 100;
		}

		public function getX():Number{
			return loc.getX();
		}

		public function getY():Number{
			return loc.getY();
		}

		public function update():void{
			count ++;
			if(count%changedir == 0){
				if(loc.getX() > start.getX()) dx = -(Math.random() * 4 + 1);
				else dx = (Math.random() * 4 + 1);
				if(loc.getY() > start.getY()) dy = -Math.random() * 4;
				else dy = (Math.random() * 4 + 1);
				changedir = Math.round(Math.random() * 40 + 120);
			}
			loc = new LightPoint(loc.getX() + dx, loc.getY() + dy);

			// 1 2 3   Move directions
			// 0   4   are determined randomly
			// 7 6 5   by this compass
//			var dir:int = Math.round(Math.random() * 8);
//			if(dir === 0){
//				loc.setX(loc.getX() - speed);
//			} else if(dir === 1){
//				loc.setX(loc.getX() - speed);
//				loc.setX(loc.getY() - speed);
//			} else if(dir === 2){
//				loc.setX(loc.getY() - speed);
//			} else if(dir === 3){
//				loc.setX(loc.getY() - speed);
//				loc.setX(loc.getX() + speed);
//			} else if(dir === 4){
//				loc.setX(loc.getX() + speed);
//			} else if(dir === 5){
//				loc.setX(loc.getX() + speed);
//				loc.setX(loc.getY() + speed);
//			} else if(dir === 6){
//				loc.setX(loc.getY() + speed);
//			} else if(dir === 7){
//				loc.setX(loc.getY() + speed);
//				loc.setX(loc.getX() - speed);
//			}
		}
	}

}