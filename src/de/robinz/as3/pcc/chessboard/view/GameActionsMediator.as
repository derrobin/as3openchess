package de.robinz.as3.pcc.chessboard.view
{
import de.robinz.as3.pcc.chessboard.view.views.ChessboardGameActions;

import org.puremvc.as3.interfaces.INotification;

/**
 * GameActionsMediator
 *
 * @author robin heinel
 */
public class GameActionsMediator extends BaseMediator
{
	public static const NAME : String = "GameActionsMediator";


	public function GameActionsMediator( view : ChessboardGameActions ) {
		super( NAME, view );
	}


	// Start Innerclass Methods


	// End Innerclass Methods


	// Start Notification Delegates

	public override function listNotificationInterests() : Array {
		return [
		];
	}

	public override function handleNotification( n : INotification ) : void {
		switch( n.getName() ) {
		}
	}

	// End Notification Delegates


	// Start Notification Handlers


	// End Notification Handlers


	// Start Event Handlers

	// End Event Handlers


	// Start Getter / Setters

	protected function get view() : ChessboardGameActions {
		return viewComponent as ChessboardGameActions;
	}

	// End Getter / Setters

}
}