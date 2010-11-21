package de.robinz.as3.pcc.chessboard.view
{
	import de.robinz.as3.pcc.chessboard.tests.ApplicationTest;
	import de.robinz.as3.pcc.chessboard.view.views.ApplicationView;
	import de.robinz.as3.pcc.chessboard.view.views.Chessboard;

	import flexunit.framework.TestSuite;

	import org.puremvc.as3.patterns.mediator.Mediator;

	/**
	 * Application startup
	 *
	 * @author Robin Heinel
	 *
	 */
	public class TakenPiecesMediator extends Mediator
	{
		public static const NAME : String = "TakenPiecesMediator";

		public function TakenPiecesMediator( m : Hist ) {
			super( NAME, m );
		}

		protected function get view() : ApplicationView {
			return this.app.applicationView;
		}
	}
}