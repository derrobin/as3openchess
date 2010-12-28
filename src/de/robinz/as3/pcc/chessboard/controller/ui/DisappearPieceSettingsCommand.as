package de.robinz.as3.pcc.chessboard.controller.ui
{
	import de.robinz.as3.pcc.chessboard.model.ApplicationProxy;
	import de.robinz.as3.pcc.chessboard.view.ApplicationMediator;
	import de.robinz.as3.pcc.chessboard.view.PieceSettingsMediator;

	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.command.SimpleCommand;

	/**
	 * DisappearPieceSettingsCommand
	 *
	 * @author robin heinel
	 */
	public class DisappearPieceSettingsCommand extends SimpleCommand
	{
		// Start SimpleCommand overrides

		public override function execute( n : INotification ) : void {
			this.facade.removeMediator( PieceSettingsMediator.NAME );
			this.appProxy.closeDialog( PieceSettingsMediator.NAME );
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