package de.robinz.as3.pcc.chessboard.controller.ui
{
import de.robinz.as3.pcc.chessboard.ApplicationFacade;
import de.robinz.as3.pcc.chessboard.controller.BaseCommand;
import de.robinz.as3.pcc.chessboard.library.common.LoggerUtil;
import de.robinz.as3.pcc.chessboard.view.GameActionsMediator;
import de.robinz.as3.pcc.chessboard.view.MoveHistoryMediator;
import de.robinz.as3.pcc.chessboard.view.TakenPiecesMediator;

import org.puremvc.as3.interfaces.INotification;

/**
 * SetPanelCommand
 *
 * @author robin heinel
 */
public class PanelActionCommand extends BaseCommand
{
	// Start SimpleCommand overrides

	public override function execute( n : INotification ) : void {
		super.execute( n );

		switch ( n.getName() ) {
			case ApplicationFacade.APPEAR_MOVE_HISTORY_PANEL:
				this.appearMoveHistoryPanel();
			break;
			case ApplicationFacade.APPEAR_TAKEN_PIECES_PANEL:
				this.appearTakenPiecesPanel();
			break;

			case ApplicationFacade.DISAPPEAR_MOVE_HISTORY_PANEL:
				this.disappearPanel( MoveHistoryMediator.NAME );
			break;
			case ApplicationFacade.DISAPPEAR_TAKEN_PIECES_PANEL:
				this.disappearPanel( TakenPiecesMediator.NAME );
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
		log.debug( LoggerUtil.outDictionary( appProxy.getOpenPanels() ) );
	}

	// End Innerclass Methods


	// Start Getter / Setters

	// End Getter / Setters
}
}