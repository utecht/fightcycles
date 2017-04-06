package Game {
	import flash.display.Sprite;
	import flash.display.Bitmap;
	import flash.display.BitmapData;

	public class BitmapBetter extends Sprite{

			[Embed(source = "One.png")]
			public var OneImage:Class;
			[Embed(source = "Two.png")]
			public var TwoImage:Class;
			[Embed(source = "Three.png")]
			public var ThreeImage:Class;

			[Embed(source = "numbers/p1.png")]
			public var P1Image:Class;
			[Embed(source = "numbers/p2.png")]
			public var P2Image:Class;
			[Embed(source = "numbers/p3.png")]
			public var P3Image:Class;
			[Embed(source = "numbers/p4.png")]
			public var P4Image:Class;
			[Embed(source = "numbers/p5.png")]
			public var P5Image:Class;
			[Embed(source = "numbers/p6.png")]
			public var P6Image:Class;
			[Embed(source = "numbers/p7.png")]
			public var P7Image:Class;
			[Embed(source = "numbers/p8.png")]
			public var P8Image:Class;
			[Embed(source = "numbers/p9.png")]
			public var P9Image:Class;
			[Embed(source = "numbers/p0.png")]
			public var P0Image:Class;

			[Embed(source = "numbers/r1.png")]
			public var R1Image:Class;
			[Embed(source = "numbers/r2.png")]
			public var R2Image:Class;
			[Embed(source = "numbers/r3.png")]
			public var R3Image:Class;
			[Embed(source = "numbers/r4.png")]
			public var R4Image:Class;
			[Embed(source = "numbers/r5.png")]
			public var R5Image:Class;
			[Embed(source = "numbers/r6.png")]
			public var R6Image:Class;
			[Embed(source = "numbers/r7.png")]
			public var R7Image:Class;
			[Embed(source = "numbers/r8.png")]
			public var R8Image:Class;
			[Embed(source = "numbers/r9.png")]
			public var R9Image:Class;
			[Embed(source = "numbers/r0.png")]
			public var R0Image:Class;

			[Embed(source = "numbers/w1.png")]
			public var W1Image:Class;
			[Embed(source = "numbers/w2.png")]
			public var W2Image:Class;
			[Embed(source = "numbers/w3.png")]
			public var W3Image:Class;
			[Embed(source = "numbers/w4.png")]
			public var W4Image:Class;
			[Embed(source = "numbers/w5.png")]
			public var W5Image:Class;
			[Embed(source = "numbers/w6.png")]
			public var W6Image:Class;
			[Embed(source = "numbers/w7.png")]
			public var W7Image:Class;
			[Embed(source = "numbers/w8.png")]
			public var W8Image:Class;
			[Embed(source = "numbers/w9.png")]
			public var W9Image:Class;
			[Embed(source = "numbers/w0.png")]
			public var W0Image:Class;

			[Embed(source = "numbers/y1.png")]
			public var Y1Image:Class;
			[Embed(source = "numbers/y2.png")]
			public var Y2Image:Class;
			[Embed(source = "numbers/y3.png")]
			public var Y3Image:Class;
			[Embed(source = "numbers/y4.png")]
			public var Y4Image:Class;
			[Embed(source = "numbers/y5.png")]
			public var Y5Image:Class;
			[Embed(source = "numbers/y6.png")]
			public var Y6Image:Class;
			[Embed(source = "numbers/y7.png")]
			public var Y7Image:Class;
			[Embed(source = "numbers/y8.png")]
			public var Y8Image:Class;
			[Embed(source = "numbers/y9.png")]
			public var Y9Image:Class;
			[Embed(source = "numbers/y0.png")]
			public var Y0Image:Class;

			public var oneImage:Bitmap;
			public var twoImage:Bitmap;
			public var threeImage:Bitmap;

			public var p1:Bitmap;
			public var p2:Bitmap;
			public var p3:Bitmap;
			public var p4:Bitmap;
			public var p5:Bitmap;
			public var p6:Bitmap;
			public var p7:Bitmap;
			public var p8:Bitmap;
			public var p9:Bitmap;
			public var p0:Bitmap;

			public var r1:Bitmap;
			public var r2:Bitmap;
			public var r3:Bitmap;
			public var r4:Bitmap;
			public var r5:Bitmap;
			public var r6:Bitmap;
			public var r7:Bitmap;
			public var r8:Bitmap;
			public var r9:Bitmap;
			public var r0:Bitmap;

			public var w1:Bitmap;
			public var w2:Bitmap;
			public var w3:Bitmap;
			public var w4:Bitmap;
			public var w5:Bitmap;
			public var w6:Bitmap;
			public var w7:Bitmap;
			public var w8:Bitmap;
			public var w9:Bitmap;
			public var w0:Bitmap;

			public var y1:Bitmap;
			public var y2:Bitmap;
			public var y3:Bitmap;
			public var y4:Bitmap;
			public var y5:Bitmap;
			public var y6:Bitmap;
			public var y7:Bitmap;
			public var y8:Bitmap;
			public var y9:Bitmap;
			public var y0:Bitmap;

		public function BitmapBetter(){

			p1 = new P1Image();
			p2 = new P2Image();
			p3 = new P3Image();
			p4 = new P4Image();
			p5 = new P5Image();
			p6 = new P6Image();
			p7 = new P7Image();
			p8 = new P8Image();
			p9 = new P9Image();
			p0 = new P0Image();

			r1 = new R1Image();
			r2 = new R2Image();
			r3 = new R3Image();
			r4 = new R4Image();
			r5 = new R5Image();
			r6 = new R6Image();
			r7 = new R7Image();
			r8 = new R8Image();
			r9 = new R9Image();
			r0 = new R0Image();

			w1 = new W1Image();
			w2 = new W2Image();
			w3 = new W3Image();
			w4 = new W4Image();
			w5 = new W5Image();
			w6 = new W6Image();
			w7 = new W7Image();
			w8 = new W8Image();
			w9 = new W9Image();
			w0 = new W0Image();

			y1 = new Y1Image();
			y2 = new Y2Image();
			y3 = new Y3Image();
			y4 = new Y4Image();
			y5 = new Y5Image();
			y6 = new Y6Image();
			y7 = new Y7Image();
			y8 = new Y8Image();
			y9 = new Y9Image();
			y0 = new Y0Image();


			oneImage = new OneImage();
			addChild(oneImage);
			trace(oneImage.bitmapData.getPixel(0,0));

			twoImage = new TwoImage();
			addChild(twoImage);
			trace(twoImage.bitmapData.getPixel(0,0));

			threeImage = new ThreeImage();
			addChild(threeImage);
			trace(threeImage.bitmapData.getPixel(0,0));
		}
	}
}