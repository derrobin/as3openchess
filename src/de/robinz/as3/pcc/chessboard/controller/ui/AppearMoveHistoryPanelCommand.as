package de.robinz.as3.pcc.chessboard.controller.ui
{
	import de.robinz.as3.pcc.chessboard.view.ApplicationMediator;
	import de.robinz.as3.pcc.chessboard.view.MoveHistoryMediator;

	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.command.SimpleCommand;

	/**
	 * AppearMoveHistoryPanelCommand
	 *
	 * @author robin heinel
	 */
	public class AppearMoveHistoryPanelCommand extends SimpleCommand
	{
		// Start SimpleCommand overrides

		public override function execute( n : INotification ) : void {
			if ( ! this.facade.hasMediator( MoveHistoryMediator.NAME ) ) {
				this.facade.registerMediator( new MoveHistoryMediator( appMediator.app.applicationView.chessboardMoveHistory ) );
			}
		}

		// End SimpleCommand overrides


		// Start Innerclass Methods

		// End Innerclass Methods


		// Start Getter / Setters

		private function get appMediator() : ApplicationMediator {
			return this.facade.retrieveMediator( ApplicationMediator.NAME ) as ApplicationMediator;
		}

		// End Getter / Setters
	}
}