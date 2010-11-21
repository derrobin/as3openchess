package de.robinz.as3.pcc.chessboard.view
{
	import org.puremvc.as3.patterns.mediator.Mediator;

	/**
	 * GameMediator
	 *
	 * Steuert das Spiel
	 *
	 * @author Robin Heinel
	 *
	 */
	public class GameMediator extends Mediator
	{
		public static const NAME : String = "GameMediator";

		public function GameMediator() {
			super( NAME, null );
		}

		public function get cb() : ChessboardMediator {
			return this.facade.retrieveMediator( ChessboardMediator.NAME ) as ChessboardMediator;
		}
		public function get mb() : MenubarMediator {
			return this.facade.retrieveMediator( MenubarMediator.NAME ) as MenubarMediator;
		}
		public function get tp() : TakenPiecesMediator {
			return this.facade.retrieveMediator( TakenPiecesMediator.NAME ) as TakenPiecesMediator;
		}
		public function get mh() : MoveHistoryMediator {
			return this.facade.retrieveMediator( MoveHistoryMediator.NAME ) as MoveHistoryMediator;
		}
	}
}