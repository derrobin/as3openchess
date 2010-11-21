package de.robinz.as3.pcc.chessboard.view
{
	import de.robinz.as3.pcc.chessboard.view.views.ChessboardMenubar;

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
		}

		protected function get view() : ChessboardMenubar {
			return this.viewComponent as ChessboardMenubar;
		}
	}
}