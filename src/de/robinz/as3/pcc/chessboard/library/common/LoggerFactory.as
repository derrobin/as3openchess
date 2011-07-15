package de.robinz.as3.pcc.chessboard.library.common {
import flash.utils.getQualifiedClassName;

import mx.logging.ILogger;
import mx.logging.Log;

/**
 * LoggerFactory
 *
 * @author robin heinel
 */
public class LoggerFactory {
	public function LoggerFactory() {
	}

	public static function getLogger( instance : Object, useQualifiedClassName : Boolean = true ) : ILogger {
		var name : String = useQualifiedClassName
			? getQualifiedClassName( instance )
			: ReflectionUtil.getQualifiedBaseName( instance );

		name = name.replace( "::", "." );
		return Log.getLogger( name );
	}
}
}