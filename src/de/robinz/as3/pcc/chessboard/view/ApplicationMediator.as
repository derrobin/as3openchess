package de.robinz.as3.pcc.chessboard.view
{
	import de.robinz.as3.pcc.chessboard.tests.ApplicationTest;

	import flexunit.flexui.TestRunnerBase;
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
		public static const UNIT_TESTS : Boolean = true;
		public static const NAME : String = "ApplicationMediator";

		public function ApplicationMediator( m : chessboard ) {
			super( NAME, m );

			if ( UNIT_TESTS ) {
				m.applicationView.chessboard.visible = false;
				m.applicationView.chessboard.includeInLayout = false;

				m.applicationView.testRunner.test = createSuite();
				m.applicationView.testRunner.startTest();
			}
		}

		private function createSuite() : TestSuite {
 			var ts:TestSuite = new TestSuite();
 			ts.addTest( ApplicationTest.suite() );
 			return ts;
 		}


	}
}