/**
 * Author: Vitali Monastyrjow
 * Date: 5/23/11
 * Time: 10:46 AM
 */
package flex.moverange {
import de.robinz.as3.pcc.chessboard.library.FieldNotation;
import de.robinz.as3.pcc.chessboard.library.FieldNotationCollection;
import de.robinz.as3.pcc.chessboard.library.pieces.moverange.BishopRange;
import de.robinz.as3.pcc.chessboard.library.pieces.moverange.KingRange;
import de.robinz.as3.pcc.chessboard.library.pieces.moverange.KnightRange;
import de.robinz.as3.pcc.chessboard.library.pieces.moverange.RookRange;

import org.flexunit.Assert;

public class MoveRangeTest {

		[Test]
		public function testRookRange() : void {
			var testField : FieldNotation = FieldNotation.createNotationByString("e1");

			var range : FieldNotationCollection = new RookRange().getRangeToField( testField );

			Assert.assertEquals( "e2", ( range.list.getItemAt(0) as FieldNotation ).getNotation() );
			Assert.assertEquals( "e3", ( range.list.getItemAt(1) as FieldNotation ).getNotation() );
			Assert.assertEquals( "e8", ( range.list.getItemAt(6) as FieldNotation ).getNotation() );
			Assert.assertEquals( "d1", ( range.list.getItemAt(7) as FieldNotation ).getNotation() );
			Assert.assertEquals( "c1", ( range.list.getItemAt(8) as FieldNotation ).getNotation() );
			Assert.assertEquals( "h1", ( range.list.getItemAt(13) as FieldNotation ).getNotation() );
		}

		[Test]
		public function testBishopRange() : void {
			var testField : FieldNotation = FieldNotation.createNotationByString("e1");

			var range : FieldNotationCollection = new BishopRange().getRangeToField( testField );
			Assert.assertEquals( "d2", ( range.list.getItemAt(0) as FieldNotation ).getNotation() );
			Assert.assertEquals( "c3", ( range.list.getItemAt(1) as FieldNotation ).getNotation() );
			Assert.assertEquals( "b4", ( range.list.getItemAt(2) as FieldNotation ).getNotation() );
			Assert.assertEquals( "a5", ( range.list.getItemAt(3) as FieldNotation ).getNotation() );
			Assert.assertEquals( "h4", ( range.list.getItemAt(6) as FieldNotation ).getNotation() );

			Assert.assertEquals( 7, range.length );

		}

		[Test]
		public function testKingRange() : void {
			var testField : FieldNotation = FieldNotation.createNotationByString("e2");

			var range : FieldNotationCollection = new KingRange().getRangeToField( testField );
			Assert.assertEquals( 8, range.length );

			Assert.assertEquals( "e3", ( range.list.getItemAt(0) as FieldNotation).getNotation() );
			Assert.assertEquals( "e1", ( range.list.getItemAt(1) as FieldNotation).getNotation() );
			Assert.assertEquals( "d2", ( range.list.getItemAt(2) as FieldNotation).getNotation() );
			Assert.assertEquals( "f2", ( range.list.getItemAt(3) as FieldNotation).getNotation() );
			Assert.assertEquals( "d1", ( range.list.getItemAt(4) as FieldNotation).getNotation() );
			Assert.assertEquals( "d3", ( range.list.getItemAt(5) as FieldNotation).getNotation() );
			Assert.assertEquals( "f3", ( range.list.getItemAt(6) as FieldNotation).getNotation() );
			Assert.assertEquals( "f1", ( range.list.getItemAt(7) as FieldNotation).getNotation() );

		}

		[Test]
		public function testKnightRange() : void {
			var testField : FieldNotation  = FieldNotation.createNotationByString("e5");

			var range : FieldNotationCollection = new KnightRange().getRangeToField( testField );
			Assert.assertEquals( 8, range.length );

			Assert.assertEquals( "c6", ( range.list.getItemAt(0) as FieldNotation).getNotation() );
			Assert.assertEquals( "d7", ( range.list.getItemAt(1) as FieldNotation).getNotation() );
			Assert.assertEquals( "g6", ( range.list.getItemAt(2) as FieldNotation).getNotation() );
			Assert.assertEquals( "f7", ( range.list.getItemAt(3) as FieldNotation).getNotation() );
			Assert.assertEquals( "c4", ( range.list.getItemAt(4) as FieldNotation).getNotation() );
			Assert.assertEquals( "d3", ( range.list.getItemAt(5) as FieldNotation).getNotation() );
			Assert.assertEquals( "g4", ( range.list.getItemAt(6) as FieldNotation).getNotation() );
			Assert.assertEquals( "f3", ( range.list.getItemAt(7) as FieldNotation).getNotation() );
		}
	}
}
