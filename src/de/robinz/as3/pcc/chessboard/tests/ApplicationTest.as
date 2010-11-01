package de.robinz.as3.pcc.chessboard.tests
{
	import flexunit.framework.TestCase;
	import flexunit.framework.TestSuite;


	public class ApplicationTest extends TestCase {
		public function ApplicationTest( methodName : String ) {
			super( methodName );
		}

		public static function suite() : TestSuite {
			var ts:TestSuite = new TestSuite();
			ts.addTest( new ApplicationTest( "test1" ) );
			return ts;
		}

		public function test1():void {
			assertTrue( "Test 1", 1 == 1 );
		}

	}
}