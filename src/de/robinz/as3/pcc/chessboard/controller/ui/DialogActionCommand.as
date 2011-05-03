package de.robinz.as3.pcc.chessboard.controller.ui
{
import de.robinz.as3.pcc.chessboard.ApplicationFacade;
import de.robinz.as3.pcc.chessboard.library.vo.PieceSettingsVO;
import de.robinz.as3.pcc.chessboard.model.ApplicationProxy;
import de.robinz.as3.pcc.chessboard.model.FontProxy;
import de.robinz.as3.pcc.chessboard.view.ApplicationMediator;
import de.robinz.as3.pcc.chessboard.view.GameActionsMediator;

import de.robinz.as3.pcc.chessboard.view.MoveHistoryModifierMediator;

import de.robinz.as3.pcc.chessboard.view.PieceSettingsMediator;

import org.puremvc.as3.interfaces.INotification;
import org.puremvc.as3.patterns.command.SimpleCommand;
import org.puremvc.as3.patterns.observer.Notification;

/**
	 * DialogActionCommand
	 *
	 * @author robin heinel
	 */
	public class DialogActionCommand extends SimpleCommand
	{
		// Start SimpleCommand overrides

		public override function execute( n : INotification ) : void {
			switch ( n.getName() ) {
				case ApplicationFacade.APPEAR_MOVE_HISTORY_MODIFIER:
					this.appearMoveHistoryModifier( n );
				break;
				case ApplicationFacade.APPEAR_PIECE_SETTINGS:
					this.appearPieceSettings( n );
				break;

				case ApplicationFacade.DISAPPEAR_MOVE_HISTORY_MODIFIER:
					this.closePanel( MoveHistoryModifierMediator.NAME );
				break;
				case ApplicationFacade.DISAPPEAR_PIECE_SETTINGS:
					this.closePanel( PieceSettingsMediator.NAME );
				break;
			}
		}

		// End SimpleCommand overrides


		// Start Innerclass Methods

		public function appearPieceSettings( n : INotification ) : void {
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

		public function appearMoveHistoryModifier( n : INotification ) : void {
			if ( this.facade.hasMediator( MoveHistoryModifierMediator.NAME ) || appProxy.isDialogOpen( MoveHistoryModifierMediator.NAME ) ) {
				// will interrupt appear on mediator
				n.setType( MoveHistoryModifierMediator.NOTIFICATION_TYPE_INTERRUPT_APPEAR );
				return;
			}

			this.facade.registerMediator( new MoveHistoryModifierMediator( appMediator.app ) );
			this.modifierMediator.handleNotification( n );

			this.appProxy.openDialog( MoveHistoryModifierMediator.NAME );
		}

		private function closePanel( mediatorName : String ) : void {
			this.facade.removeMediator( mediatorName );
			appProxy.closePanel( mediatorName );
		}

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
		private function get pieceSettingsMediator() : PieceSettingsMediator {
			return this.facade.retrieveMediator( PieceSettingsMediator.NAME ) as PieceSettingsMediator;
		}
		private function get fontProxy() : FontProxy {
			return this.facade.retrieveProxy( FontProxy.NAME ) as FontProxy;
		}

		// End Getter / Setters
	}
}