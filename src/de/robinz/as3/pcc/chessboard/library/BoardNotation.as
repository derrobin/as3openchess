package de.robinz.as3.pcc.chessboard.library
{
	public class BoardNotation
	{
		public var row : String;
		public var column : String;

		public static function createNotationByString( input : String ) : BoardNotation {

			var row : String = input.charAt( 0 ).toLowerCase();
			var column : String = input.charAt( 1 );

			var n : BoardNotation = new BoardNotation();

			n.row = row;
			n.column = column;

			return n;
		}



	}
}