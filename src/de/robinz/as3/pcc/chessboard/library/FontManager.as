package de.robinz.as3.pcc.chessboard.library
{
import de.robinz.as3.pcc.chessboard.library.pieces.Bishop;
import de.robinz.as3.pcc.chessboard.library.pieces.IPiece;
import de.robinz.as3.pcc.chessboard.library.pieces.King;
import de.robinz.as3.pcc.chessboard.library.pieces.Knight;
import de.robinz.as3.pcc.chessboard.library.pieces.Pawn;
import de.robinz.as3.pcc.chessboard.library.pieces.Queen;
import de.robinz.as3.pcc.chessboard.library.pieces.Rook;
import de.robinz.as3.pcc.chessboard.library.vo.FontVO;

/**
 * Embedding the Fonts
 * give easy access for class::Piece to assessing right font key
 *
 * @author robin heinel
 */
// TODO: Remove / Refactor this class
public class FontManager
{
	public static const FONT_ID_1 : String = "font1";
	public static const FONT_ID_2 : String = "font2";
	public static const FONT_ID_3 : String = "font3";
	public static const FONT_ID_4 : String = "font4";
	public static const FONT_ID_5 : String = "font5";
	public static const FONT_ID_6 : String = "font6";

	[Embed(source='../resources/fonts/Alpha.ttf',fontName='font1',fontFamily='font1',mimeType='application/x-font')]
	private var font1 : Class;

	[Embed(source='../resources/fonts/chessole.TTF',fontName='font2',fontFamily='font2',mimeType='application/x-font')]
	private var font2 : Class;

	[Embed(source='../resources/fonts/merida.ttf',fontName='font3',fontFamily='font3',mimeType='application/x-font')]
	private var font3 : Class;

	[Embed(source='../resources/fonts/traveller.ttf',fontName='font4',fontFamily='font4',mimeType='application/x-font')]
	private var font4 : Class;

	[Embed(source='../resources/fonts/avenfont.ttf',fontName='font5',fontFamily='font5',mimeType='application/x-font')]
	private var font5 : Class;

	private var _currentFont : FontVO;

	private static var _instance : FontManager;
	private static var _allowInstantiation : Boolean;

	public function FontManager() {
		if ( !_allowInstantiation ) {
			throw new Error( "Error: Instantiation failed: Use static::getInstance() instead of new." );
		}
	}

	public static function getInstance() : FontManager {
		if ( _instance == null ) {
			_allowInstantiation = true;
			_instance = new FontManager();
			_allowInstantiation = false;
		}

		return _instance;
	}

	public function getFontClass( fontId : String ) : Class {
		try {
			var c : Class = this[ fontId ];
			return c;
		} catch( e : Error ) {
			throw new Error("No font class found!");
		}

		return null;
	}

	public function setFont( font : FontVO ) : void {
		if ( font == null ) {
			throw new Error("No font was given!");
		}

		this._currentFont = font;
	}

	public function getFontKeyByPiece( piece : IPiece ) : String {
		var map : Array = this._currentFont.keyMap;
		switch( piece.getName() ) {
			case Pawn.NAME:		return piece.isWhite ? map[ 0 ] : map[ 1 ];
			case Rook.NAME:		return piece.isWhite ? map[ 2 ] : map[ 3 ];
			case Bishop.NAME:	return piece.isWhite ? map[ 4 ] : map[ 5 ];
			case King.NAME:		return piece.isWhite ? map[ 6 ] : map[ 7 ];
			case Queen.NAME:	return piece.isWhite ? map[ 8 ] : map[ 9 ];
			case Knight.NAME:	return piece.isWhite ? map[ 10 ] : map[ 11 ];
		}

		throw new Error( "No Font Key Found!" );
	}

	/* public function convertTextToFlexImage( text : String ) : Image {
		var img : Image = new Image();
		var b : Bitmap = this.textToBitmap( text );


		img.source = b;

		return img;
	} */

	// TODO: Funktion auslagern, Font-Param adden ( common )
	/* public function textToBitmap( str : String ) : Bitmap {
		var fmt : TextFormat;
		var bmd : BitmapData;
		var bm : Bitmap;
		var tf : TextField;

		var list : Array = Font.enumerateFonts(false);

		var tt : Class = font1;

		tf = new TextField();
		tf.defaultTextFormat = new TextFormat( "font1", 30 );
		tf.text = str;
		tf.autoSize = TextFieldAutoSize.LEFT;
		bmd = new BitmapData( tf.width, tf.height, true, 0 );
		bmd.draw( tf );
		bm = new Bitmap( bmd );
		bm.smoothing = true;
		return bm;
	} */

}
}