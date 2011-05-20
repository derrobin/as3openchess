package de.robinz.as3.pcc.chessboard.library
{
import de.robinz.as3.pcc.chessboard.library.vo.ChessboardGameVO;
import de.robinz.as3.pcc.chessboard.library.FieldNotation;
import de.robinz.as3.pcc.chessboard.library.pieces.IPiece;

/**
 * represents a move of a piece on chessboard
 *
 * @author robin heinel
 */
// TODO: move to VO
public class ChessboardMove
{
	public var piece : IPiece;
	public var fromPosition : FieldNotation;
	public var toPosition : FieldNotation;

	public var position : ChessPosition;

	public var beatenPiece : IPiece;
	public var game : ChessboardGameVO;

	public var isMoveBack : Boolean = false;
	public var isMoveForward : Boolean = false;
	public var isMoveJump : Boolean = false;

	// TODO: remove this member block, because they are located at validMove!
	public var isCastlingLong : Boolean = false;
	public var isCastlingShort : Boolean = false;
	public var isEnPassant : Boolean = false;
	public var isPawnDoubleJump : Boolean = false;

	public var isCastlingRookMovement : Boolean = false;

	public var validMoves : ChessboardMoveCollection;
	public var validMove : ChessboardMove; // created by MoveValidator, holds more validation info about current move


	public function ChessboardMove()
	{
	}

	public function equals( move : ChessboardMove ) : Boolean {
		var c1 : Boolean = this.fromPosition.toString() == move.fromPosition.toString();
		var c2 : Boolean = this.toPosition.toString() == move.toPosition.toString();

		if ( move.isMoveBack ) {
			c1 = this.toPosition.toString() == move.fromPosition.toString();
			c2 = this.fromPosition.toString() == move.toPosition.toString();
		}

		var c3 : Boolean = this.piece.getName() == move.piece.getName();
		var c4 : Boolean = this.piece.isWhite == move.piece.isWhite;
		var c5 : Boolean = this.game.currentMove == move.game.currentMove;

		//return c5;
		return c1 && c2 && c3 && c4 && c5;
	}

	public function clone() : ChessboardMove {
		var o : ChessboardMove = new ChessboardMove();
		o.beatenPiece = this.beatenPiece;
		o.fromPosition = this.fromPosition;
		o.toPosition = this.toPosition;
		o.piece = this.piece;
		o.game = this.game;
		o.position = this.position;
		o.validMove = this.validMove;
		o.validMoves = this.validMoves;
		return o;
	}

}
}