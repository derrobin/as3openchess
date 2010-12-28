package de.robinz.as3.pcc.chessboard.controller.ui.dialog
{
	import de.robinz.as3.pcc.chessboard.model.ApplicationProxy;
	import de.robinz.as3.pcc.chessboard.view.ApplicationMediator;
	import de.robinz.as3.pcc.chessboard.view.MoveHistoryModifierMediator;

	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.command.SimpleCommand;

	/**
	 * AppearMoveHistoryModifierCommand
	 *
	 * @author robin heinel
	 */
	public class AppearMoveHistoryModifierCommand extends SimpleCommand
	{
		// Start SimpleCommand overrides

		public override function execute( n : INotification ) : void {
			if ( this.facade.hasMediator( MoveHistoryModifierMediator.NAME ) || appProxy.isDialogOpen( MoveHistoryModifierMediator.NAME ) ) {
				// will interrupt appear on mediator
				n.setType( MoveHistoryModifierMediator.NOTIFICATION_TYPE_INTERRUPT_APPEAR );
				return;
			}

			this.facade.registerMediator( new MoveHistoryModifierMediator( appMediator.app ) );
			this.modifierMediator.handleNotification( n );

			this.appProxy.openDialog( MoveHistoryModifierMediator.NAME );
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
		private function get modifierMediator() : MoveHistoryModifierMediator {
			return this.facade.retrieveMediator( MoveHistoryModifierMediator.NAME ) as MoveHistoryModifierMediator;
		}

		// End Getter / Setters
	}
}