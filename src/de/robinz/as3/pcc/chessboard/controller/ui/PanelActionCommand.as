package de.robinz.as3.pcc.chessboard.controller.ui
{
	import de.robinz.as3.pcc.chessboard.model.ApplicationProxy;
	import de.robinz.as3.pcc.chessboard.view.ApplicationMediator;
	import de.robinz.as3.pcc.chessboard.view.GameActionsMediator;
	import de.robinz.as3.pcc.chessboard.view.MoveHistoryMediator;

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
			if ( ! this.facade.hasMediator( GameActionsMediator.NAME ) ) {
				this.facade.registerMediator( new GameActionsMediator( appMediator.app.applicationView.chessboardGameActions ) );
			}

			appProxy.openPanel( GameActionsMediator.NAME );
		}

		// End SimpleCommand overrides


		// Start Innerclass Methods

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