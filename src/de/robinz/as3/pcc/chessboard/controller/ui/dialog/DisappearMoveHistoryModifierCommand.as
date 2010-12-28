package de.robinz.as3.pcc.chessboard.controller.ui.dialog
{
	import de.robinz.as3.pcc.chessboard.model.ApplicationProxy;
	import de.robinz.as3.pcc.chessboard.view.MoveHistoryModifierMediator;

	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.command.SimpleCommand;

	/**
	 * DisappearMoveHistoryModifierCommand
	 *
	 * @author robin heinel
	 */
	public class DisappearMoveHistoryModifierCommand extends SimpleCommand
	{
		// Start SimpleCommand overrides

		public override function execute( n : INotification ) : void {
			this.facade.removeMediator( MoveHistoryModifierMediator.NAME );
			this.appProxy.closeDialog( MoveHistoryModifierMediator.NAME );
		}

		// End SimpleCommand overrides


		// Start Innerclass Methods

		// End Innerclass Methods


		// Start Getter / Setters

		private function get appProxy() : ApplicationProxy {
			return this.facade.retrieveProxy( ApplicationProxy.NAME ) as ApplicationProxy;
		}

		// End Getter / Setters
	}
}