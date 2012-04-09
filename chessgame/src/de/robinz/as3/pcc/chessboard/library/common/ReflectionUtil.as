package de.robinz.as3.pcc.chessboard.library.common {
import flash.utils.getQualifiedClassName;

/**
 * ReflectionUtil
 *
 * @author robin heinel
 */
public class ReflectionUtil {
	public static function getQualifiedBaseName( instance : * ) : String {
		var name : String = getQualifiedClassName( instance );
		var separator : String = "::";
		name = name.substring( name.indexOf( separator ) + separator.length, name.length );
		return name;
	}
}
}