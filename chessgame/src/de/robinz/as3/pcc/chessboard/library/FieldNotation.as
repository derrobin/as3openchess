package de.robinz.as3.pcc.chessboard.library
{
import mx.collections.ArrayCollection;
import mx.logging.ILogger;
import mx.logging.Log;

/**
 * Notation
 *
 * @author robin heinel
 */
public class FieldNotation
{
	private static const LOGGER : String = "FieldNotation";
	private static var log : ILogger = Log.getLogger( LOGGER );

	public var row : int;
	public var column : String;
	public static var indexes : ArrayCollection = new ArrayCollection( [ "a", "b", "c", "d", "e", "f", "g", "h" ] );

	public var name : String = "noname";

	public static function checkSetColumn( column : String, value : int ) : Boolean {
		return getColumn( column, value ) != null;
	}

	public static function getColumn( current : String, value : int ) : String {
		var i : int = indexes.getItemIndex( current );
		var index : int = i + value;

		if ( index < 0 ) {
			return null;
		}

		if ( index > indexes.length - 1 ) {
			return null;
		}

		var n : Object = indexes.getItemAt( index < 0 ? 0 : index );
		if ( n == null ) {
			return null;
		}

		return n as String;
	}

	public static function checkSetRow( row : int, value : int ) : Boolean {
		return getRow( row, value ) != -1;
	}

	public static function getRow( current : int, value : int ) : int {
		var n : int = current + value;
		if ( n < 1 || n > 8 ) {
			return -1;
		}

		return n;
	}

	public static function createNotationByString( input : String, name : String = null ) : FieldNotation {
		var column : String = input.charAt( 0 ).toLowerCase();
		var row : int = int( input.charAt( 1 ) );

		row = getRow( row, 0 );
		column = getColumn( column, 0 );

		if ( row == -1 ) {
			log.warn( "createNotationByString: unvalid row input." );
			return null;
		}
		if ( ! indexes.contains( column ) ) {
			log.warn( "createNotationByString: unvalid column input." );
			return null;
		}

		var n : FieldNotation = new FieldNotation();
		n.column = column;
		n.row = row;
		n.name = name;

		return n;
	}

	public function setRow( value : int ) : void {
		var row : int = getRow( this.row, value );
		if ( row == -1 ) {
			log.warn( "unvalid row update current: {0} set: {1} !", this.row.toString(), value.toString() );
			return;
		}

		this.row = row;
	}

	public function setColumn( value : int ) : void {
		var column : String = getColumn( this.column, value );
		if ( column == null ) {
			log.warn( "unvalid column update current: {0} set: {1} !", this.column, value.toString() );
			return;
		}

		this.column = column;
	}

	public function clone() : FieldNotation {
		var o : FieldNotation = new FieldNotation();
		o.column = this.column;
		o.row = this.row;
		return o;
	}

	public function get columnIndex() : int {
		return indexes.getItemIndex( this.column );
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