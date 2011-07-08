package de.robinz.as3.pcc.chessboard.view {
import de.robinz.as3.pcc.chessboard.ApplicationFacade;
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
 * de.robinz.as3.pcc.chessboard.view
 *
 * @author robin heinel
 */
public class ColorSettingsMediator extends DialogBaseMediator {

	public static const NAME : String = "ColorSettingsMediator";

	private var _settings : ColorSettingsVO;

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
		this._settings = new ColorSettingsVO();
		sendNotification( ApplicationFacade.CHANGE_COLOR_SETTINGS, this._settings );
	}

	private function setColors() : void {
		var sets : ColorSettingsVO = new ColorSettingsVO();

		sets.backgroundMain = popup.backgroundMain.selectedColor;
		sets.fieldWhite = popup.fieldWhite.selectedColor;
		sets.fieldBlack = popup.fieldBlack.selectedColor;
		sets.fieldValidDrop = popup.fieldValidDrop.selectedColor;
		sets.fieldMoveHint = popup.fieldMoveHint.selectedColor;
		sets.boardGapColor = popup.boardGapColor.selectedColor;
		sets.boardBorderBackground = popup.boardBorderBackground.selectedColor;
		sets.boardBorderFont = popup.boardBorderFont.selectedColor;
		sets.piece = popup.pieceFont.selectedColor;

		sendNotification( ApplicationFacade.SET_COLOR_SETTINGS, sets );
	}

	// End Innerclass Methods


	// Start Object Methods

	// Start Object Methods


	// Start Notification Delegates

	public override function listNotificationInterests() : Array {
		return [
			ApplicationFacade.COLOR_SETTINGS_CHANGED,
			ApplicationFacade.APPEAR_COLOR_SETTINGS,
			ApplicationFacade.DISAPPEAR_COLOR_SETTINGS
		];
	}

	public override function handleNotification( n : INotification ) : void {
		switch ( n.getName() ) {
			case ApplicationFacade.COLOR_SETTINGS_CHANGED:
				break;
			case ApplicationFacade.APPEAR_COLOR_SETTINGS:
				this.handleAppearColorSettings( n.getType() is String ? n.getType() as String : null );
				break;
			case ApplicationFacade.DISAPPEAR_COLOR_SETTINGS:
				this.handleDisappearColorSettings();
				break;

		}
	}

	// End Notification Delegates


	// Start Notification Handlers

	private function handleAppearColorSettings( type : String ) : void {
		if ( type == ApplicationFacade.NOTIFICATION_TYPE_INTERRUPT_APPEAR ) {
			return;
		}

		this.appear();
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
				this.setColors();
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