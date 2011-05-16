package de.robinz.as3.pcc.chessboard.library.vo {
import de.robinz.as3.pcc.chessboard.library.FieldNotation;
import de.robinz.as3.pcc.chessboard.library.pieces.IPiece;

/**
 * de.robinz.as3.pcc.chessboard.library.vo
 *
 * @author robin heinel
 */
public class PiecePositionVO {
	public var piece : IPiece;
	public var notation : FieldNotation;

	public static function create( piece : IPiece, notation : FieldNotation ) : PiecePositionVO {
		var o : PiecePositionVO = new PiecePositionVO();

		o.notation = notation;
		o.piece = piece;

		return o;
	}

}
}