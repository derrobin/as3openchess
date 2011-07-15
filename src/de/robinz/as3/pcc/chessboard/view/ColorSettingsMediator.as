package de.robinz.as3.pcc.chessboard.view {
import de.robinz.as3.pcc.chessboard.ApplicationFacade;
import de.robinz.as3.pcc.chessboard.library.ColorTheme;
import de.robinz.as3.pcc.chessboard.library.common.ListItem;
import de.robinz.as3.pcc.chessboard.library.vo.ColorSettingsAppearVO;
import de.robinz.as3.pcc.chessboard.view.views.game.ColorSettingsDialog;

import flash.events.Event;
import flash.events.MouseEvent;
import flash.utils.Dictionary;

import mx.containers.TitleWindow;
import mx.controls.Button;

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

		this._dialog = view as ColorSettingsDialog;
		this._dialog.addEventListener( MouseEvent.CLICK, onMouseClick );
	}

	private function close() : void {
		sendNotification( ApplicationFacade.DISAPPEAR_COLOR_SETTINGS );
		this.disappear();
	}

	private function applyChanges() : void {
		sendNotification( ApplicationFacade.CHANGE_COLOR_SETTINGS, this.popup.readControls() );
	}

	private function setThemes( themes : Dictionary ) : void {
		var dataProvider : Array = new Array();
		dataProvider.push( new ListItem( "- select theme -", null ) );
		for each( var theme : ColorTheme in themes ) {
			dataProvider.push( new ListItem( theme.name, theme ) );
		}
		this.popup.theme.dataProvider = dataProvider;
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
				this.handleAppearColorSettings( n.getBody() as ColorSettingsAppearVO, n.getType() is String ? n.getType() as String : null );
			break;
			case ApplicationFacade.DISAPPEAR_COLOR_SETTINGS:
				this.handleDisappearColorSettings();
			break;

		}
	}

	// End Notification Delegates


	// Start Notification Handlers

	private function handleAppearColorSettings( appear : ColorSettingsAppearVO, type : String ) : void {
		if ( type == ApplicationFacade.NOTIFICATION_TYPE_INTERRUPT_APPEAR ) {
			return;
		}

		this.appear();

		this.popup.bindControls( appear.currentColors );
		this.setThemes( appear.colorThemes );
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

	// End Event Handlers


	// Start Getter / Setters

	protected function get popup() : ColorSettingsDialog {
		return this._dialog as ColorSettingsDialog;
	}

	// End Getter / Setters

}
}