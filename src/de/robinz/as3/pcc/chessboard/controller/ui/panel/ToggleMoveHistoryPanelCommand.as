package de.robinz.as3.pcc.chessboard.controller.ui.panel
{
	import de.robinz.as3.pcc.chessboard.ApplicationFacade;
	import de.robinz.as3.pcc.chessboard.model.ApplicationProxy;
	import de.robinz.as3.pcc.chessboard.view.ApplicationMediator;
	import de.robinz.as3.pcc.chessboard.view.MoveHistoryMediator;

	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.command.SimpleCommand;

	/**
	 * AppearMoveHistoryPanelCommand
	 *
	 * @author robin heinel
	 */
	public class ToggleMoveHistoryPanelCommand extends SimpleCommand
	{
		// Start SimpleCommand overrides

		public override function execute( n : INotification ) : void {
			this.tooglePanel();
		}

		// End SimpleCommand overrides


		// Start Innerclass Methods

		private function tooglePanel() : void {
			if ( appProxy.isPanelOpen( MoveHistoryMediator.NAME ) ) {
				sendNotification( ApplicationFacade.DISAPPEAR_MOVE_HISTORY_PANEL );
			} else {
				sendNotification( ApplicationFacade.APPEAR_MOVE_HISTORY_PANEL );
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