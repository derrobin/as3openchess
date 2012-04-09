package de.robinz.as3.pcc.chessboard.library.vo {
/**
 * de.robinz.as3.pcc.chessboard.library.vo
 *
 * @author robin heinel
 */
public class ChessCheckVO {
	public var fromPiece : PiecePositionVO;
	public var toKing : PiecePositionVO;

	public static function create( fromPiece : PiecePositionVO, toKing : PiecePositionVO ) : ChessCheckVO {
		var o : ChessCheckVO = new ChessCheckVO();
		o.fromPiece = fromPiece;
		o.toKing = toKing;
		return o;
	}
}
}