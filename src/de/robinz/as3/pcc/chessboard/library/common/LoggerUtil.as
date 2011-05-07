package de.robinz.as3.pcc.chessboard.library.common {
import flash.utils.Dictionary;

/**
 * de.robinz.as3.pcc.chessboard.library.common
 *
 * @author robin heinel
 */
public class LoggerUtil {
	public static function outDictionary( d : Dictionary ) : String {
		var out : String = "";
		var key : Object;
		var value : String = null;
		var delimiter : String = " | ";

		for( key in d ) {
			value = d[ key ] == null ? "NULL" : d[ key ].toString();
			out += key.toString() + " => " + value + delimiter;
		}

		// remove last delimiter
		if ( value ) {
			out = out.substr( 0, out.length - delimiter.length );
		}

		return out;
	}
}
}