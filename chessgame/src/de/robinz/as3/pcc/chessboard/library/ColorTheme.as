package de.robinz.as3.pcc.chessboard.library {
import de.robinz.as3.pcc.chessboard.library.vo.*;

/**
 * ColorTheme
 *
 * @author robin heinel
 */
public class ColorTheme {

	public static const BLUE_WATER : String = "blueWater";
	public static const GREEN_MEN : String = "greenMen";
	public static const PINK_LADY : String = "pinkLady";
	public static const WHITE_PURE : String = "whitePure";
	public static const BLACK_ON_WHITE : String = "blackOnWhite";
	public static const WHITE_ON_BLACK : String = "whiteOnBlack";

	private var _key : String;

	public var name : String;
	public var colors : ColorSettingsVO;

	public function ColorTheme( key : String ) {

	}


	public static function create( key : String, name : String, colors : ColorSettingsVO ) : ColorTheme {
		var o : ColorTheme = new ColorTheme( key );

		o.name = name;
		o.colors = colors;

		return o;
	}

	public function get key() : String {
		return this._key;
	}

}
}