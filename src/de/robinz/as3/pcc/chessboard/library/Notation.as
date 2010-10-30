package de.robinz.as3.pcc.chessboard.library
{
	public class Notation
	{
		public var row : String;
		public var column : String;

		public static function createNotationByString( input : String ) : Notation {

			var row : String = input.charAt( 0 ).toLowerCase();
			var column : String = input.charAt( 1 );

			var n : Notation = new Notation();

			n.row = row;
			n.column = column;

			return n;
		}



	}
}