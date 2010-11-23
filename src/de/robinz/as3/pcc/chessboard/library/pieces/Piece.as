package de.robinz.as3.pcc.chessboard.library.pieces
{
	import de.robinz.as3.pcc.chessboard.library.managers.FontManager;
	import de.robinz.as3.pcc.chessboard.library.managers.PieceManager;

	public class Piece implements IPiece
	{
		private var _isWhite : Boolean = true;

		public static function createByParams( name : String, white : Boolean = true ) : IPiece {
			var p : IPiece = PieceManager.getInstance().createByName( name );

			if ( ! white ) {
				p.setBlack();
			}

			return p as IPiece;
		}



		public function setWhite() : void {
			this._isWhite = true;
		}

		public function setBlack() : void {
			this._isWhite  = false;
		}

		public function get fontKey() : String {
			return FontManager.getFontKeyByPiece( this );
		}

		public function getName() : String {
			throw new Error( "Not Implemented!" );
		}

		public function getSortIndex() : int {
			throw new Error( "Not Implemented!" );
		}

		public function get isWhite() : Boolean {
			return this._isWhite;
		}



	}
}