package Game {
	import flash.events.*;
	import flash.utils.Timer;
	import mx.containers.Box;
	import mx.controls.*;
	import mx.core.*;
	import mx.events.FlexEvent;
	import flash.media.*;
	import flash.display.*;
	import flash.geom.*;


	public class GUI extends UIComponent {
		public var game:Game;
		//[Embed(source="move0.mp3")]
		//public var move0Sound:Class;
		//public var move0:Sound = new move0Sound() as Sound;
		[Embed(source="turn.mp3")]
		public var turnSound:Class;
		public var turn:Sound = new turnSound() as Sound;
		[Embed(source="explosion.mp3")]
		public var explosionSound:Class;
		public var explode:Sound = new explosionSound() as Sound;
		[Embed(source="Scorpions.mp3")]
		public var scorpSound0:Class;
		private var scorpSound:Sound = new scorpSound0() as Sound;
		private var cyclePurple:BitmapAsset;
		private var cyclePurpleBD:BitmapData;
		private var matrix:Matrix;
		public var powerUps:Array, prevHeadings:Array, prevAIHeadings:Array, holes:Array, change:Array;
		private var countMatrix:Matrix;
		private var i:int, storeX:int, storeY:int;
		public var keysDown:Array;

		[Embed(source="walrus.mp3")]
		public var walrusSound:Class;
		public var hork:Sound = new walrusSound() as Sound;

		[Embed(source="CyclePurple.png")]
		private var CyclePurple:Class;
		[Embed(source="CycleRed.png")]
		private var CycleRed:Class;
		[Embed(source="CycleWhite.png")]
		private var CycleWhite:Class;
		[Embed(source="CycleYellow.png")]
		private var CycleYellow:Class;
		public var delay:int;

		 private var bitmapBetter:BitmapBetter;
		 private var oneImage:Bitmap;
		 private var twoImage:Bitmap;
		 private var threeImage:Bitmap;
		 public var scoreBox:ScoreBox;
		 private var testImage:Bitmap;

	 public function GUI(game:Game) {
			 this.setStyle("horizontalAlign", "right");
			 this.setStyle("verticalAlign", "top");

			 holes = new Array(0);

			 matrix = new Matrix();

			 cyclePurple = new CyclePurple() as BitmapAsset;
			 cyclePurpleBD = cyclePurple.bitmapData;

			 this.game = game;
			 addEventListener(KeyboardEvent.KEY_DOWN, reportKeyDown);
			 addEventListener(KeyboardEvent.KEY_UP, reportKeyUp);

			 countMatrix = new Matrix();

			 bitmapBetter = new BitmapBetter();

			 //Adding the border
			 addHole(new Array(new LightPoint(10, 10), new LightPoint(510, 10), new LightPoint(510, 0), new LightPoint(10, 0)));
			 addHole(new Array(new LightPoint(510, 0), new LightPoint(510, 520), new LightPoint(520, 520), new LightPoint(520, 0)));
			 addHole(new Array(new LightPoint(510, 510), new LightPoint(10, 510), new LightPoint(10, 520), new LightPoint(510, 520)));
			 addHole(new Array(new LightPoint(10, 520), new LightPoint(10, 0), new LightPoint(0, 0), new LightPoint(0, 520)));

			 graphics.beginFill(0x3CB371);
			 graphics.drawRect(10, 10, 510, 510);

			this.scoreBox = new ScoreBox(game, bitmapBetter);
			scoreBox.x = 10;
			scoreBox.y = 530;
			addChild(scoreBox);
			keysDown = new Array();
		}

	 public function gameStart():void{
		 if(game.options.sound){
			 //move0.play(0,100000)
		 }
	 }

	 public function reset():void{
		 graphics.clear();
		 while(numChildren > 0){
			 removeChildAt(0);
		 }

		 addChild(scoreBox);

		 addHole(new Array(new LightPoint(10, 10), new LightPoint(510, 10), new LightPoint(510, 0), new LightPoint(10, 0)));
		 addHole(new Array(new LightPoint(510, 0), new LightPoint(510, 520), new LightPoint(520, 520), new LightPoint(520, 0)));
		 addHole(new Array(new LightPoint(510, 510), new LightPoint(10, 510), new LightPoint(10, 520), new LightPoint(510, 520)));
		 addHole(new Array(new LightPoint(10, 520), new LightPoint(10, 0), new LightPoint(0, 0), new LightPoint(0, 520)));
	 }

	 public function addStuff():void {
		 if(game.options.powerUp){
		 	makePowerUps();
		 }

		 if(prevHeadings == null){
			 prevHeadings = new Array(game.options.multiPlayer ? game.options.numPlayers : 1);
			 prevHeadings[0] = 0;
		 }

		 if(game.options.multiPlayer){
			 for(i = 0; i <game.options.numPlayers; i ++){
				 prevHeadings[i] = 0;
			 }
		 }

		 if(prevAIHeadings == null){
			 prevAIHeadings = new Array(game.options.numAI);
			 for(i = 0; i <game.options.numAI; i ++){
				 prevAIHeadings[i] = 0;
				 addChild(game.aCycle[i]);
			 }
		 }

		 if(change == null){
			 change = new Array(game.options.multiPlayer ? game.options.numPlayers : 1);
		 }

		 for(i = 0; i < change.length; i ++){
			 change[i] = true;
		 }

		 for(i = 0; i <game.options.numAI; i ++){
			 addChild(game.aCycle[i]);
		 }

		 if(game.options.multiPlayer){
			for(i = 0; i < game.options.numPlayers; i++){
				 addChild(game.cycles[i]);
			}
		 }else{
			 addChild(game.cycle);
		 }

	 }

	 public function makePowerUps():void {
		 powerUps = new Array(3);
		 for(i = 0; i < powerUps.length; i ++){
			 storeX = Math.random() * 400 + 50;
			 storeY = Math.random() * 400 + 50;
			 if(!game.options.multiPlayer){
				 while(Math.abs(storeX - game.cycle.getX()) < 25){
					 storeX = Math.random() * 400 + 50;
				 }
				 while(Math.abs(storeY - game.cycle.getY()) < 25){
					 storeY = Math.random() * 400 + 50;
				 }
			 }
			 powerUps[i] = new PowerUp(storeX, storeY, -1, this);
			 addChild(powerUps[i]);
		 }
	 }

	 private function reportKeyUp(event:KeyboardEvent):void{
		 keysDown[event.keyCode] = false;
		 trace("Lifted");
	 }

	 private function reportKeyDown(event:KeyboardEvent):void {
		 keysDown[event.keyCode] = true;
	 }

	 public function drawNumber(num:int):void{
		 //graphics.clear();
		 switch(num){
		 case(3):
			 //graphics.beginBitmapFill(threeImage.bitmapData, countMatrix, true, true);
			 //graphics.drawRect(0, 0, threeImage.bitmapData.width, threeImage.bitmapData.height);

			 threeImage = new Bitmap(bitmapBetter.threeImage.bitmapData);
			 threeImage.x = 210;
			 threeImage.y = 210;
			 addChild(threeImage);
			 break;
		 case(2):
			 removeChild(threeImage);
			 //graphics.beginBitmapFill(twoImage.bitmapData, countMatrix, true, true);
			 //graphics.drawRect(0, 0, twoImage.bitmapData.width, twoImage.bitmapData.height);
			 twoImage = new Bitmap(bitmapBetter.twoImage.bitmapData);
			 twoImage.x = 210;
			 twoImage.y = 210;
			 addChild(twoImage);
			 break;
		 case(1):
			 removeChild(twoImage);
			 //graphics.beginBitmapFill(oneImage.bitmapData, countMatrix, true, true);
			 //graphics.drawRect(0, 0, oneImage.bitmapData.width, oneImage.bitmapData.height);
			 oneImage = new Bitmap(bitmapBetter.oneImage.bitmapData);
			 oneImage.x = 210;
			 oneImage.y = 210;
			 addChild(oneImage);
			 break;
		 case(0):
			removeChild(oneImage);
		 	break;
		 }
		 graphics.endFill();
	 }

	 public function addHole(bounds:Array):void{
		 var hole:UIComponent = new UIComponent();
		 hole.graphics.lineStyle(0, 0x000000, 0.25, false, LineScaleMode.NONE, CapsStyle.SQUARE);
		 hole.graphics.beginFill(0x000000);
		 hole.graphics.moveTo(bounds[0].getX(), bounds[0].getY());
		 for(i = 1; i < bounds.length; i++){
			 hole.graphics.lineTo(bounds[i].getX(), bounds[i].getY())
		 }
		 addChild(hole);
		 holes.push(hole);
	 }

	 public function checkBounds(x:Number, y:Number, ai:Boolean):Boolean{
		 for(i = 0; i < holes.length; i++){
			 var point:Point = holes[i].localToGlobal(new Point(x, y));
			 if(holes[i].hitTestPoint(point.x, point.y, true)){
				 return true;
			 }
		 }
		 return false;
	 }

	 private function powerUpChange(pwr:PowerUp):void {
		var changeit:int = Math.round(Math.random() * 3);
	 	pwr.changeIt(changeit < 4 ? changeit : 3);
	 	storeX = Math.random() * 300 + 100;
	 	storeY = Math.random() * 300 + 100;
	 	pwr.setLocation(storeX, storeY);
		if(pwr.isScorpion()){
			if(game.options.sound){
				scorpSound.play();
			}
			for(i = 0; i < 3; i ++){
				var add:PowerUp = new PowerUp(storeX, storeY, 0, this);
				powerUps.push(add);
				addChild(add);
			}
		 }
	 }


	 public function update():void {
		 if(game.options.multiPlayer){
			 if(keysDown[game.options.dvorak ? 188 : 87]){ //p2 up
				 game.cycles[1].changeHeading(Cycle2.UP);
			 }
			 if(keysDown[game.options.dvorak ? 79 : 83]){ //p2 down
				 game.cycles[1].changeHeading(Cycle2.DOWN);
			 }
			 if(keysDown[game.options.dvorak ? 69 : 68]){ //p2 Right
				 game.cycles[1].changeHeading(Cycle2.RIGHT);
			 }
			 if(keysDown[65]){ //p2 Left
				 game.cycles[1].changeHeading(Cycle2.LEFT);
			 }
			 if(keysDown[38]){ //p1 up
				 game.cycles[0].changeHeading(Cycle2.UP);
			 }
			 if(keysDown[40]){ //p1 down
				 game.cycles[0].changeHeading(Cycle2.DOWN);
			 }
			 if(keysDown[39]){ //p1 right
				 game.cycles[0].changeHeading(Cycle2.RIGHT);
			 }
			 if(keysDown[37]){ //p1 left
				 game.cycles[0].changeHeading(Cycle2.LEFT);
			 }
			 if(game.options.numPlayers > 2){
				 if(keysDown[game.options.dvorak ? 67 : 73]){ //p3 up
					 game.cycles[2].changeHeading(Cycle2.UP);
				 }
				 if(keysDown[game.options.dvorak ? 84 : 75]){ //p3 down
					 game.cycles[2].changeHeading(Cycle2.DOWN);
				 }
				 if(keysDown[game.options.dvorak ? 78 : 76]){ //p3 right
					 game.cycles[2].changeHeading(Cycle2.RIGHT);
				 }
				 if(keysDown[game.options.dvorak ? 72 : 74]){ //p3 left
					 game.cycles[2].changeHeading(Cycle2.LEFT);
				 }
			 }
			 if(game.options.numPlayers > 3){
				 if(keysDown[104]){ //p4 up
					 game.cycles[3].changeHeading(Cycle2.UP);
				 }
				 if(keysDown[100]){ //p4 left
					 game.cycles[3].changeHeading(Cycle2.LEFT);
				 }
				 if(keysDown[102]){ //p4 right
					 game.cycles[3].changeHeading(Cycle2.RIGHT);
				 }
				 if(keysDown[101]){ //p4 down
					 game.cycles[3].changeHeading(Cycle2.DOWN);
				 }
			 }
		 }else {
			 if (keysDown[37]){
				 game.cycle.changeHeading(Cycle2.LEFT);
				 if(game.options.sound){
					 turn.play();
				 }
			 }//left
			 if (keysDown[38]){
				 game.cycle.changeHeading(Cycle2.UP);
				 if(game.options.sound){
					 //speed.play();
				 }
			 }//up
			 if (keysDown[39]){
				 game.cycle.changeHeading(Cycle2.RIGHT);
				 if(game.options.sound){
					 turn.play();
				 }
			 }//right
			 if (keysDown[40]){
				 game.cycle.changeHeading(Cycle2.DOWN);
				 if(game.options.sound){
					 //slow.play();
				 }
			 }//down
		 }

		 if(game.options.powerUp){
			 for each(var pwr:PowerUp in powerUps){
				 if(!game.options.multiPlayer){
					 if(pwr.hitTestPoint(game.cycle.x, game.cycle.y, false)){
						 if(pwr.isScorpion()){
							 game.cycle.blowupB = true;
						 }
						 if(pwr.isIce()){
							 game.cycle.friction = 0.01;
							 change[0] = false;
						 }
						 if(!pwr.isKnown()){
							 powerUpChange(pwr);
						 }
					 }
					 if(pwr.isWalrus()){
						 if(pwr.getBee().hitTestPoint(game.cycle.x, game.cycle.y, false)){
							 game.cycle.blowupB = true;
						 }
					 }
				 }else{
					 for(i = 0; i < game.options.numPlayers; i ++){
						 if(pwr.hitTestPoint(game.cycles[i].x, game.cycles[i].y, false)){
							 if(pwr.isScorpion()){
								 game.cycles[i].blowupB = true;
							 }
							 if(pwr.isIce()){
								 game.cycles[i].friction = 0.01;
								 change[i] = false;
							 }
							 if(!pwr.isKnown()){
								 powerUpChange(pwr);
							 }
						 }
						 if(pwr.isWalrus()){
							 if(pwr.getBee().hitTestPoint(game.cycles[i].x, game.cycles[i].y, false)){
								 game.cycles[i].blowupB = true;
							 }
						 }
					 }
				 }
				 for(i = 0; i < game.options.numAI; i ++){
					 if(game.aCycle[i].hitTestObject(pwr)){
						 if(pwr.isScorpion()){
							 game.aCycle[i].blowupB = true;
						 }
						 if(!pwr.isKnown()){
							 powerUpChange(pwr);
						 }
					 }
					 if(pwr.isWalrus()){
						 if(game.aCycle[i].hitTestObject(pwr.getBee())){
							 game.aCycle[i].blowupB = true;
						 }
					 }
				 }
				 pwr.act();
			 }
		 }
		 if(!game.options.multiPlayer){
			 if(change[0]){
				 game.cycle.friction = game.options.friction;
			 }
			 change[0] = true;
		 }else{
			 for(i = 0; i < change.length; i ++){
				 if(change[i]){
					 game.cycles[i].friction = game.options.friction;
				 }
				 change[i] = true;
			 }
		 }

		 graphics.clear();

		 graphics.beginFill(0x3CB371);
		 graphics.drawRect(10, 10, 510, 510);

		 //Car here
		 if(!game.options.multiPlayer){
			 matrix = game.cycle.transform.matrix;
			 matrix.rotate(game.cycle.getHeading() - prevHeadings[0]);
			 game.cycle.transform.matrix = matrix;
			 game.cycle.x = game.cycle.getX();
			 game.cycle.y = game.cycle.getY();
			 prevHeadings[0] = game.cycle.getHeading();
		 }else{
		 	 for(i = 0; i < game.options.numPlayers; i ++){
		 		 matrix = game.cycles[i].transform.matrix;
				 matrix.rotate(game.cycles[i].getHeading() - prevHeadings[i]);
				 game.cycles[i].transform.matrix = matrix;
				 game.cycles[i].x = game.cycles[i].getX();
				 game.cycles[i].y = game.cycles[i].getY();
				 prevHeadings[i] = game.cycles[i].getHeading();
		 	 }
		 }


		if(!game.options.multiPlayer) {

			 for(i = 0; i < game.options.numAI; i ++){
		 		 matrix = game.aCycle[i].transform.matrix;
				 matrix.rotate(game.aCycle[i].getHeading() - prevAIHeadings[i]);
				 game.aCycle[i].transform.matrix = matrix;
				 game.aCycle[i].x = game.aCycle[i].getX();
				 game.aCycle[i].y = game.aCycle[i].getY();
				 prevAIHeadings[i] = game.aCycle[i].getHeading();
			 }

		 }

		 graphics.endFill();

		 //player line
		 var cur:Node;
		 if(!game.options.multiPlayer){
			 graphics.lineStyle(3, 0x0000FF, 1, true, LineScaleMode.NONE, CapsStyle.SQUARE);
			 cur = game.cycle.getTrail().getNext();
			 graphics.moveTo(cur.getData().getX(), cur.getData().getY());
			 while(cur.getNext() !== game.cycle.getTrail()){
				 cur = cur.getNext();
				 graphics.lineTo(cur.getData().getX(), cur.getData().getY());
			 }
		 }else{
			 graphics.lineStyle(3, 0x6C5697, 1, true, LineScaleMode.NONE, CapsStyle.SQUARE);
			 cur = game.cycles[0].getTrail().getNext();
			 graphics.moveTo(cur.getData().getX(), cur.getData().getY());
			 while(cur.getNext() !== game.cycles[0].getTrail()){
				 cur = cur.getNext();
				 graphics.lineTo(cur.getData().getX(), cur.getData().getY());
			 }

			 graphics.lineStyle(3, 0xFF0000, 1, true, LineScaleMode.NONE, CapsStyle.SQUARE);
			 cur = game.cycles[1].getTrail().getNext();
			 graphics.moveTo(cur.getData().getX(), cur.getData().getY());
			 while(cur.getNext() !== game.cycles[1].getTrail()){
				 cur = cur.getNext();
				 graphics.lineTo(cur.getData().getX(), cur.getData().getY());
			 }

			 if(game.options.numPlayers > 2) {
				 graphics.lineStyle(3, 0xFFFFFF, 1, true, LineScaleMode.NONE, CapsStyle.SQUARE);
				 cur = game.cycles[2].getTrail().getNext();
				 graphics.moveTo(cur.getData().getX(), cur.getData().getY());
				 while(cur.getNext() !== game.cycles[2].getTrail()){
					 cur = cur.getNext();
					 graphics.lineTo(cur.getData().getX(), cur.getData().getY());
				 }
			 }

			 if(game.options.numPlayers > 3){
				 graphics.lineStyle(3, 0xFFD200, 1, true, LineScaleMode.NONE, CapsStyle.SQUARE);
				 cur = game.cycles[3].getTrail().getNext();
				 graphics.moveTo(cur.getData().getX(), cur.getData().getY());
				 while(cur.getNext() !== game.cycles[3].getTrail()){
				 cur = cur.getNext();
				 graphics.lineTo(cur.getData().getX(), cur.getData().getY());
				 }
			 }
		 }
		 //ai line
		if(!game.options.multiPlayer) {
			 graphics.lineStyle(3, 0xFF0000, 1, true, LineScaleMode.NONE, CapsStyle.SQUARE);
			 var h:int;
			 for (h=0; h<game.options.numAI; h++){
				 cur = game.aCycle[h].getTrail().getNext();
				 graphics.moveTo(cur.getData().getX(), cur.getData().getY());
				 while(cur.getNext() !== game.aCycle[h].getTrail()){
					 cur = cur.getNext();
					 graphics.lineTo(cur.getData().getX(), cur.getData().getY());
				 }
			 }
		 }
		 game.window.guiFocus();
	 }
	}
}
