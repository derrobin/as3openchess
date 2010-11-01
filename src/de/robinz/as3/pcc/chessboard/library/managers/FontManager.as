package de.robinz.as3.pcc.chessboard.library.managers
{
	import de.robinz.as3.pcc.chessboard.library.pieces.Bishop;
	import de.robinz.as3.pcc.chessboard.library.pieces.IPiece;
	import de.robinz.as3.pcc.chessboard.library.pieces.King;
	import de.robinz.as3.pcc.chessboard.library.pieces.Knight;
	import de.robinz.as3.pcc.chessboard.library.pieces.Pawn;
	import de.robinz.as3.pcc.chessboard.library.pieces.Queen;
	import de.robinz.as3.pcc.chessboard.library.pieces.Rook;

	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.text.Font;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;

	import mx.controls.Image;

	public class FontManager
	{
		[Embed(source='../../fonts/Alpha.ttf',fontName='font1',fontFamily='font1',mimeType='application/x-font')]
		private var font1 : Class;
		private static var _instance : FontManager;
		private static var _allowInstantiation : Boolean;

		public function FontManager() {
			if ( !_allowInstantiation ) {
				throw new Error( "Error: Instantiation failed: Use static::getInstance() instead of new." );
			}

			Font.registerFont( font1 );
		}

		public static function getInstance() : FontManager {
			if ( _instance == null ) {
				_allowInstantiation = true;
				_instance = new FontManager();
				_allowInstantiation = false;
			}

			return _instance;
		}

		public static function getFontKeyByPiece( piece : IPiece ) : String {
			switch( piece.getName() ) {
				case Pawn.NAME:		return piece.isWhite ? "p" : "o";
				case Rook.NAME:		return piece.isWhite ? "r" : "t";
				case Bishop.NAME:	return piece.isWhite ? "b" : "n";
				case King.NAME:		return piece.isWhite ? "k" : "l";
				case Queen.NAME:	return piece.isWhite ? "q" : "w";
				case Knight.NAME:	return piece.isWhite ? "h" : "j";

			}

			throw new Error( "No Font Key Found!" );
		}

		public function convertTextToFlexImage( text : String ) : Image {
			var img : Image = new Image();
			var b : Bitmap = this.textToBitmap( text );


			img.source = b;

			return img;
		}

		// TODO: Funktion auslagern, Font-Param adden ( common )
		public function textToBitmap( str : String ) : Bitmap {
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
		}

	}
}