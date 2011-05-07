package de.robinz.as3.pcc.chessboard.library.common {
import flash.utils.getQualifiedClassName;

import mx.logging.ILogger;
import mx.logging.Log;

/**
 * de.robinz.as3.pcc.chessboard.library
 *
 * @author robin heinel
 */
public class LoggerFactory {
	public function LoggerFactory() {
	}

	public static function getLogger( instance : Object ) : ILogger {
		var name : String = getQualifiedClassName( instance );
		name = name.replace( "::", "." );
		return Log.getLogger( name );
	}
}
}