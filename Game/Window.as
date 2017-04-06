package Game {
    import mx.containers.VBox;
    import mx.controls.Label;
    import mx.events.FlexEvent;
    import flash.events.*;
    import mx.controls.*;

    public class Window extends VBox {
        private var game:Game;
    	private var menu:GameMenu;
    	private var restart:Boolean;

        public function Window() {
            setStyle("backgroundAlpha", 0.0);
            restart = false;

            game = new Game(this);
            menu = new GameMenu(this, game);
            addChild(menu);
        }

        public function resetGame(event:Event):void{
        	game.reset();
        }

        public function guiFocus():void{
        	game.gui.setFocus();
        }

        public function startGame():void {
        	removeChild(menu);
        	game.initWorld();
        	addChild(game.gui);
            game.gui.setFocus();
        }

//        public function startNetGame():void {
//        	removeChild(menu);
//        	game.initNetWorld();
//        	reset = new Button();
//            reset.label = "Reset";
//            reset.addEventListener(MouseEvent.CLICK, resetGame);
//            addChild(reset);
//        	addChild(game.gui);
//            /*game.gui.percentWidth = 100;
//            game.gui.percentHeight = 100;*/
//            addChild(debug);
//            game.gui.setFocus();
//        }

        public function startMultiPlayer():void {
        	removeChild(menu);
        	game.initMultiWorld();
        	addChild(game.gui);
            game.gui.setFocus();
        }

        public function reset():void {
        	removeAllChildren();
        	game.endWorld();
        	menu = new GameMenu(this, game);
        	addChild(menu);
        }
    }
}
