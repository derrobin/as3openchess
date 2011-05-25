package de.robinz.as3.pcc.chessboard.library
{
import de.robinz.as3.pcc.chessboard.library.vo.ChessboardFieldVO;

import de.robinz.as3.pcc.chessboard.library.vo.PiecePositionVOCollection;
import de.robinz.as3.pcc.chessboard.view.views.chessboard.ChessboardFieldCollection;

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

	public static function createNotationByString( input : String ) : FieldNotation {
		try {
			var column : String = input.charAt( 0 ).toLowerCase();
			var row : String = input.charAt( 1 );
			var r : int = int( row );

			if ( r < 1 || r > 8 ) {
				log.warn( "createNotationByString: unvalid row input." );
				return null;
			}
			if ( ! indexes.contains( column ) ) {
				log.warn( "createNotationByString: unvalid column input." );
				return null;
			}

			var n : FieldNotation = new FieldNotation();
			n.column = column;
			n.row = r;

			return n;

		} catch( e : Error ) {
			log.error( "createNotationByString: reason: {0}", e.message );
			log.debug( "createNotationByString: stacktrace: {0}", e.getStackTrace() );
			return null;
		}

		return null;
	}

	public function checkRowSet( value : int ) : Boolean {
		var n : int = this.row + value;
		if ( n < 1 || n > 8 ) {
			return false;
		}
		return true;
	}

	public function setRow( value : int ) {
		if ( ! checkRowSet( value ) ) {
			log.warn( "unvalid row update ( {0} ) !", n );
			return;
		}

		// TODO: refactoring set checkRowSet()
		var n : int = this.row + value;
		this.row = n;
	}

	public function checkSetColumn( value : int ) : Boolean {
		var i : int = indexes.getItemIndex( this.column );
		var index : int = i + value;
		if( index < 0 ) {
			return false;
		}

		if ( index > indexes.length - 1 ) {
			return false;
		}
		var n : Object = indexes.getItemAt( index < 0 ? 0 : index );
		if ( n == null ) {
			return false;
		}

		return true;
	}

	public function setColumn( value : int ) {
		if ( ! checkSetColumn( value ) ) {
			log.warn( "unvalid column update ( {0} ) !", n );
			return;
		}

		// TODO: refactoring see checkSetColumn()
		var i : int = indexes.getItemIndex( this.column );
		var index : int = i + value;
		var n : Object = indexes.getItemAt( index < 0 ? 0 : index );
		this.column = n as String;
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