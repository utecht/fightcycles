package Game {
	import flash.display.*;
	import mx.core.*;
	import flash.media.*;
	import flash.events.*;
	import mx.controls.*;
	import flash.net.*;

	public class ScoreBox extends UIComponent{
		private var game:Game;
		private var bitmaper:BitmapBetter;

		private var p10s:Bitmap;
		private var p1s:Bitmap;

		private var r10s:Bitmap;
		private var r1s:Bitmap;

		private var w10s:Bitmap;
		private var w1s:Bitmap;

		private var y10s:Bitmap;
		private var y1s:Bitmap;

		private var menu:Button;

		public function ScoreBox(game:Game, bitmap:BitmapBetter){
			this.game = game;

			menu = new Button();
			menu.x = 275;
			menu.y = 5;
			menu.label = "Menu";
			menu.setStyle("fontSize", 15);
			menu.addEventListener(MouseEvent.CLICK, menuEvent);
			menu.height = 25;
			menu.width = 70;

			this.bitmaper = bitmap;
			p10s = new Bitmap(bitmaper.p0.bitmapData);
			p10s.x = 5;
			p10s.y = 5;
			p10s.height = 25;
			p10s.width = 25;
			addChild(p10s);
			p1s = new Bitmap(bitmaper.p0.bitmapData);
			p1s.x = 35;
			p1s.y = 5;
			p1s.height = 25;
			p1s.width = 25;
			addChild(p1s);

			r10s = new Bitmap(bitmaper.r0.bitmapData);
			r10s.x = 70;
			r10s.y = 5;
			r10s.height = 25;
			r10s.width = 25;
			addChild(r10s);
			r1s = new Bitmap(bitmaper.r0.bitmapData);
			r1s.x = 100;
			r1s.y = 5;
			r1s.height = 25;
			r1s.width = 25;
			addChild(r1s);

			if(game.options.numPlayers > 2 || game.options.numAI > 1){
				w10s = new Bitmap(bitmaper.w0.bitmapData);
				w10s.x = 135;
				w10s.y = 5;
				w10s.width = 25;
				w10s.height = 25;
				addChild(w10s);
				w1s = new Bitmap(bitmaper.w0.bitmapData);
				w1s.x = 165;
				w1s.y = 5;
				w1s.width = 25;
				w1s.height = 25;
				addChild(w1s);

				if(game.options.numPlayers > 3 || game.options.numAI > 2){
					y10s = new Bitmap(bitmaper.y0.bitmapData);
					y10s.x = 195;
					y10s.y = 5;
					y10s.width = 25;
					y10s.height = 25;
					addChild(y10s);
					y1s = new Bitmap(bitmaper.y0.bitmapData);
					y1s.x = 225;
					y1s.y = 5;
					y1s.width = 25;
					y1s.height = 25;
					addChild(y1s);
				}
			}
			addChild(menu);
		}

		public function updateScores():void{
			//Player 1's score "purple"
			var num:int;
			 if(game.options.multiPlayer){
				 num = game.cycles[0].getScore();
			 } else {
				 num = game.cycle.getScore();
			 }
			 num = (num / 10) % 10;
			 removeChild(p10s);
			 switch(num){
			 case(0):
				 p10s = new Bitmap(bitmaper.p0.bitmapData);
				 break;
			 case(1):
			 	 p10s = new Bitmap(bitmaper.p1.bitmapData);
				 break;
			 case(2):
			 	 p10s = new Bitmap(bitmaper.p2.bitmapData);
				 break;
			 case(3):
			 	 p10s = new Bitmap(bitmaper.p3.bitmapData);
				 break;
			 case(4):
			 	 p10s = new Bitmap(bitmaper.p4.bitmapData);
				 break;
			 case(5):
				 removeChild(p10s);
			 	 p10s = new Bitmap(bitmaper.p5.bitmapData);
				 break;
			 case(6):
				 removeChild(p10s);
			 	 p10s = new Bitmap(bitmaper.p6.bitmapData);
				 break;
			 case(7):
				 removeChild(p10s);
			 	 p10s = new Bitmap(bitmaper.p7.bitmapData);
				 break;
			 case(8):
				 removeChild(p10s);
			 	 p10s = new Bitmap(bitmaper.p8.bitmapData);
				 break;
			 case(9):
				 removeChild(p10s);
			 	 p10s = new Bitmap(bitmaper.p9.bitmapData);
				 break;
			 }
			 p10s.x = 5;
			 p10s.y = 5;
			 p10s.height = 25;
			 p10s.width = 25;
			 addChild(p10s);

			 if(game.options.multiPlayer){
				 num = game.cycles[0].getScore();
			 } else {
				 num = game.cycle.getScore();
			 }
			 num = num % 10;
			 removeChild(p1s);
			 switch(num){
			 case(0):
		 	 	 p1s = new Bitmap(bitmaper.p0.bitmapData);
				 break;
			 case(1):
			 	 p1s = new Bitmap(bitmaper.p1.bitmapData);
				 break;
			 case(2):
			 	 p1s = new Bitmap(bitmaper.p2.bitmapData);
				 break;
			 case(3):
			 	 p1s = new Bitmap(bitmaper.p3.bitmapData);
				 break;
			 case(4):
			 	 p1s = new Bitmap(bitmaper.p4.bitmapData);
				 break;
			 case(5):
			 	 p1s = new Bitmap(bitmaper.p5.bitmapData);
				 break;
			 case(6):
			 	 p1s = new Bitmap(bitmaper.p6.bitmapData);
				 break;
			 case(7):
			 	 p1s = new Bitmap(bitmaper.p7.bitmapData);
				 break;
			 case(8):
			 	 p1s = new Bitmap(bitmaper.p8.bitmapData);
				 break;
			 case(9):
			 	 p1s = new Bitmap(bitmaper.p9.bitmapData);
				 break;
			 }
			 p1s.x = 35;
	 	 	 p1s.y = 5;
	 	 	 p1s.width = 25;
	 	 	 p1s.height = 25;
	 	 	 addChild(p1s);

			//Player 2's score "red"
			 if(game.options.multiPlayer){
				 num = game.cycles[1].getScore();
			 } else {
				 num = game.aCycle[0].getScore();
			 }
			 num = (num / 10) % 10;
			 removeChild(r10s);
			 switch(num){
			 case(0):
				 r10s = new Bitmap(bitmaper.r0.bitmapData);
				 break;
			 case(1):
				 r10s = new Bitmap(bitmaper.r1.bitmapData);
				 break;
			 case(2):
				 r10s = new Bitmap(bitmaper.r2.bitmapData);
				 break;
			 case(3):
				 r10s = new Bitmap(bitmaper.r3.bitmapData);
				 break;
			 case(4):
				 r10s = new Bitmap(bitmaper.r4.bitmapData);
				 break;
			 case(5):
				 r10s = new Bitmap(bitmaper.r5.bitmapData);
				 break;
			 case(6):
				 r10s = new Bitmap(bitmaper.r6.bitmapData);
				 break;
			 case(7):
				 r10s = new Bitmap(bitmaper.r7.bitmapData);
				 break;
			 case(8):
				 r10s = new Bitmap(bitmaper.r8.bitmapData);
				 break;
			 case(9):
				 r10s = new Bitmap(bitmaper.r9.bitmapData);
				 break;
			 }
		 	 r10s.x = 70;
		     r10s.y = 5;
		     r10s.height = 25;
		     r10s.width = 25;
		 	 addChild(r10s);

			 if(game.options.multiPlayer){
				 num = game.cycles[1].getScore();
			 } else {
				 num = game.aCycle[0].getScore();
			 }
			 num = num % 10;
			 removeChild(r1s);
			 switch(num){
			 case(0):
				 r1s = new Bitmap(bitmaper.r0.bitmapData);
				 break;
			 case(1):
				 r1s = new Bitmap(bitmaper.r1.bitmapData);
				 break;
			 case(2):
				 r1s = new Bitmap(bitmaper.r2.bitmapData);
				 break;
			 case(3):
				 r1s = new Bitmap(bitmaper.r3.bitmapData);
				 break;
			 case(4):
				 r1s = new Bitmap(bitmaper.r4.bitmapData);
				 break;
			 case(5):
				 r1s = new Bitmap(bitmaper.r5.bitmapData);
				 break;
			 case(6):
				 r1s = new Bitmap(bitmaper.r6.bitmapData);
				 break;
			 case(7):
				 r1s = new Bitmap(bitmaper.r7.bitmapData);
				 break;
			 case(8):
				 r1s = new Bitmap(bitmaper.r8.bitmapData);
				 break;
			 case(9):
				 r1s = new Bitmap(bitmaper.r9.bitmapData);
				 break;
			 }
			 r1s.x = 100;
		 	 r1s.y = 5;
		     r1s.height = 25;
		     r1s.width = 25;
		 	 addChild(r1s);

			 if(game.options.numPlayers > 2 || game.options.numAI > 1){
				 if(game.options.multiPlayer){
					 num = game.cycles[2].getScore();
				 } else {
					 num = game.aCycle[1].getScore();
				 }
				 num = (num / 10) % 10;
				//player 3's score "white"
				 removeChild(w10s);
				 switch(num){
				 case(0):
					 w10s = new Bitmap(bitmaper.w0.bitmapData);
					 break;
				 case(1):
					 w10s = new Bitmap(bitmaper.w1.bitmapData);
					 break;
				 case(2):
					 w10s = new Bitmap(bitmaper.w2.bitmapData);
					 break;
				 case(3):
					 w10s = new Bitmap(bitmaper.w3.bitmapData);
					 break;
				 case(4):
					 w10s = new Bitmap(bitmaper.w4.bitmapData);
					 break;
				 case(5):
					 w10s = new Bitmap(bitmaper.w5.bitmapData);
					 break;
				 case(6):
					 w10s = new Bitmap(bitmaper.w6.bitmapData);
					 break;
				 case(7):
					 w10s = new Bitmap(bitmaper.w7.bitmapData);
					 break;
				 case(8):
					 w10s = new Bitmap(bitmaper.w8.bitmapData);
					 break;
				 case(9):
					 w10s = new Bitmap(bitmaper.w9.bitmapData);
					 break;
				 }
				w10s.x = 135;
				w10s.y = 5;
				w10s.width = 25;
				w10s.height = 25;
				addChild(w10s);

				if(game.options.multiPlayer){
					 num = game.cycles[2].getScore();
				 } else {
					 num = game.aCycle[1].getScore();
				 }
				 num = num % 10;
				 removeChild(w1s);
				 switch(num){
				 case(0):
					 w1s = new Bitmap(bitmaper.w0.bitmapData);
					 break;
				 case(1):
					 w1s = new Bitmap(bitmaper.w1.bitmapData);
					 break;
				 case(2):
				 	 w1s = new Bitmap(bitmaper.w2.bitmapData);
					 break;
				 case(3):
				 	 w1s = new Bitmap(bitmaper.w3.bitmapData);
					 break;
				 case(4):
				 	 w1s = new Bitmap(bitmaper.w4.bitmapData);
					 break;
				 case(5):
					 w1s = new Bitmap(bitmaper.w5.bitmapData);
					 break;
				 case(6):
				 	 w1s = new Bitmap(bitmaper.w6.bitmapData);
					 break;
				 case(7):
					 w1s = new Bitmap(bitmaper.w7.bitmapData);
					 break;
				 case(8):
					 w1s = new Bitmap(bitmaper.w8.bitmapData);
					 break;
				 case(9):
					 w1s = new Bitmap(bitmaper.w9.bitmapData);
					 break;
				 }
				 w1s.x = 165;
				 w1s.y = 5;
				 w1s.height = 25;
				 w1s.width = 25;
				 addChild(w1s);


			 }

			 if(game.options.numPlayers > 3 || game.options.numAI > 2){
				//Player 4's score "yellow"
				 if(game.options.multiPlayer){
					 num = game.cycles[3].getScore();
				 } else {
					 num = game.aCycle[2].getScore();
				 }
				 num = (num / 10) % 10;
				 removeChild(y10s);
				 switch(num){
				 case(0):
					 y10s = new Bitmap(bitmaper.y0.bitmapData);
					 break;
				 case(1):
					 y10s = new Bitmap(bitmaper.y1.bitmapData);
					 break;
				 case(2):
					 y10s = new Bitmap(bitmaper.y2.bitmapData);
					 break;
				 case(3):
					 y10s = new Bitmap(bitmaper.y3.bitmapData);
					 break;
				 case(4):
					 y10s = new Bitmap(bitmaper.y4.bitmapData);
					 break;
				 case(5):
					 y10s = new Bitmap(bitmaper.y5.bitmapData);
					 break;
				 case(6):
					 y10s = new Bitmap(bitmaper.y6.bitmapData);
					 break;
				 case(7):
					 y10s = new Bitmap(bitmaper.y7.bitmapData);
					 break;
				 case(8):
					 y10s = new Bitmap(bitmaper.y8.bitmapData);
					 break;
				 case(9):
					y10s = new Bitmap(bitmaper.y9.bitmapData);
					break;
				 }
				y10s.x = 195;
				y10s.y = 5;
				y10s.width = 25;
				y10s.height = 25;
				addChild(y10s);

				if(game.options.multiPlayer){
					 num = game.cycles[3].getScore();
				 } else {
					 num = game.aCycle[2].getScore();
				 }
				 num = num % 10;
				 removeChild(y1s);
				 switch(num){
				 case(0):
					 y1s = new Bitmap(bitmaper.y0.bitmapData);
					 break;
				 case(1):
					 y1s = new Bitmap(bitmaper.y1.bitmapData);
					 break;
				 case(2):
					 y1s = new Bitmap(bitmaper.y2.bitmapData);
					 break;
				 case(3):
					 y1s = new Bitmap(bitmaper.y3.bitmapData);
					 break;
				 case(4):
					 y1s = new Bitmap(bitmaper.y4.bitmapData);
					 break;
				 case(5):
					 y1s = new Bitmap(bitmaper.y5.bitmapData);
					 break;
				 case(6):
					 y1s = new Bitmap(bitmaper.y6.bitmapData);
					 break;
				 case(7):
				 	 y1s = new Bitmap(bitmaper.y7.bitmapData);
					 break;
				 case(8):
					 y1s = new Bitmap(bitmaper.y8.bitmapData);
					 break;
				 case(9):
					 y1s = new Bitmap(bitmaper.y9.bitmapData);
					 break;
				 }
				y1s.x = 225;
				y1s.y = 5;
				y1s.height = 25;
				y1s.width = 25;
				addChild(y1s);
			 }
		}

		private function menuEvent(event:Event):void {
			if(menu.label == "Are you sure?"){
				//game.stopTimer();
				//game.window.reset();
				flash.net.navigateToURL(new URLRequest("http://ozark.hendrix.edu/odyssey/cycles/index.php"), "_self");
			}else{
				menu.x = 275;
				menu.width = 150;
				menu.label = "Are you sure?";
			}
		}
	}
}