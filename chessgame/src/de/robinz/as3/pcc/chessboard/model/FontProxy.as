package de.robinz.as3.pcc.chessboard.model
{
import de.robinz.as3.pcc.chessboard.library.FontManager;
import de.robinz.as3.pcc.chessboard.library.vo.FontVO;
import de.robinz.as3.pcc.chessboard.library.vo.FontVO;
import de.robinz.as3.pcc.chessboard.library.vo.FontVOCollection;
import de.robinz.as3.pcc.chessboard.library.vo.PieceSettingsVO;

import flash.text.Font;

/**
 * FontProxy
 *
 * @author robin heinel
 */
public class FontProxy extends BaseProxy
{
	public static const NAME : String = "FontProxy";

	private var _fonts : FontVOCollection;
	private var _fm : FontManager;

	private var _currentFont  : FontVO;
	private var _currentFontSize : int;

	public function FontProxy( data : Object = null ) {
		super( NAME, data );

		this._fm = FontManager.getInstance();
		this._fonts = new FontVOCollection();

		this.addFonts();
		this.registerFonts();

		var font : FontVO = this._fonts.getById( FontManager.FONT_ID_1 );
		this.currentFont = font;
		this.currentFontSize = 35;
	}


	// Start proxy overrides

	public override function getProxyName() : String {
		return NAME;
	}

	// End proxy overrides


	// Start Proxy Interface

	public function getPieceSettings() : PieceSettingsVO {
		var ps : PieceSettingsVO = new PieceSettingsVO();

		ps.font = this.currentFont;
		ps.fonts = this.getFonts();
		ps.fontSize = this.currentFontSize;

		return ps;
	}

	public function getFont( fontId : String ) : FontVO {
		return this._fonts.getById( fontId );
	}

	public function getFonts() : FontVOCollection {
		return this._fonts;
	}

	// End Proxy Interface


	// Start Innerclass Methods

	private function addFonts() : void {
		this._fonts.add( FontVO.create( FontManager.FONT_ID_1, "Alpha", this._fm.getFontClass( FontManager.FONT_ID_1 ), [ "p", "o", "r", "t", "b", "n", "k", "l", "q", "w", "h", "j" ] ) );
		this._fonts.add( FontVO.create( FontManager.FONT_ID_2, "Chessole", this._fm.getFontClass( FontManager.FONT_ID_2 ), [ "b", "B", "t", "T", "l", "L", "k", "K", "d", "D", "s", "S" ] ) );
		this._fonts.add( FontVO.create( FontManager.FONT_ID_3, "Merida", this._fm.getFontClass( FontManager.FONT_ID_3 ), [ "p", "o", "r", "t", "b", "v", "k", "l", "q", "w", "n", "m" ] ) );
		this._fonts.add( FontVO.create( FontManager.FONT_ID_4, "Traveller", this._fm.getFontClass( FontManager.FONT_ID_4 ), [ "P", "p", "R", "r", "B", "b", "K", "k", "Q", "q", "N", "n" ] ) );
		this._fonts.add( FontVO.create( FontManager.FONT_ID_5, "Aventfont", this._fm.getFontClass( FontManager.FONT_ID_5 ), [ "p", "o", "r", "t", "b", "v", "k", "l", "q", "w", "n", "m" ] ) );
	}

	private function registerFonts() : void {
		for each( var font : FontVO in this._fonts.list ) {
			Font.registerFont( font.instance );
		}
	}

	// End Innerclass Methods


	// Start Getter / Setters

	public function get currentFontSize() : int {
		return this._currentFontSize;
	}
	public function set currentFontSize( value : int ) : void {
		this._currentFontSize = value;
	}
	public function get currentFont() : FontVO {
		return this._currentFont;
	}
	public function set currentFont( value : FontVO ) : void {
		this._fm.setFont( value );
		this._currentFont = value;
	}

	// End Getter / Setters
}
}