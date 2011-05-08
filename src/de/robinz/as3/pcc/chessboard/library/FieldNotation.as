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

//	public function getNextTop() : FieldNotation {
//		if ( this.row >= 7 ) {
//			return null;
//		}
//
//		var nr : String = this.column + ( this.row + 1 ).toString(); // next row
//
//		log.debug( "try next notation / top: {0}", nr );
//		var n : FieldNotation = FieldNotation.createNotationByString( nr );
//
//		return n;
//	}
//
//	public function getNextDown() : FieldNotation {
//		if ( this.row == 1 ) {
//			return null;
//		}
//
//		var nr : String = this.column + ( this.row - 1 ).toString(); // next row
//
//		log.debug( "try next notation / down: {0}", nr );
//		var n : FieldNotation = FieldNotation.createNotationByString( nr );
//
//		return n;
//	}

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