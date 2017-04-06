package Game {

	public class Node {
		private var data:LightPoint;
		private var next:Node;

		public function Node(data:LightPoint){
			this.data = data;
		}

		public function getNext():Node{
			return next;
		}

		public function setNext(node:Node):void{
			next = node;
		}

		public function getData():LightPoint{
			return data;
		}

		public function setData(data:LightPoint):void{
			this.data = data;
		}

		public function getNode(depth:int):Node{
			if(depth <= 0) return this;
			else return next.getNode(depth - 1);
		}
	}
}