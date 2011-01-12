package de.robinz.as3.pcc.chessboard.library
{
	import mx.collections.ArrayCollection;

	/**
	 * Notation
	 *
	 * @author robin heinel
	 */
	public class Notation
	{
		public var row : int;
		public var column : String;
		public static var indexes : ArrayCollection = new ArrayCollection( [ "a", "b", "c", "d", "e", "f", "g", "h" ] );

		public static function createNotationByString( input : String ) : Notation {

			var column : String = input.charAt( 0 ).toLowerCase();
			var row : String = input.charAt( 1 );

			var n : Notation = new Notation();

			n.row = int( row );
			n.column = column;

			return n;
		}

		public function equals( n : Notation ) : Boolean {
			return this.toString() == n.toString();
		}

		public function toString() : String {
			return this.column + row.toString();
		}


	}
}