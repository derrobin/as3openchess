package de.robinz.as3.pcc.chessboard.view
{
	import de.robinz.as3.pcc.chessboard.library.pieces.IPiece;
	import de.robinz.as3.pcc.chessboard.library.pieces.Piece;
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
			tp.data = p;

			var targetContainer : Container;

			if ( p.isWhite ) {
				targetContainer = this.view.whitePieces;
			} else {
				targetContainer = this.view.blackPieces;
			}

			targetContainer.addChild( tp );

			// TODO: LAST POS
			// TODO: Sort Piece Queue
		}

		/* private function insertPiece( c : Container, p : Piece ) : void {
			var childs = c.getChildren();
			var child : TakenPiece;
			var piece : IPiece;
			for each( child in childs ) {
				piece = child.data as IPiece;
				if ( piece.getSortIndex() == p.getSortIndex() ) {
					c.addChild();
				}
			}

			c.addChildAt( c, p.getSortIndex() );
		} */

		protected function get view() : ChessboardTakenPieces {
			return this.viewComponent as ChessboardTakenPieces;
		}
	}
}