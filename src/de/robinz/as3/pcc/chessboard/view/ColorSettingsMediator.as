package de.robinz.as3.pcc.chessboard.view {
import de.robinz.as3.pcc.chessboard.ApplicationFacade;
import de.robinz.as3.pcc.chessboard.library.vo.ColorSettingsVO;
import de.robinz.as3.pcc.chessboard.library.vo.ColorSettingsVO;
import de.robinz.as3.pcc.chessboard.library.vo.ColorSettingsVO;
import de.robinz.as3.pcc.chessboard.library.vo.ColorSettingsVO;
import de.robinz.as3.pcc.chessboard.view.views.game.ColorSettingsDialog;

import flash.events.Event;
import flash.events.MouseEvent;

import mx.containers.TitleWindow;
import mx.controls.Button;
import mx.controls.ColorPicker;
import mx.events.ColorPickerEvent;

import org.puremvc.as3.interfaces.INotification;

/**
 * ColorSettingsMediator
 *
 * @author robin heinel
 */
public class ColorSettingsMediator extends DialogBaseMediator {

	public static const NAME : String = "ColorSettingsMediator";

	public function ColorSettingsMediator( stage : mainapp ) {
		super( NAME, stage );
	}

	// Start Innerclass Methods

	private function appear() : void {
		var view : TitleWindow = this.createDialog( "Color Settings", 450, 325, ColorSettingsDialog, this.stage );

		view.addEventListener( MouseEvent.CLICK, onMouseClick );
		view.addEventListener( ColorSettingsDialog.EVENT_CLOSE, onClose );
		view.addEventListener( ColorPickerEvent.CHANGE, onColorChange, true );

		this._dialog = view as ColorSettingsDialog;
		this._dialog.addEventListener( MouseEvent.CLICK, onMouseClick );
	}

	private function close() : void {
		sendNotification( ApplicationFacade.DISAPPEAR_COLOR_SETTINGS );
		this.disappear();
	}

	private function applyChanges() : void {
		sendNotification( ApplicationFacade.CHANGE_COLOR_SETTINGS, this.getColors() );
	}

	private function setColors( colors : ColorSettingsVO ) : void {
		popup.backgroundMain.selectedColor = colors.backgroundMain;
		popup.fieldWhite.selectedColor = colors.fieldWhite;
		popup.fieldBlack.selectedColor = colors.fieldBlack;
		popup.fieldValidDrop.selectedColor = colors.fieldValidDrop;
		popup.fieldMoveHint.selectedColor = colors.fieldMoveHint;
		popup.boardGapColor.selectedColor = colors.boardGapColor;
		popup.boardBorderBackground.selectedColor = colors.boardBorderBackground;
		popup.boardBorderFont.selectedColor = colors.boardBorderFont;
		popup.pieceBlack.selectedColor = colors.pieceBlack;
		popup.pieceBlackBorder.selectedColor = colors.pieceBlackBorder;
		popup.pieceWhite.selectedColor = colors.pieceWhite;
		popup.pieceWhiteBorder.selectedColor = colors.pieceWhiteBorder;
	}

	private function getColors() : ColorSettingsVO {
		var colors : ColorSettingsVO = new ColorSettingsVO();

		colors.backgroundMain = popup.backgroundMain.selectedColor;
		colors.fieldWhite = popup.fieldWhite.selectedColor;
		colors.fieldBlack = popup.fieldBlack.selectedColor;
		colors.fieldValidDrop = popup.fieldValidDrop.selectedColor;
		colors.fieldMoveHint = popup.fieldMoveHint.selectedColor;
		colors.boardGapColor = popup.boardGapColor.selectedColor;
		colors.boardBorderBackground = popup.boardBorderBackground.selectedColor;
		colors.boardBorderFont = popup.boardBorderFont.selectedColor;
		colors.pieceBlack = popup.pieceBlack.selectedColor;
		colors.pieceBlackBorder = popup.pieceBlackBorder.selectedColor;
		colors.pieceWhite = popup.pieceWhite.selectedColor;
		colors.pieceWhiteBorder = popup.pieceWhiteBorder.selectedColor;

		return colors;
	}

	// End Innerclass Methods


	// Start Object Methods

	// Start Object Methods


	// Start Notification Delegates

	public override function listNotificationInterests() : Array {
		return [
			ApplicationFacade.APPEAR_COLOR_SETTINGS,
			ApplicationFacade.DISAPPEAR_COLOR_SETTINGS
		];
	}

	public override function handleNotification( n : INotification ) : void {
		switch ( n.getName() ) {
			case ApplicationFacade.APPEAR_COLOR_SETTINGS:
				this.handleAppearColorSettings( n.getBody() as ColorSettingsVO, n.getType() is String ? n.getType() as String : null );
			break;
			case ApplicationFacade.DISAPPEAR_COLOR_SETTINGS:
				this.handleDisappearColorSettings();
			break;

		}
	}

	// End Notification Delegates


	// Start Notification Handlers

	private function handleAppearColorSettings( colors : ColorSettingsVO, type : String ) : void {
		if ( type == ApplicationFacade.NOTIFICATION_TYPE_INTERRUPT_APPEAR ) {
			return;
		}

		this.appear();
		this.setColors( colors );
	}

	private function handleDisappearColorSettings() : void {
		this.disappear();
	}

	// End Notification Handlers


	// Start Event Handlers

	private function onClose( e : Event ) : void {
		this.close();
	}

	private function onMouseClick( e : MouseEvent ) : void {
		if ( e.target is Button ) {
			var b : Button = e.target as Button;
			if ( b.id == popup.applyChanges.id ) {
				this.applyChanges();
			}
		}
	}

	private function onColorChange( e : ColorPickerEvent ) : void {
		/*
		if ( e.target is ColorPicker ) {
			var cp : ColorPicker = e.target as ColorPicker;
			log.info( "new color: {0} for {1}", e.color, cp.id );

			var changeSet : ColorSettingsVO = new ColorSettingsVO();

			if ( changeSet.hasOwnProperty( cp.id ) ) {
				changeSet[ cp.id ] = e.color;
				sendNotification( ApplicationFacade.SET_COLOR_SETTINGS, changeSet );
				return;
			}
		}
		*/


	}

	// End Event Handlers


	// Start Getter / Setters

	protected function get popup() : ColorSettingsDialog {
		return this._dialog as ColorSettingsDialog;
	}

	// End Getter / Setters

}
}