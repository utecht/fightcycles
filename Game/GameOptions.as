package Game {

	public class GameOptions{
		private var _sound:Boolean = true;  // true if sound is enabled, false if muted
		private var _trailLength:Number = 1000;
		private var _friction:Number = 2;
		private var _speed:Number = 5;
		private var _screenLock:Boolean = false;
		private var _numAI:int = 1;
		private var _difficulty:int = 2;
		private var _multiPlayer:Boolean = false;
		private var _numPlayers:int = 1;
		private var _dvorak:Boolean = false;
		private var _powerUp:Boolean = true;
		private var game:Game;

		public function GameOptions(game:Game){
			this.game=game;
		}

		public function set trailLength(trailLength:Number):void {
			_trailLength = trailLength;
		}

		public function get trailLength():Number {
			return _trailLength;
		}

		public function set friction(friction:Number):void {
			_friction = friction;
		}

		public function get friction():Number {
			return _friction;
		}

		public function set speed(speed:Number):void {
			_speed = speed;
		}

		public function get speed():Number {
			return _speed;
		}

		public function set sound(sound:Boolean):void {
			_sound = sound;
			game.stopMusic();
		}

		public function get sound():Boolean {
			return _sound;
		}

		public function set screenLock(screenLock:Boolean):void {
			_screenLock = screenLock;
		}

		public function get screenLock():Boolean {
			return _screenLock;
		}

		public function set numAI(numAI:int):void {
			_numAI = numAI;
		}

		public function get numAI():int {
			return _numAI;
		}

		public function set difficulty(difficulty:int):void {
			_difficulty = difficulty;
		}

		public function get difficulty():int {
			return _difficulty;
		}

		public function set multiPlayer(multiPlayer:Boolean):void {
			_multiPlayer = multiPlayer;
		}

		public function get multiPlayer():Boolean {
			return _multiPlayer;
		}

		public function set numPlayers(numPlayers:int):void {
			_numPlayers = numPlayers;
		}

		public function get numPlayers():int {
			return _numPlayers;
		}

		public function set dvorak(dvorak:Boolean):void {
			_dvorak = dvorak;
		}

		public function get dvorak():Boolean {
			return _dvorak;
		}

		public function set powerUp(powerUp:Boolean):void {
			_powerUp = powerUp;
		}

		public function get powerUp():Boolean {
			return _powerUp;
		}
	}
}