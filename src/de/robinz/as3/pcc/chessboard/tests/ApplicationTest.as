package de.robinz.as3.pcc.chessboard.tests
{
import flexunit.framework.TestCase;
import flexunit.framework.TestSuite;

/**
 * ApplicationTest
 *
 * @author robin heinel
 */
public class ApplicationTest extends TestCase {
	public function ApplicationTest( methodName : String ) {
		super( methodName );
	}

	public static function suite() : TestSuite {
		var ts:TestSuite = new TestSuite();
		ts.addTest( new ApplicationTest( "test1" ) );
		ts.addTest( new ApplicationTest( "test2" ) );
		ts.addTest( new ApplicationTest( "test3" ) );
		return ts;
	}

	public function test1():void {
		assertTrue( "Test 1", true );
	}

	public function test2():void {
		assertTrue( "Test 2", false );
	}

	public function test3():void {
		assertTrue( "Test 3", true );
	}

}
}