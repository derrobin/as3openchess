package de.robinz.as3.pcc.chessboard.controller.ui.panel
{
	import de.robinz.as3.pcc.chessboard.model.ApplicationProxy;
	import de.robinz.as3.pcc.chessboard.view.ApplicationMediator;
	import de.robinz.as3.pcc.chessboard.view.TakenPiecesMediator;

	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.command.SimpleCommand;

	/**
	 * AppearTakenPiecesPanelCommand
	 *
	 * @author robin heinel
	 */
	public class AppearTakenPiecesPanelCommand extends SimpleCommand
	{
		// Start SimpleCommand overrides

		public override function execute( n : INotification ) : void {
			if ( ! this.facade.hasMediator( TakenPiecesMediator.NAME ) ) {
				this.facade.registerMediator( new TakenPiecesMediator( appMediator.app.applicationView.chessboardTakenPieces ) );
			}

			appProxy.openPanel( TakenPiecesMediator.NAME );
		}

		// End SimpleCommand overrides


		// Start Innerclass Methods

		// End Innerclass Methods


		// Start Getter / Setters

		private function get appProxy() : ApplicationProxy {
			return this.facade.retrieveProxy( ApplicationProxy.NAME ) as ApplicationProxy;
		}
		private function get takenPiecesMediator() : TakenPiecesMediator {
			return this.facade.retrieveMediator( TakenPiecesMediator.NAME ) as TakenPiecesMediator;
		}
		private function get appMediator() : ApplicationMediator {
			return this.facade.retrieveMediator( ApplicationMediator.NAME ) as ApplicationMediator;
		}

		// End Getter / Setters
	}
}