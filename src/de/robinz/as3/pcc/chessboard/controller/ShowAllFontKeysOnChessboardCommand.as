package de.robinz.as3.pcc.chessboard.controller
{
	import de.robinz.as3.pcc.chessboard.ApplicationFacade;
	import de.robinz.as3.pcc.chessboard.library.Notation;
	import de.robinz.as3.pcc.chessboard.library.ChessboardMove;
	import de.robinz.as3.pcc.chessboard.library.pieces.FakedPiece;
	import de.robinz.as3.pcc.chessboard.library.pieces.Piece;
	import de.robinz.as3.pcc.chessboard.model.GameProxy;

	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.command.SimpleCommand;

	/**
	 * ShowAllFontKeysOnChessboardCommand
	 *
	 * @author robin heinel
	 */
	public class ShowAllFontKeysOnChessboardCommand extends SimpleCommand
	{
		// Start SimpleCommand overrides

		public override function execute( n : INotification ) : void {
			sendNotification( ApplicationFacade.REMOVE_ALL_PIECES );
			sendNotification( ApplicationFacade.ENABLE_BOARD_INSPECT_PIECE_MODE );

			this.setPieces();
		}

		// End SimpleCommand overrides


		// Start Innerclass Methods

		/**
		 * Create Chess Start Positions
		 *
		 */
		private function setPieces() : void {
			var rows : String = "abcdefgh";
			var testChars : String = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ";
			var testChar : String;
			var c : String; // char
			var i : int = 1;
			var j : int = 1;
			var count : int = 0;
			var notation : String;


			for( j; j <= 8; j++ ) {
				for( i; i <= rows.length; i++ ) {
					c = rows.charAt( i - 1 );
					notation = c + j.toString();
					testChar = testChars.charAt( count );

					if ( testChar == null || testChar.length == 0 ) {
						break;
					}

					trace(notation + "::" + testChar);
					this.setPiece( testChar, notation );
					count++;
				}
				i = 1;
			}
		}

		private function setPiece( fontKey : String, shortenNotation : String ) : void {
			var m : ChessboardMove = new ChessboardMove();

			var fake : Piece = new FakedPiece();
			fake.fontKey = fontKey;

			m.piece = fake;
			m.toPosition = Notation.createNotationByString( shortenNotation );

			sendNotification( ApplicationFacade.SET_PIECE, m );
		}

		// End Innerclass Methods


		// Start Getter / Setters

		private function get gameProxy() : GameProxy {
			return this.facade.retrieveProxy( GameProxy.NAME ) as GameProxy;
		}

		// End Getter / Setters
	}
}