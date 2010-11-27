package de.robinz.as3.pcc.chessboard.view
{
	import de.robinz.as3.pcc.chessboard.ApplicationFacade;
	import de.robinz.as3.pcc.chessboard.view.views.ChessboardMenubar;

	import mx.events.MenuEvent;

	import org.puremvc.as3.patterns.mediator.Mediator;

	/**
	 * UI Control for Application Menu Bar
	 *
	 * @author Robin Heinel
	 *
	 */
	public class MenubarMediator extends Mediator
	{
		public static const NAME : String = "MenubarMediator";

		public function MenubarMediator( m : ChessboardMenubar ) {
			super( NAME, m );

			this.view.menuBar.addEventListener( MenuEvent.CHANGE, onMenuBarChange );
		}

		private function onMenuBarChange( e : MenuEvent ) : void {
			trace(e.item.@data);
			var selectedValue : String = "";
			try {
				selectedValue = String( e.item.@data );
				switch( selectedValue ) {
					case ChessboardMenubar.MENU_ENTRY_MEW_GAME:
						sendNotification( ApplicationFacade.NEW_GAME );
					break;
				}
			} catch( e : Error ) {
				trace(e.getStackTrace());
			}
		}

		protected function get view() : ChessboardMenubar {
			return this.viewComponent as ChessboardMenubar;
		}
	}
}