package de.robinz.as3.pcc.chessboard.view
{
	import de.robinz.as3.pcc.chessboard.library.pieces.IPiece;
	import de.robinz.as3.pcc.chessboard.view.views.ChessboardTakenPieces;
	import de.robinz.as3.pcc.chessboard.view.views.takenPieces.TakenPiece;

	import mx.core.Container;

	import org.puremvc.as3.patterns.mediator.Mediator;

	/**
	 * UI Control for Info Panel - Taken Pieces
	 *
	 * @author Robin Heinel
	 *
	 */
	public class TakenPiecesMediator extends Mediator
	{
		public static const NAME : String = "TakenPiecesMediator";

		public function TakenPiecesMediator( m : ChessboardTakenPieces ) {
			super( NAME, m );
		}

		public function addPiece( p : IPiece ) : void {
			var tp : TakenPiece = new TakenPiece();
			tp.initialize();
			tp.piece.text = p.fontKey;

			var targetContainer : Container;

			if ( p.isWhite ) {
				targetContainer = this.view.whitePieces;
			} else {
				targetContainer = this.view.blackPieces;
			}

			targetContainer.addChild( tp );
		}

		protected function get view() : ChessboardTakenPieces {
			return this.viewComponent as ChessboardTakenPieces;
		}
	}
}