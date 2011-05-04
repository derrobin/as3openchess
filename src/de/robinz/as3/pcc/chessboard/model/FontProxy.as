package de.robinz.as3.pcc.chessboard.model
{
import de.robinz.as3.pcc.chessboard.library.FontManager;
import de.robinz.as3.pcc.chessboard.library.vo.FontVO;
import de.robinz.as3.pcc.chessboard.library.vo.FontVOCollection;
import de.robinz.as3.pcc.chessboard.library.vo.PieceSettingsVO;

import flash.text.Font;

import org.puremvc.as3.patterns.proxy.Proxy;

/**
 * FontProxy
 *
 * @author robin heinel
 */
public class FontProxy extends Proxy
{
	public static const NAME : String = "FontProxy";
	public static const FONT_SIZE_BASE : int = 25;

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
		this.currentFontSize = 2;
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
		ps.fontSizeCssValue = this.currentFontSizeCssValue;

		return ps;
	}

	public function getFont( fontId : String ) : FontVO {
		return this._fonts.getById( fontId );
	}

	public function getFonts() : FontVOCollection {
		// TODO: return as cloned object
		return this._fonts;
	}

	// End Proxy Interface


	// Start Innerclass Methods

	private function addFonts() : void {
		this._fonts.add( FontVO.create( FontManager.FONT_ID_1, "Alpha", this._fm.getFontClass( FontManager.FONT_ID_1 ), [ "p", "o", "r", "t", "b", "n", "k", "l", "q", "w", "h", "j" ] ) );
		this._fonts.add( FontVO.create( FontManager.FONT_ID_2, "Chessole", this._fm.getFontClass( FontManager.FONT_ID_1 ), [ "b", "B", "t", "T", "l", "L", "k", "K", "d", "D", "s", "S" ] ) );
		this._fonts.add( FontVO.create( FontManager.FONT_ID_3, "Merida", this._fm.getFontClass( FontManager.FONT_ID_1 ), [ "p", "o", "r", "t", "b", "v", "k", "l", "q", "w", "n", "m" ] ) );
		this._fonts.add( FontVO.create( FontManager.FONT_ID_4, "Traveller", this._fm.getFontClass( FontManager.FONT_ID_1 ), [ "P", "p", "R", "r", "B", "b", "K", "k", "Q", "q", "N", "n" ] ) );
		this._fonts.add( FontVO.create( FontManager.FONT_ID_5, "Aventfont", this._fm.getFontClass( FontManager.FONT_ID_1 ), [ "p", "o", "r", "t", "b", "v", "k", "l", "q", "w", "n", "m" ] ) );
	}

	private function registerFonts() : void {
		var font : FontVO; // Font Instance Name
		for each( font in this._fonts.list ) {
			Font.registerFont( font.instance );
		}
	}

	// End Innerclass Methods


	// Start Getter / Setters

	public function get currentFontSizeCssValue() : int {
		return FONT_SIZE_BASE + this._currentFontSize * 12;
	}
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