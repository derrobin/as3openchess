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

	private var _isCastlingLong : Boolean = false;
	private var _isCastlingShort : Boolean = false;
	private var _isEnPassant : Boolean = false;
	private var _isPawnDoubleJump : Boolean = false;

	public var isCastlingRookMovement : Boolean = false;

	public var validMoves : ChessboardMoveCollection;
	public var validMove : ChessboardMove; // created by MoveValidator, holds more validation info about current move

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

	// Start Getters / Setters

	public function set isCastlingLong( value : Boolean ) {
		this._isCastlingLong = value;
	}
	public function get isCastlingLong() : Boolean {
		if ( this.validMove == null ) {
			return this._isCastlingLong;
		}
		return this.validMove.isCastlingLong;
	}

	public function set isCastlingShort( value : Boolean ) {
		this._isCastlingShort = value;
	}
	public function get isCastlingShort() : Boolean {
		if ( this.validMove == null ) {
			return this._isCastlingShort;
		}
		return this.validMove.isCastlingShort;
	}

	public function set isEnPassant( value : Boolean ) {
		this._isEnPassant = value;
	}
	public function get isEnPassant() : Boolean {
		if ( this.validMove == null ) {
			return this._isEnPassant;
		}
		return this.validMove.isEnPassant;
	}

	public function set isPawnDoubleJump( value : Boolean ) {
		this._isPawnDoubleJump = value;
	}
	public function get isPawnDoubleJump() : Boolean {
		if ( this.validMove == null ) {
			return this._isPawnDoubleJump;
		}
		return this.validMove.isPawnDoubleJump;
	}

	// End Getters / Setters

}
}