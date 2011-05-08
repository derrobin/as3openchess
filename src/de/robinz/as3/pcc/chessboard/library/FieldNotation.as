package de.robinz.as3.pcc.chessboard.library
{
import mx.collections.ArrayCollection;

/**
 * Notation
 *
 * @author robin heinel
 */
public class FieldNotation
{
	public var row : int;
	public var column : String;
	public static var indexes : ArrayCollection = new ArrayCollection( [ "a", "b", "c", "d", "e", "f", "g", "h" ] );

	public static function createNotationByString( input : String ) : FieldNotation {

		var column : String = input.charAt( 0 ).toLowerCase();
		var row : String = input.charAt( 1 );

		var n : FieldNotation = new FieldNotation();

		n.row = int( row );
		n.column = column;

		return n;
	}

	public function equals( n : FieldNotation ) : Boolean {
		return this.toString() == n.toString();
	}

	public function getNotation() : String {
		return this.column + row.toString();
	}

	public function toString() : String {
		return this.getNotation();
	}


}
}