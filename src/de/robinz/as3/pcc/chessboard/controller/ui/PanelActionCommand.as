package de.robinz.as3.pcc.chessboard.controller.ui
{
import de.robinz.as3.pcc.chessboard.ApplicationFacade;
import de.robinz.as3.pcc.chessboard.model.ApplicationProxy;
	import de.robinz.as3.pcc.chessboard.view.ApplicationMediator;
	import de.robinz.as3.pcc.chessboard.view.GameActionsMediator;
	import de.robinz.as3.pcc.chessboard.view.MoveHistoryMediator;

import de.robinz.as3.pcc.chessboard.view.TakenPiecesMediator;

import org.puremvc.as3.interfaces.IMediator;
import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.command.SimpleCommand;

	/**
	 * SetPanelCommand
	 *
	 * @author robin heinel
	 */
	public class PanelActionCommand extends SimpleCommand
	{
		// Start SimpleCommand overrides

		public override function execute( n : INotification ) : void {
			switch ( n.getName() ) {
				case ApplicationFacade.APPEAR_GAME_ACTIONS_PANEL:
					this.appearGameActionsPanel();
				break;
				case ApplicationFacade.APPEAR_MOVE_HISTORY_PANEL:
					this.appearMoveHistoryPanel();
				break;
				case ApplicationFacade.APPEAR_TAKEN_PIECES_PANEL:
					this.appearTakenPiecesPanel();
				break;

				case ApplicationFacade.DISAPPEAR_GAME_ACTIONS_PANEL:
					this.disappearPanel( GameActionsMediator.NAME );
				break;
				case ApplicationFacade.DISAPPEAR_MOVE_HISTORY_PANEL:
					this.disappearPanel( MoveHistoryMediator.NAME );
				break;
				case ApplicationFacade.DISAPPEAR_TAKEN_PIECES_PANEL:
					this.disappearPanel( TakenPiecesMediator.NAME );
				break;

				case ApplicationFacade.TOGGLE_GAME_ACTIONS_PANEL:
					this.togglePanel( GameActionsMediator.NAME, ApplicationFacade.APPEAR_GAME_ACTIONS_PANEL, ApplicationFacade.DISAPPEAR_GAME_ACTIONS_PANEL );
				break;
				case ApplicationFacade.TOGGLE_MOVE_HISTORY_PANEL:
					this.togglePanel( MoveHistoryMediator.NAME, ApplicationFacade.APPEAR_MOVE_HISTORY_PANEL, ApplicationFacade.DISAPPEAR_MOVE_HISTORY_PANEL );
				break;
				case ApplicationFacade.TOGGLE_TAKEN_PIECES_PANEL:
					this.togglePanel( TakenPiecesMediator.NAME, ApplicationFacade.APPEAR_TAKEN_PIECES_PANEL, ApplicationFacade.DISAPPEAR_TAKEN_PIECES_PANEL );
				break;
			}
		}

		// End SimpleCommand overrides


		// Start Innerclass Methods

		private function appearGameActionsPanel() : void {
			if ( ! this.facade.hasMediator( GameActionsMediator.NAME ) ) {
				this.facade.registerMediator( new GameActionsMediator( appMediator.app.applicationView.chessboardGameActions ) );
			}
			appProxy.openPanel( GameActionsMediator.NAME );
		}

		private function appearMoveHistoryPanel() : void {
			if ( ! this.facade.hasMediator( MoveHistoryMediator.NAME ) ) {
				this.facade.registerMediator( new MoveHistoryMediator( appMediator.app.applicationView.chessboardMoveHistory ) );
			}

			appProxy.openPanel( MoveHistoryMediator.NAME );
		}

		private function appearTakenPiecesPanel() : void {
			if ( ! this.facade.hasMediator( TakenPiecesMediator.NAME ) ) {
				this.facade.registerMediator( new TakenPiecesMediator( appMediator.app.applicationView.chessboardTakenPieces ) );
			}

			appProxy.openPanel( TakenPiecesMediator.NAME );
		}

		private function disappearPanel( mediatorName : String ) : void {
			this.facade.removeMediator( mediatorName );
			appProxy.closePanel( mediatorName );
		}

		private function togglePanel( mediatorName : String, appearNotification : String, disappearNotification ) : void {
			if ( appProxy.isPanelOpen( mediatorName ) ) {
				sendNotification( disappearNotification );
			} else {
				sendNotification( appearNotification );
			}
		}

		// End Innerclass Methods


		// Start Getter / Setters

		private function get appProxy() : ApplicationProxy {
			return this.facade.retrieveProxy( ApplicationProxy.NAME ) as ApplicationProxy;
		}
		private function get appMediator() : ApplicationMediator {
			return this.facade.retrieveMediator( ApplicationMediator.NAME ) as ApplicationMediator;
		}

		// End Getter / Setters
	}
}