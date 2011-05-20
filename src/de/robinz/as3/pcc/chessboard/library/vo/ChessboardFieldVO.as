package de.robinz.as3.pcc.chessboard.library.vo {
import de.robinz.as3.pcc.chessboard.library.FieldNotation;

/**
 * ChessboardFieldVO
 *
 * @author robin heinel
 */
public class ChessboardFieldVO {
	public var isWhite : Boolean;
	public var notation : FieldNotation;

	public function clone() {
		var o : ChessboardFieldVO = new ChessboardFieldVO();
		o.isWhite = this.isWhite;
		o.notation = this.notation.clone();
		return o;
	}
}
}