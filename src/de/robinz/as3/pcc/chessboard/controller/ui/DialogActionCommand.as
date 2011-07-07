package de.robinz.as3.pcc.chessboard.controller.ui {
import de.robinz.as3.pcc.chessboard.ApplicationFacade;
import de.robinz.as3.pcc.chessboard.controller.BaseCommand;
import de.robinz.as3.pcc.chessboard.library.common.LoggerUtil;
import de.robinz.as3.pcc.chessboard.library.vo.ColorSettingsVO;
import de.robinz.as3.pcc.chessboard.library.vo.PieceSettingsVO;
import de.robinz.as3.pcc.chessboard.model.FontProxy;
import de.robinz.as3.pcc.chessboard.view.ColorSettingsMediator;
import de.robinz.as3.pcc.chessboard.view.MoveHistoryModifierMediator;
import de.robinz.as3.pcc.chessboard.view.PawnConvertMediator;
import de.robinz.as3.pcc.chessboard.view.PieceSettingsMediator;

import de.robinz.as3.pcc.chessboard.view.views.game.ColorSettingsDialog;

import org.puremvc.as3.interfaces.INotification;
import org.puremvc.as3.patterns.observer.Notification;

/**
 * DialogActionCommand
 *
 * @author robin heinel
 */
public class DialogActionCommand extends BaseCommand {
	// Start SimpleCommand overrides

	public override function execute( n : INotification ) : void {
		super.execute( n );

		switch ( n.getName() ) {
			case ApplicationFacade.APPEAR_MOVE_HISTORY_MODIFIER:
				this.appearMoveHistoryModifier( n );
				break;
			case ApplicationFacade.APPEAR_PIECE_SETTINGS:
				this.appearPieceSettings( n );
				break;
			case ApplicationFacade.APPEAR_COLOR_SETTINGS:
				this.appearColorSettings( n );
				break;
			case ApplicationFacade.PAWN_PROMOTION:
				this.pawnPromotion( n );
				break;

			case ApplicationFacade.DISAPPEAR_MOVE_HISTORY_MODIFIER:
				this.closeDialog( MoveHistoryModifierMediator.NAME );
				break;
			case ApplicationFacade.DISAPPEAR_PIECE_SETTINGS:
				this.closeDialog( PieceSettingsMediator.NAME );
				break;
			case ApplicationFacade.DISAPPEAR_COLOR_SETTINGS:
				this.closeDialog( ColorSettingsMediator.NAME );
				break;
		}

		log.debug( LoggerUtil.outDictionary( appProxy.getOpenDialogs() ) );
	}

	// End SimpleCommand overrides


	// Start Innerclass Methods

	private function pawnPromotion( n : INotification ) : void {
		this.facade.registerMediator( new PawnConvertMediator( appMediator.app ) );
		this.facade.retrieveMediator( PawnConvertMediator.NAME ).handleNotification( n );
	}


	public function appearColorSettings( n : INotification ) : void {
		if ( this.facade.hasMediator( ColorSettingsMediator.NAME ) || this.appProxy.isDialogOpen( ColorSettingsMediator.NAME ) ) {
			n.setType( ColorSettingsMediator.NOTIFICATION_TYPE_INTERRUPT_APPEAR );
			return;
		}

		this.facade.registerMediator( new ColorSettingsMediator( appMediator.app ) );

		var settings : ColorSettingsVO = new ColorSettingsVO();
		settings.color1 = 0x00ff00;

		this.colorSettingsMediator.handleNotification( new Notification( ApplicationFacade.COLOR_SETTINGS_CHANGED, settings ) );

		// second resend notification only to piece settings mediator for appear
		this.colorSettingsMediator.handleNotification( n );

		appProxy.openDialog( ColorSettingsMediator.NAME );
	}

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

		this.pieceSettingsMediator.handleNotification( new Notification( ApplicationFacade.SET_PIECE_SETTINGS, settings ) );

		// second resend notification only to piece settings mediator for appear
		this.pieceSettingsMediator.handleNotification( n );

		appProxy.openDialog( PieceSettingsMediator.NAME );
	}

	public function appearMoveHistoryModifier( n : INotification ) : void {
		if ( this.facade.hasMediator( MoveHistoryModifierMediator.NAME ) || appProxy.isDialogOpen( MoveHistoryModifierMediator.NAME ) ) {
			// will interrupt appear on mediator
			n.setType( MoveHistoryModifierMediator.NOTIFICATION_TYPE_INTERRUPT_APPEAR );
			return;
		}

		this.facade.registerMediator( new MoveHistoryModifierMediator( appMediator.app ) );
		this.modifierMediator.handleNotification( n );

		appProxy.openDialog( MoveHistoryModifierMediator.NAME );
	}

	private function closeDialog( mediatorName : String ) : void {
		this.facade.removeMediator( mediatorName );
		appProxy.closeDialog( mediatorName );
	}

	// End Innerclass Methods


	// Start Getter / Setters

	private function get modifierMediator() : MoveHistoryModifierMediator {
		return this.facade.retrieveMediator( MoveHistoryModifierMediator.NAME ) as MoveHistoryModifierMediator;
	}

	private function get pieceSettingsMediator() : PieceSettingsMediator {
		return this.facade.retrieveMediator( PieceSettingsMediator.NAME ) as PieceSettingsMediator;
	}

	private function get colorSettingsMediator() : ColorSettingsMediator {
		return this.facade.retrieveMediator( ColorSettingsMediator.NAME ) as ColorSettingsMediator;
	}

	private function get fontProxy() : FontProxy {
		return this.facade.retrieveProxy( FontProxy.NAME ) as FontProxy;
	}

	// End Getter / Setters
}
}