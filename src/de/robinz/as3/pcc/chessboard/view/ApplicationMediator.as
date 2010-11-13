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
	public class ApplicationMediator extends Mediator
	{
		public static const UNIT_TESTS : Boolean = false;
		public static const NAME : String = "ApplicationMediator";

		public function ApplicationMediator( m : mainapp ) {
			super( NAME, m );

			if ( UNIT_TESTS ) {
				chessboard.visible = false;
				chessboard.includeInLayout = false;

				view.testRunner.test = createSuite();
				view.testRunner.startTest();
			}
		}

		private function createSuite() : TestSuite {
 			var ts:TestSuite = new TestSuite();
 			ts.addTest( ApplicationTest.suite() );
 			return ts;
 		}

		protected function get chessboard() : Chessboard {
			return this.view.chessboard;
		}
		protected function get view() : ApplicationView {
			return this.app.applicationView;
		}
		protected function get app() : mainapp {
			return this.viewComponent as mainapp;
		}

	}
}