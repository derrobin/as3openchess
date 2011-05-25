/**
 * Author: Vitali Monastyrjow
 * Date: 5/23/11
 * Time: 10:46 AM
 */
package flex.moverange {
import de.robinz.as3.pcc.chessboard.library.FieldNotation;
import de.robinz.as3.pcc.chessboard.library.FieldNotationCollection;
import de.robinz.as3.pcc.chessboard.library.pieces.moverange.DiagonalRange;
import de.robinz.as3.pcc.chessboard.library.pieces.moverange.StraightRange;

import org.flexunit.Assert;

public class MoveRangeTest {

		[Test]
		public function testStraitRange() : void {
			var testField : FieldNotation = FieldNotation.createNotationByString("e1");

			var range : FieldNotationCollection = new StraightRange().getRangeToField( testField );

			Assert.assertEquals( "e2", ( range.list.getItemAt(0) as FieldNotation ).getNotation() );
			Assert.assertEquals( "e3", ( range.list.getItemAt(1) as FieldNotation ).getNotation() );
			Assert.assertEquals( "e8", ( range.list.getItemAt(6) as FieldNotation ).getNotation() );
			Assert.assertEquals( "a1", ( range.list.getItemAt(7) as FieldNotation ).getNotation() );
			Assert.assertEquals( "b1", ( range.list.getItemAt(8) as FieldNotation ).getNotation() );
			Assert.assertEquals( "h1", ( range.list.getItemAt(13) as FieldNotation ).getNotation() );
		}

		[Test]
		public function testDiagonalRange() : void {
			var testField : FieldNotation = FieldNotation.createNotationByString("e1");

			var range : FieldNotationCollection = new DiagonalRange().getRangeToField( testField );
			Assert.assertEquals( "f2", ( range.list.getItemAt(0) as FieldNotation ).getNotation() );
			Assert.assertEquals( "g3", ( range.list.getItemAt(1) as FieldNotation ).getNotation() );
			Assert.assertEquals( "h4", ( range.list.getItemAt(2) as FieldNotation ).getNotation() );
			Assert.assertEquals( "d2", ( range.list.getItemAt(3) as FieldNotation ).getNotation() );
			Assert.assertEquals( "a5", ( range.list.getItemAt(6) as FieldNotation ).getNotation() );

			Assert.assertEquals( 7, range.length );

		}
	}
}
