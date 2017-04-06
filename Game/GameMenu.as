package Game {
	import mx.core.UIComponent;
	import mx.events.*;
	import flash.display.*;
	import flash.events.*;
	import flash.geom.Matrix;
	import flash.utils.*;
	import mx.core.*;
	import mx.controls.*;
	import mx.containers.*;
    import flash.media.Sound;
    import flash.media.SoundChannel;


	public class GameMenu extends Panel {
		private var window:Window;
		private var button0:Button, button1:Button, button2:Button, button3:Button, soundButton:Button, dvorakButton:Button, powerUp:Button;
		private var header:Label;
		private var area:Text, credits:Text;
		private var coloring:uint;
		private var image:BitmapAsset;
		private var picBitmapData:BitmapData;
		private var matrix:Matrix;
		private var maxW:int, maxH:int;
		private var sound:HBox, holder:Box;
		private var alphaArray:Array, colorArray:Array;
		private var screenOn:String, screenOff:String, dvorak:String, qwerty:String, powerOn:String, powerOff:String;
		private var game:Game;
		[Embed(source="intro.mp3")]
		public var introSound:Class;
		public var intro:Sound = new introSound() as Sound;
		[Embed(source="CycleYellow2.png")]
		private var imgClas:Class;
		private var scale:Number;

		[Embed(source="speaker.png")]
		private var soundClass:Class;

		[Embed(source="noSound.png")]
		private var noSound:Class;

		public function GameMenu(window:Window, game:Game) {
			this.window = window;
			this.game = game;
			screenOn = "Lock Screen on Cycle: On";
			screenOff = "Lock Screen on Cycle: Off";
			dvorak = "Dvorak";
			qwerty = "QWERTY";
			powerOn = "PowerUps On";
			powerOff = "PowerUps Off";
			image = new imgClas() as BitmapAsset;
			matrix = new Matrix();
			maxW = 520;
			maxH = 570;
			coloring = 0x718792;
			var buttonWidth:int = 30;

			this.setStyle("horizontalAlign", "center");
			this.setStyle("verticalAlign", "middle");
			this.setStyle("backgroundAlpha", 0);
			this.setStyle("borderAlpha", 0);

			this.percentWidth = 100;
			this.percentHeight = 100;

			alphaArray = new Array(2);
			alphaArray[0] = 1;
			alphaArray[1] = 1;

			colorArray = new Array(2);
			colorArray[0] = 0xBEBEBE;
			colorArray[1] = 0xFFFFFF;

			button0 = new Button();
			button0.setStyle("fillColors", colorArray);
			button0.setStyle("fillAlphas", alphaArray);
			button0.setStyle("fontSize", 15);
			button0.setStyle("themeColor", "haloBlue");
			button0.setStyle("borderColor",coloring);
			button0.percentWidth = buttonWidth;

			button1 = new Button();
			button1.setStyle("fillColors", colorArray);
			button1.setStyle("fillAlphas", alphaArray);
			button1.setStyle("fontSize", 15);
			button1.setStyle("themeColor", "haloBlue");
			button1.setStyle("borderColor",coloring);
			button1.percentWidth = buttonWidth;

			button2 = new Button();
			button2.setStyle("fillColors", colorArray);
			button2.setStyle("fillAlphas", alphaArray);
			button2.setStyle("fontSize", 15);
			button2.setStyle("themeColor", "haloBlue");
			button2.setStyle("borderColor",coloring);
			button2.percentWidth = buttonWidth;

			button3 = new Button();
			button3.setStyle("fillColors", colorArray);
			button3.setStyle("fillAlphas", alphaArray);
			button3.setStyle("fontSize", 15);
			button3.setStyle("themeColor", "haloBlue");
			button3.setStyle("borderColor",coloring);
			button3.percentWidth = buttonWidth;

			header = new Label();
			header.setStyle("fontSize", 25);
			header.setStyle("textDecoration", "underline");
			header.maxWidth = maxW;

			area = new Text();
			area.setStyle("textAlign", "center");
			area.setStyle("fontSize",20);
			area.maxWidth = maxW-100;

			credits = new Text();
			credits.setStyle("textAlign", "left");
			credits.setStyle("fontSize", 15);
			credits.maxWidth = maxW - 100;

			addEventListener(FlexEvent.CREATION_COMPLETE, makeSoundButton);

			drawPage();
			intro.play();
		}

		private function drawPage():void {
			graphics.clear();
			graphics.beginFill(coloring);
			graphics.drawRect(0, 0, maxW, maxH);
			graphics.endFill();

			picBitmapData = image.bitmapData;
			scale = 0.5;
			matrix.scale(scale, scale);
			matrix.rotate(Math.PI);
			matrix.translate(10 + scale * picBitmapData.width, 10 + scale * picBitmapData.height);
			graphics.beginBitmapFill(picBitmapData, matrix, false, true);
			graphics.drawRect(10, 10, scale * picBitmapData.width, scale * picBitmapData.height);
			graphics.endFill();

			matrix = new Matrix();
			matrix.scale(scale, scale);
			matrix.translate(maxW - 20 - scale * picBitmapData.width, maxH - 20 - scale * picBitmapData.height);
			graphics.beginBitmapFill(picBitmapData, matrix, false, true);
			graphics.drawRect(maxW - 20 - scale * picBitmapData.width, maxH - 20 - scale * picBitmapData.height, scale * picBitmapData.width, scale * picBitmapData.height);
			graphics.endFill();
		}

		private function makeSoundButton(event:Event):void {
			sound = new HBox();
			sound.percentHeight = 10;
			sound.percentWidth = 100;
			sound.setStyle("horizontalAlign", "right");
			sound.setStyle("verticalAlign","top");
			soundButton = new Button();
			soundButton.setStyle("fillColors", colorArray);
			soundButton.setStyle("fillAlphas", alphaArray);
			soundButton.setStyle("fontSize", 15);
			soundButton.setStyle("themeColor", "haloBlue");
			soundButton.setStyle("borderColor",coloring);
			if(game.options.sound){
				soundButton.setStyle("icon", soundClass);
			}else{
				soundButton.setStyle("icon", noSound);
			}
			dvorakButton = new Button();
			dvorakButton.setStyle("fillColors", colorArray);
			dvorakButton.setStyle("fillAlphas", alphaArray);
			dvorakButton.setStyle("fontSize", 15);
			dvorakButton.setStyle("themeColor", "haloBlue");
			dvorakButton.setStyle("borderColor",coloring);
			if(game.options.dvorak){
				dvorakButton.label = dvorak;
			}else{
				dvorakButton.label = qwerty;
			}
			powerUp = new Button();
			powerUp.setStyle("fillColors", colorArray);
			powerUp.setStyle("fillAlphas", alphaArray);
			powerUp.setStyle("fontSize", 15);
			powerUp.setStyle("themeColor", "haloBlue");
			powerUp.setStyle("borderColor",coloring);
			if(game.options.powerUp){
				powerUp.label = powerOn;
			}else{
				powerUp.label = powerOff;
			}

			soundButton.addEventListener(MouseEvent.CLICK, soundToggle);
			dvorakButton.addEventListener(MouseEvent.CLICK, keyToggle);
			powerUp.addEventListener(MouseEvent.CLICK, powerToggle);
			sound.addChild(soundButton);
			sound.addChild(dvorakButton);
			sound.addChild(powerUp);

			holder = new Box();
			holder.setStyle("horizontalAlign", "center");
			holder.setStyle("verticalAlign", "middle");
			holder.percentHeight = 85;
			holder.percentWidth = 100;
			this.addChild(sound);
			this.addChild(holder);
			startMenuFunction();
		}

		private function soundToggle(event:Event):void {
			if(soundButton.getStyle("icon") == soundClass){
				soundButton.setStyle("icon", noSound);
				game.options.sound = false;
			}else{
				soundButton.setStyle("icon", soundClass);
				game.options.sound = true;
			}
		}

		public function keyToggle(event:Event):void {
			if(dvorakButton.label == qwerty){
				game.options.dvorak = true;
				dvorakButton.label = dvorak;
			}else{
				game.options.dvorak = false;
				dvorakButton.label = qwerty;
			}
		}

		public function powerToggle(event:Event):void {
			if(powerUp.label == powerOff){
				game.options.powerUp = true;
				powerUp.label = powerOn;
			}else{
				game.options.powerUp = false;
				powerUp.label = powerOff;
			}
		}

		public function startMenu(event:Event):void {
			startMenuFunction();
		}

		public function startMenuFunction():void {
			removeStuff();
			holder.percentHeight = 65;
			credits.percentHeight = 20;
			credits.percentWidth = 100;
			header.text = "Course of Action";
			var singlePlayer:Button = button0;
			singlePlayer.label = "Start Single Player Game";
			singlePlayer.addEventListener(MouseEvent.CLICK, difficulty);
			var multiPlayer:Button = button1;
			multiPlayer.label = "Start Multi Player Game";
			multiPlayer.addEventListener(MouseEvent.CLICK, multiPlayerGame);
			credits.text = "Don Bennett\nWhitney Maguffee\nChris Schulze\nJoseph Utecht";
			credits.x = 100;
			credits.y = 300;
			holder.addChild(header);
			holder.addChild(singlePlayer);
			holder.addChild(multiPlayer);
			addChild(credits);
		}

		public function multiPlayerGame(event:Event):void {
			removeStuff();
			game.options.numAI = 0;
			header.text = "Multi Player Game";
			var twoPlayer:Button = button0;
			twoPlayer.label = "Two Player Game";
			twoPlayer.addEventListener(MouseEvent.CLICK, twoPlayerGame);
			var threePlayer:Button = button1;
			threePlayer.label = "Three Player Game";
			threePlayer.addEventListener(MouseEvent.CLICK, threePlayerGame);
			var fourPlayer:Button = button2;
			fourPlayer.label = "Four Player Game";
			fourPlayer.addEventListener(MouseEvent.CLICK, fourPlayerGame);
			var start:Button = button3;
			start.label = "Back";
			start.addEventListener(MouseEvent.CLICK, startMenu);
			holder.addChild(header);
			holder.addChild(twoPlayer);
			holder.addChild(threePlayer);
			holder.addChild(fourPlayer);
			holder.addChild(start);
		}

		public function twoPlayerGame(event:Event):void {
			game.options.multiPlayer = true;
			game.options.numPlayers = 2;
			window.startMultiPlayer();
		}

		public function threePlayerGame(event:Event):void {
			game.options.multiPlayer = true;
			game.options.numPlayers = 3;
			window.startMultiPlayer();
		}

		public function fourPlayerGame(event:Event):void {
			game.options.multiPlayer = true;
			game.options.numPlayers = 4;
			window.startMultiPlayer();
		}

		public function changeLock(event:Event):void {
			if(button0.label === screenOff){
				button0.label = screenOn;
			}else{
				button0.label = screenOff;
			}
			game.options.screenLock = !game.options.screenLock;
		}

		public function removeStuff():void {
			if(contains(credits)){
				removeChild(credits);
			}
			holder.percentHeight = 85;
			holder.removeAllChildren();
			button0.removeEventListener(MouseEvent.CLICK, startMenu);
			button0.removeEventListener(MouseEvent.CLICK, easy);
			button0.removeEventListener(MouseEvent.CLICK, twoPlayerGame);
			button0.removeEventListener(MouseEvent.CLICK, changeLock);
			button0.removeEventListener(MouseEvent.CLICK, difficulty);
			button1.removeEventListener(MouseEvent.CLICK, multiPlayerGame);
			button1.removeEventListener(MouseEvent.CLICK, medium);
			button1.removeEventListener(MouseEvent.CLICK, startMenu);
			button1.removeEventListener(MouseEvent.CLICK, threePlayerGame);
			button2.removeEventListener(MouseEvent.CLICK, fourPlayerGame);
			button2.removeEventListener(MouseEvent.CLICK, startMenu);
			button2.removeEventListener(MouseEvent.CLICK, difficult);
			button3.removeEventListener(MouseEvent.CLICK, startMenu);
		}

		public function difficulty(event:Event):void {
			removeStuff();
			game.options.multiPlayer = false;
			game.options.numPlayers = 1;
			header.text = "Choose your level of difficulty";
			var easyButton:Button = button0;
			easyButton.label = "Easy";
			easyButton.addEventListener(MouseEvent.CLICK, easy);
			var mediumButton:Button = button1;
			mediumButton.label = "Medium";
			mediumButton.addEventListener(MouseEvent.CLICK, medium);
			var difficultButton:Button = button2;
			difficultButton.label = "Difficult";
			difficultButton.addEventListener(MouseEvent.CLICK, difficult);
			var back:Button = button3;
			back.label = "Back";
			back.addEventListener(MouseEvent.CLICK, startMenu);
			holder.addChild(header);
			holder.addChild(easyButton);
			holder.addChild(mediumButton);
			holder.addChild(difficultButton);
			holder.addChild(back);
		}

		public function easy(event:Event):void {
			game.options.difficulty = Math.random() > 0.5 ? 1 : 2;
			game.options.numAI = 1;
			game.options.friction = 4;
			game.options.speed = 4;
			game.options.multiPlayer = false;
			window.startGame();
		}

		public function medium(event:Event):void {
			game.options.difficulty = Math.random() > 0.5 ? 1 : 2;
			game.options.numAI = 2;
			game.options.friction = 2;
			game.options.speed = 5;
			game.options.multiPlayer = false;
			window.startGame();
		}

		public function difficult(event:Event):void {
			game.options.difficulty = Math.random() > 0.5 ? 1 : 2;
			game.options.numAI = 3;
			game.options.friction = 1;
			game.options.speed = 7;
			game.options.multiPlayer = false;
			window.startGame();
		}
	}
}