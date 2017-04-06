package Game{
	import flash.events.*;
	import flash.utils.Timer;
	import mx.containers.Box;
	import mx.controls.*;
	import mx.core.*;
	import mx.events.FlexEvent;
	import flash.media.*;
	import flash.display.*;
	import flash.geom.*;

	public class PowerUp extends UIComponent{
		private var location:LightPoint;
		private static var unknown:int = -1;
		private static var scorpion:int = 0;
		private static var walrus:int = 1;
		private static var holeyMoley:int = 2;
		private static var ice:int = 3;
		private var it:int;
		private var dx:int, dy:int, bx:int, by:int, i:int, count:int;
		private var image:Bitmap, beeImage:Bitmap;
		private var rotationIndex:int;
		private var pic:BitmapAsset, bPic:BitmapAsset;
		private var picBitmapData:BitmapData, beePicBitmapData:BitmapData;
		private var gui:GUI;
	    [Embed(source="walrus.mp3")]
		public var walrusSound:Class;
		public var hork:Sound = new walrusSound() as Sound;
		[Embed(source="scorpion.png")]
		[Bindable]
		private var scorpionPic:Class;
		[Embed(source="walrus.png")]
		[Bindable]
		private var walrusPic:Class;
		[Embed(source="bee.png")]
		[Bindable]
		private var beePic:Class;
		[Embed(source="ice.png")]
		[Bindable]
		private var icePic:Class;
		[Embed(source="questmark.png")]
		[Bindable]
		private var unknownPic:Class;

		public function PowerUp(x:Number, y:Number, whatItIs:int, gui:GUI){
			count = 0;
			this.gui = gui;
			bx = x;
			by = y;
			location = new LightPoint(x, y);
			this.x = x;
			this.y = y;
			dx = Math.random() > .5 ? Math.random() * 10 + 1 : -Math.random() * 10 - 1;
			dy = Math.random() > .5 ? Math.random() * 10 + 1 : -Math.random() * 10 - 1;
			rotationIndex = 1;
			changeIt(whatItIs);
		}

		public function changeIt(whatItIs:int):void {
			it = whatItIs;
			if(it == unknown){
				pic = new unknownPic() as BitmapAsset;
			}else if(it == scorpion){
				pic = new scorpionPic() as BitmapAsset;
			}else if(it == walrus){
				pic = new walrusPic() as BitmapAsset;
				bPic = new beePic() as BitmapAsset;
				beePicBitmapData = bPic.bitmapData;
				bx = location.getX();
				by = location.getY();
			}else if(it == ice){
				pic = new icePic() as BitmapAsset;
			}
			picBitmapData = pic.bitmapData;

			if(image != null && contains(image)){
				removeChild(image);
			}

			if(beeImage != null && contains(beeImage)){
				removeChild(beeImage);
			}

			if(it != holeyMoley){
				image = new Bitmap(picBitmapData);
				image.x = 0;
				image.y = 0;
				if(!isIce() && !isScorpion()){
					image.scaleX = .5;
					image.scaleY = .5;
				}
				if(isScorpion()){
					image.scaleX = 0.25;
					image.scaleY = 0.25;
				}
				addChild(image);
				if(it == walrus){
					if(gui.game.options.sound){
						hork.play();
					}
					beeImage = new Bitmap(beePicBitmapData);
					beeImage.scaleX = 0.2;
					beeImage.scaleY = 0.2;
					beeImage.x = 0;
					beeImage.y = 0;
					addChild(beeImage);
				}
			}else if(it == holeyMoley){
				holeyMoleyAction();
			}
		}

		public function isScorpion():Boolean {
			return it == scorpion;
		}

		public function isWalrus():Boolean {
			return it == walrus;
		}

		public function isKnown():Boolean {
			return it != unknown;
		}

		public function isIce():Boolean {
			return it == ice;
		}

		public function setLocation(x:Number, y:Number):void {
			location.setX(x);
			location.setY(y);
			this.x = x;
			this.y = y;
		}

		public function act():void{
			if(it == scorpion){
				scorpionAction();
			}else if(it == walrus){
				walrusAction();
			}
		}

		public function getBee():Bitmap {
			return beeImage;
		}

		public function getX():int {
			return location.getX();
		}

		public function getY():int {
			return location.getY();
		}

		public function scorpionAction():void {
			count ++;
			if(count > 60){
				if(image.x>(500 - location.getX()) || image.x<(-location.getX()) || image.y<(-location.getY()) || image.y>(500 - location.getY())){
					remove();
				}else{
					image.x += dx;
					image.y += dy;
				}
			}
		}

		private function remove():void{
			if(image != null && contains(image)){
				removeChild(image);
			}
		}

		public function walrusAction():void {
			if(beeImage.x>(500 - location.getX()) || beeImage.x<(-location.getX()) || beeImage.y<(-location.getY()) || beeImage.y>(500 - location.getY())){
				if(gui.game.options.sound){
					hork.play();
				}
				beeImage.rotation = beeImage.rotation + 90;
				rotationIndex ++;
				rotationIndex = rotationIndex % 4;
				image.rotation = image.rotation + 90;

				if(rotationIndex < 1){
					image.x = 0;
					image.y = image.width;
					beeImage.x = 0;
					beeImage.y = image.width;
				}else if(rotationIndex < 2 ){
					image.x = 0;
					image.y = 0;
					beeImage.x = 0;
					beeImage.y = 0;
				}else if(rotationIndex < 3){
					image.x = image.width;
					image.y = 0;
					beeImage.x = image.width;
					beeImage.y = 0;
				}else if(rotationIndex < 4){
					image.x = image.height;
					image.y = image.width;
					beeImage.x = image.height;
					beeImage.y = image.width;
				}
				this.x = location.getX();
				this.y = location.getY();

			}
			if(rotationIndex < 1){
				beeImage.x = beeImage.x + 10;
			}else if(rotationIndex < 2 ){
				beeImage.y = beeImage.y + 10;
			}else if(rotationIndex < 3){
				beeImage.x = beeImage.x - 10;
			}else if(rotationIndex < 4){
				beeImage.y = beeImage.y - 10;
			}else{
				beeImage.x = beeImage.x + 10;
				beeImage.y = beeImage.y + 10;
			}
		}

		public function holeyMoleyAction():void {
			var hx:int;
			var hy:int;
			var size:int = Math.random() * 5 + 1;
			for(i = 0; i < size; i ++){
				hx = Math.random() * 400 + 25;
				hy = Math.random() * 400 + 25;
				gui.addHole(new Array(new LightPoint(hx, hy), new LightPoint(hx + 20, hy), new LightPoint(hx + 30, hy - 18), new LightPoint(hx + 20, hy - 36), new LightPoint(hx, hy - 36), new LightPoint(hx - 10, hy - 18)));
			}
		}
	}
}