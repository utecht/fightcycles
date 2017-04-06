package Game{
	import flash.events.*;
    import flash.utils.Timer;
    import mx.events.FlexEvent;
    import flash.media.Sound;
    import flash.media.SoundChannel;

	public class Game {
		public var cycle:Cycle2;
		public var cycles:Array;
		public var aCycle:Array;
		public var gui:GUI;
		public var window:Window;
		private var timer:Timer;
		public var options:GameOptions;
		public var scorpions:Array;
		public var scorpionsB:Boolean;
		[Embed(source="Scorpions.mp3")]
		public var scorpSound0:Class;
		public var scorpSound:Sound = new scorpSound0() as Sound;
		[Embed(source="background.mp3")]
		public var backSound:Class;
		public var back:Sound = new backSound() as Sound;
		private var startup:Function;
		private var countDownTimer:Timer;
		private var delay:int;
		public var numPlayers:int = 2;
		public var musicPlay:Boolean=true;
		public var channel:SoundChannel;
		private var i:int;
		private var countDownOffset:int;

		public function Game(window:Window){
			this.window = window;
			this.options = new GameOptions(this);

			delay = 3;
			channel=back.play(0,100000);
			countDownOffset = 0;
		}

		public function initWorld():void {
			gui = new GUI(this);
			cycle=new Cycle2(510, 510, (Math.PI*5)/4, 1, 1, this, "purple", 0);
			aCycle =new Array(4);
			aCycle[0]=new AICycle(10, 10, (Math.PI)/4, 1, 1, this);
			aCycle[1]=new AICycle(10, 510, (Math.PI*3)/4, 1, 1, this);
			aCycle[2]=new AICycle(510, 10, (Math.PI*3)/4, 1, 1, this);
			scorpions = new Array(4);
			scorpionsB = false;

            this.timer = new Timer(40);
            timer.addEventListener(TimerEvent.TIMER, tick);

            countDownTimer = new Timer(40);
            countDownTimer.addEventListener(TimerEvent.TIMER, countDown);
            gui.gameStart();

            startup = timer.start;
            countDownTimer.start();
        }

		public function endWorld():void{
			gui = null;
			if(options.multiPlayer){
				cycles[0] = null;
				cycles[1] = null;
				if(options.numPlayers > 2) cycles[2] = null;
				if(options.numPlayers > 3) cycles[3] = null;
			} else {
				cycle = null;
				aCycle[0] = null;
				aCycle[1] = null;
				aCycle[2] = null;
			}
			scorpions = null;
			timer = null;
			countDownTimer = null;
		}

		public function initMultiWorld():void{
			gui = new GUI(this);
			cycles = new Array(numPlayers);
			cycles[0] = new Cycle2(10, 260, 0, 1, 0, this, "purple", 0);
			cycles[1] = new Cycle2(510, 260, Math.PI, 1, 0, this, "red", 0);
			if(options.numPlayers > 2) cycles[2] = new Cycle2(260, 10, Math.PI / 2, 1, 0, this, "white", 0);
			if(options.numPlayers > 3) cycles[3] = new Cycle2(260, 510, Math.PI * 3 / 2, 1, 0, this, "yellow", 0);

			scorpions = new Array(4);
			scorpionsB = false;

			this.timer = new Timer(40);
			timer.addEventListener(TimerEvent.TIMER, tick);

			countDownTimer = new Timer(40);
            countDownTimer.addEventListener(TimerEvent.TIMER, countDown);
			gui.gameStart();

			startup = timer.start;
			countDownTimer.start();
		}

		public function reset():void{
			timer.stop();
			delay = 3;
			startup = timerStart;
			countDownOffset = 0;
			countDownTimer.start();
		}

		private function timerStart():void{
			gui.reset();
			if(!options.multiPlayer){
				cycle.reset(510, 510, (Math.PI*5)/4, 1, 1);
				aCycle[0].reset(10, 10, (Math.PI) / 4, 1, 1);
				aCycle[1].reset(10, 510, (Math.PI * 3) / 4, 1, 1);
				aCycle[2].reset(510, 10, (Math.PI * 3) / 4, 1, 1);
			} else if(options.multiPlayer){
				cycles[0] = new Cycle2(10, 260, 0, 1, 0, this, "purple", cycles[0].getScore());
				cycles[1] = new Cycle2(510, 260, Math.PI, 1, 0, this, "red", cycles[1].getScore());
				if(options.numPlayers > 2) cycles[2] = new Cycle2(260, 10, Math.PI / 2, 1, 0, this, "white", cycles[2].getScore());
				if(options.numPlayers > 3) cycles[3] = new Cycle2(260, 510, Math.PI * 3 / 2, 1, 0, this, "yellow", cycles[3].getScore());
			}
            timer.start();
		}
		public function stopMusic():void{
			if (options.sound && !musicPlay){
				channel=back.play(0,100000);
				musicPlay=true;
			}
			if(!options.sound && musicPlay){
				channel.stop();
				musicPlay=false;
			}
		}

		public function countDown(event:TimerEvent):void{
			if(countDownOffset % 25 === 0){
				gui.drawNumber(delay);
				if(delay <= 0){
					startup();
					gui.addStuff();
					countDownTimer.stop();
				}
				delay--;
			}
			if(options.multiPlayer){
 				for(i = 0; i < options.numPlayers; i ++){
	 				if(!cycles[i].render){
	 					gui.removeChild(cycles[i]);
	 					gui.addChild(cycles[i]);
	 					cycles[i].cycleImage.scaleX = (cycles[i].cycleImage.scaleX <= 0) ? cycles[i].cycleImage.scaleX : cycles[i].cycleImage.scaleX - .01;
	 					cycles[i].cycleImage.scaleY = (cycles[i].cycleImage.scaleY <= 0) ? cycles[i].cycleImage.scaleY : cycles[i].cycleImage.scaleY - .01;
	 				}
 				}
 			}else{
 				if(!cycle.render){
 					gui.removeChild(cycle);
 					gui.addChild(cycle);
 					cycle.cycleImage.scaleX = (cycle.cycleImage.scaleX <= 0) ? cycle.cycleImage.scaleX : cycle.cycleImage.scaleX - .01;
 					cycle.cycleImage.scaleY = (cycle.cycleImage.scaleY <= 0) ? cycle.cycleImage.scaleY : cycle.cycleImage.scaleY - .01;
 				}
 			}
 			if(!options.multiPlayer) {
		 		var h:int;
	 			for(h = 0; h < options.numAI; h++){
	 				if(!aCycle[h].render){
	 					gui.removeChild(aCycle[h]);
	 					gui.addChild(aCycle[h]);
	 					aCycle[h].cycleImage.scaleX = (aCycle[h].cycleImage.scaleX <= 0) ? aCycle[h].cycleImage.scaleX : aCycle[h].cycleImage.scaleX - .01;
 	 					aCycle[h].cycleImage.scaleY = (aCycle[h].cycleImage.scaleY <= 0) ? aCycle[h].cycleImage.scaleY : aCycle[h].cycleImage.scaleY - .01;
	 				}
				}
 			}
 			gui.update();
			countDownOffset++;
		}

		private function tick(event:TimerEvent):void {
			var playerCount:int = 0;
 			if(options.multiPlayer){
 				for(i = 0; i < options.numPlayers; i ++){
	 				if(cycles[i].render){
	 					cycles[i].update();
	 					playerCount++;
	 				}else{
	 					gui.removeChild(cycles[i]);
	 					gui.addChild(cycles[i]);
	 					cycles[i].cycleImage.scaleX = (cycles[i].cycleImage.scaleX <= 0) ? cycles[i].cycleImage.scaleX : cycles[i].cycleImage.scaleX - .01;
		 				cycles[i].cycleImage.scaleY = (cycles[i].cycleImage.scaleY <= 0) ? cycles[i].cycleImage.scaleY : cycles[i].cycleImage.scaleY - .01;
	 				}
 				}
 			}else{
 				if(cycle.render){
 					cycle.update();
 					playerCount++;
 				}else{
 					gui.removeChild(cycle);
 					gui.addChild(cycle);
 					cycle.cycleImage.scaleX = (cycle.cycleImage.scaleX <= 0) ? cycle.cycleImage.scaleX : cycle.cycleImage.scaleX - .01;
 					cycle.cycleImage.scaleY = (cycle.cycleImage.scaleY <= 0) ? cycle.cycleImage.scaleY : cycle.cycleImage.scaleY - .01;
 				}
 			}
 			if(!options.multiPlayer) {
		 		var h:int;
 				var aicount:int = 0;
	 			for (h=0; h<options.numAI; h++){
	 				if(aCycle[h].render){
	 					aCycle[h].update();
	 					aicount = 1;
	 				}else{
	 					gui.removeChild(aCycle[h]);
	 					gui.addChild(aCycle[h]);
	 					aCycle[h].cycleImage.scaleX = (aCycle[h].cycleImage.scaleX <= 0) ? aCycle[h].cycleImage.scaleX : aCycle[h].cycleImage.scaleX - .01;
 	 					aCycle[h].cycleImage.scaleY = (aCycle[h].cycleImage.scaleY <= 0) ? aCycle[h].cycleImage.scaleY : aCycle[h].cycleImage.scaleY - .01;
	 				}
				}
	 			playerCount += aicount;

 			}
 			if(playerCount <= 1) reset();

 			if(scorpionsB){
 				if(options.sound){
 					scorpSound.play();
 	    		}
 				for each(var scorpion:PowerUp in scorpions){
 					scorpion.act();
 				}
 			}
 			gui.update();
 		}
	}
}