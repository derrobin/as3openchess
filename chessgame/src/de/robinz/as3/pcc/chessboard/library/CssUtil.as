package de.robinz.as3.pcc.chessboard.library {
import mx.styles.CSSStyleDeclaration;
import mx.styles.StyleManager;

/**
 * CssUtil
 *
 * @author robin heinel
 */
public class CssUtil {

	public static function overrideCssProperty( selector : String, property : String, value : *, formatSelector : Boolean = true ) : void {
		if ( formatSelector ) {
			selector = "." + selector;
		}

		var css : CSSStyleDeclaration = StyleManager.getStyleDeclaration( selector );

		if ( css == null ) {
			trace( "overrideCssProperty: selector {0} does not exists!", selector );
			return;
		}

		css.setStyle( property, value );
	}

}
}