package de.robinz.as3.pcc.chessboard.library
{
	import mx.utils.ObjectUtil;

	/**
	 * Notation
	 *
	 * @author robin heinel
	 */
	public class Notation
	{
		public var row : String;
		public var column : int;

		public static function createNotationByString( input : String ) : Notation {

			var row : String = input.charAt( 0 ).toLowerCase();
			var column : String = input.charAt( 1 );

			var n : Notation = new Notation();

			n.row = row;
			n.column = int( column );

			return n;
		}

		public function equals( n : Notation ) : Boolean {
			return this.toString() == n.toString();
		}

		public function toString() : String {
			return this.row + column.toString();
		}


	}
}