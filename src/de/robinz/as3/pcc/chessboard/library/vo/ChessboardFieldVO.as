package de.robinz.as3.pcc.chessboard.library.vo {
import de.robinz.as3.pcc.chessboard.library.FieldNotation;
import de.robinz.as3.pcc.chessboard.library.vo.ChessboardFieldVO;

/**
 * de.robinz.as3.pcc.chessboard.library.vo
 *
 * @author robin heinel
 */
public class ChessboardFieldVO {
	// TODO: place IPiece here
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