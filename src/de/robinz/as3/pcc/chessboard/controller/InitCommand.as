package de.robinz.as3.pcc.chessboard.controller
{
	import de.robinz.as3.pcc.chessboard.library.BoardNotation;
	import de.robinz.as3.pcc.chessboard.library.BoardPiece;
	import de.robinz.as3.pcc.chessboard.view.ChessboardMediator;

	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.command.SimpleCommand;

	/**
	 * Application initialization
	 *
	 * @author Robin Heinel
	 *
	 */
	public class InitCommand extends SimpleCommand
	{
		public override function execute( note : INotification ) : void {

			// Create Chess Start Positions

			this.setWhitePiece( BoardPiece.PIECE_PAWN, "a2" );
			this.setWhitePiece( BoardPiece.PIECE_PAWN, "b2" );
			this.setWhitePiece( BoardPiece.PIECE_PAWN, "c2" );
			this.setWhitePiece( BoardPiece.PIECE_PAWN, "d2" );
			this.setWhitePiece( BoardPiece.PIECE_PAWN, "e2" );
			this.setWhitePiece( BoardPiece.PIECE_PAWN, "f2" );
			this.setWhitePiece( BoardPiece.PIECE_PAWN, "g2" );
			this.setWhitePiece( BoardPiece.PIECE_PAWN, "h2" );
			this.setWhitePiece( BoardPiece.PIECE_ROOK, "a1" );
			this.setWhitePiece( BoardPiece.PIECE_ROOK, "h1" );
			this.setWhitePiece( BoardPiece.PIECE_BISHOP, "b1" );
			this.setWhitePiece( BoardPiece.PIECE_BISHOP, "g1" );
			this.setWhitePiece( BoardPiece.PIECE_KNIGHT, "c1" );
			this.setWhitePiece( BoardPiece.PIECE_KNIGHT, "f1" );
			this.setWhitePiece( BoardPiece.PIECE_QUEEN, "d1" );
			this.setWhitePiece( BoardPiece.PIECE_KING, "e1" );


			this.setBlackPiece( BoardPiece.PIECE_PAWN, "a7" );
			this.setBlackPiece( BoardPiece.PIECE_PAWN, "b7" );
			this.setBlackPiece( BoardPiece.PIECE_PAWN, "c7" );
			this.setBlackPiece( BoardPiece.PIECE_PAWN, "d7" );
			this.setBlackPiece( BoardPiece.PIECE_PAWN, "e7" );
			this.setBlackPiece( BoardPiece.PIECE_PAWN, "f7" );
			this.setBlackPiece( BoardPiece.PIECE_PAWN, "g7" );
			this.setBlackPiece( BoardPiece.PIECE_PAWN, "h7" );
			this.setBlackPiece( BoardPiece.PIECE_ROOK, "a8" );
			this.setBlackPiece( BoardPiece.PIECE_ROOK, "h8" );
			this.setBlackPiece( BoardPiece.PIECE_BISHOP, "b8" );
			this.setBlackPiece( BoardPiece.PIECE_BISHOP, "g8" );
			this.setBlackPiece( BoardPiece.PIECE_KNIGHT, "c8" );
			this.setBlackPiece( BoardPiece.PIECE_KNIGHT, "f8" );
			this.setBlackPiece( BoardPiece.PIECE_QUEEN, "e8" );
			this.setBlackPiece( BoardPiece.PIECE_KING, "d8" );
		}

		private function setWhitePiece( piece : String, shortenNotation : String ) : void {
			this.setPiece( piece, shortenNotation, true );
		}

		private function setBlackPiece( piece : String, shortenNotation : String ) : void {
			this.setPiece( piece, shortenNotation, false );
		}

		private function setPiece( piece : String, shortenNotation : String, isWhite : Boolean ) : void {
			bm.setPiece(
				BoardPiece.createByParams( piece, isWhite ),
				BoardNotation.createNotationByString( shortenNotation )
			);
		}

		private function get bm() : ChessboardMediator {
			return this.facade.retrieveMediator( ChessboardMediator.NAME ) as ChessboardMediator;
		}

	}
}