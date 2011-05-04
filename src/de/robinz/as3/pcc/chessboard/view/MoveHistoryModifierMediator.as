package de.robinz.as3.pcc.chessboard.view
{
import de.robinz.as3.pcc.chessboard.ApplicationFacade;
import de.robinz.as3.pcc.chessboard.view.views.moveHistory.MoveHistoryModifier;

import flash.display.DisplayObject;
import flash.events.Event;

import mx.containers.TitleWindow;
import mx.events.CloseEvent;

import org.puremvc.as3.interfaces.INotification;

/**
 * UI Control for Info Panel - Move History
 *
 * @author robin heinel
 */
public class MoveHistoryModifierMediator extends DialogBaseMediator
{
	public static const NAME : String = "MoveHistoryModifierMediator";
	public static const NOTIFICATION_TYPE_INTERRUPT_APPEAR : String = "interruptAppear";

	public function MoveHistoryModifierMediator( viewStage : DisplayObject ) {
		super( NAME, viewStage );
	}

	// Start Mediator overrides ( Notification Delegates excluded, see below )

	// End Mediator overrides ( Notification Delegates excluded, see below )


	// Start Innerclass Methods

	private function appear() : void {
		var view : TitleWindow = this.createDialog( "Browse Move History", 245, 100, MoveHistoryModifier, this.stage );

		view.addEventListener( CloseEvent.CLOSE, onPopupClose );
		view.addEventListener( MoveHistoryModifier.EVENT_MOVE_START, onClickMoveStart );
		view.addEventListener( MoveHistoryModifier.EVENT_MOVE_END, onClickMoveEnd );
		view.addEventListener( MoveHistoryModifier.EVENT_MOVE_FORWARD, onClickMoveForward );
		view.addEventListener( MoveHistoryModifier.EVENT_MOVE_BACKWARD, onClickMoveBackward );

		this._popup = view as MoveHistoryModifier;
		//this._popup.addEventListener( MouseEvent.CLICK, onMouseClick );
	}

	// End Innerclass Methods


	// Start Notification Delegates

	public override function listNotificationInterests() : Array {
		return [
			ApplicationFacade.APPEAR_MOVE_HISTORY_MODIFIER,
			ApplicationFacade.DISAPPEAR_MOVE_HISTORY_MODIFIER
		];
	}

	public override function handleNotification( n : INotification ) : void {
		switch( n.getName() ) {
			case ApplicationFacade.APPEAR_MOVE_HISTORY_MODIFIER:
				this.handleAppearMoveHistoryModifier( n.getType() is String ? n.getType() as String : null );
			break;
			case ApplicationFacade.DISAPPEAR_MOVE_HISTORY_MODIFIER:
				this.handleDisappearMoveHistoryModifier();
			break;
		}
	}

	// End Notification Delegates


	// Start Notification Handlers

	private function handleAppearMoveHistoryModifier( type : String ) : void {
		if ( type == NOTIFICATION_TYPE_INTERRUPT_APPEAR ) {
			return;
		}
		this.appear();
	}

	private function handleDisappearMoveHistoryModifier() : void {
		this.disappear();
	}

	// End Notification Handlers


	// Start Event Handlers

	private function onClickMoveStart( e : Event ) : void {
		sendNotification( ApplicationFacade.MOVE_START );
	}

	private function onClickMoveEnd( e : Event ) : void {
		sendNotification( ApplicationFacade.MOVE_END );
	}

	private function onClickMoveForward( e : Event ) : void {
		sendNotification( ApplicationFacade.MOVE_FORWARD );
	}

	private function onClickMoveBackward( e : Event ) : void {
		sendNotification( ApplicationFacade.MOVE_BACKWARD );
	}

	/* private function onMouseClick( e : MouseEvent ) : void {
		if ( !( e.target is Button ) ) {
			return;
		}

		var b : Button = e.target as Button;


	} */

	protected function onPopupClose( e : CloseEvent ) : void {
		sendNotification( ApplicationFacade.DISAPPEAR_MOVE_HISTORY_MODIFIER );
		this.disappear();
	}

	// End Event Handlers


	// Start Getter / Setters

	protected function get view() : MoveHistoryModifier {
		return this.viewComponent as MoveHistoryModifier;
	}

	// End Getter / Setters
}
}