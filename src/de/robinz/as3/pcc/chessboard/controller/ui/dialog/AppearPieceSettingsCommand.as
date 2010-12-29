package de.robinz.as3.pcc.chessboard.controller.ui.dialog
{
	import de.robinz.as3.pcc.chessboard.ApplicationFacade;
	import de.robinz.as3.pcc.chessboard.library.vo.PieceSettingsVO;
	import de.robinz.as3.pcc.chessboard.model.ApplicationProxy;
	import de.robinz.as3.pcc.chessboard.model.FontProxy;
	import de.robinz.as3.pcc.chessboard.view.ApplicationMediator;
	import de.robinz.as3.pcc.chessboard.view.PieceSettingsMediator;

	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.command.SimpleCommand;
	import org.puremvc.as3.patterns.observer.Notification;

	/**
	 * AppearPieceSettingsCommand
	 *
	 * @author robin heinel
	 */
	public class AppearPieceSettingsCommand extends SimpleCommand
	{
		// Start SimpleCommand overrides

		public override function execute( n : INotification ) : void {
			if ( this.facade.hasMediator( PieceSettingsMediator.NAME ) || this.appProxy.isDialogOpen( PieceSettingsMediator.NAME ) ) {
				n.setType( PieceSettingsMediator.NOTIFICATION_TYPE_INTERRUPT_APPEAR );
				return;
			}

			this.facade.registerMediator( new PieceSettingsMediator( appMediator.app ) );

			// first set fonts
			var settings : PieceSettingsVO = new PieceSettingsVO();
			settings.fonts = this.fontProxy.getFonts();
			settings.font = this.fontProxy.currentFont;
			settings.fontSize = this.fontProxy.currentFontSize;
			settings.fontSizeCssValue = this.fontProxy.currentFontSizeCssValue;

			this.pieceSettingsMediator.handleNotification(
				new Notification( ApplicationFacade.SET_FONT_SETTINGS, settings )
			);

			// second resend notification only to piece settings mediator for appear
			this.pieceSettingsMediator.handleNotification( n );
		}

		// End SimpleCommand overrides


		// Start Innerclass Methods

		// End Innerclass Methods


		// Start Getter / Setters

		private function get appProxy() : ApplicationProxy {
			return this.facade.retrieveProxy( ApplicationProxy.NAME ) as ApplicationProxy;
		}
		private function get fontProxy() : FontProxy {
			return this.facade.retrieveProxy( FontProxy.NAME ) as FontProxy;
		}

		private function get pieceSettingsMediator() : PieceSettingsMediator {
			return this.facade.retrieveMediator( PieceSettingsMediator.NAME ) as PieceSettingsMediator;
		}

		private function get appMediator() : ApplicationMediator {
			return this.facade.retrieveMediator( ApplicationMediator.NAME ) as ApplicationMediator;
		}

		// End Getter / Setters
	}
}