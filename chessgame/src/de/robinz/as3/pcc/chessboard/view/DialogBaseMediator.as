package de.robinz.as3.pcc.chessboard.view
{
import flash.display.DisplayObject;

import mx.containers.TitleWindow;
import mx.core.Container;
import mx.managers.PopUpManager;

/**
 * SaveGameDialogMediator
 *
 * @author robin heinel
 */
public class DialogBaseMediator extends BaseMediator
{
	protected var _dialog : Container;

	public function DialogBaseMediator( name : String, viewStage : DisplayObject ) {
		super( name, viewStage );
	}


	// Start Innerclass Methods

	protected function disappear() : void {
		PopUpManager.removePopUp( this._dialog );
	}

	protected function createDialog( title : String, width : int, height : int, target : Class, stage : DisplayObject, modalDialog : Boolean = false ) : TitleWindow {
		var view : TitleWindow = TitleWindow( PopUpManager.createPopUp( stage, target, modalDialog ) );
		view.width = width;
		view.height = height;
		PopUpManager.centerPopUp( view );
		view.title = title;
		view.setStyle( "borderAlpha", 0.9 );
		view.showCloseButton = true;

		this._dialog = view;
		return view;
	}

	// End Innerclass Methods


	// Start Notification Delegates

	// End Notification Delegates


	// Start Notification Handlers

	// End Notification Handlers


	// Start Event Handlers

	// End Event Handlers


	// Start Getter / Setters

	protected function get stage() : DisplayObject {
		return this.viewComponent as DisplayObject;
	}

	// End Getter / Setters

}
}