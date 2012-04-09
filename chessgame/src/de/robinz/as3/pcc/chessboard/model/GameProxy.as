package de.robinz.as3.pcc.chessboard.model
{
import de.robinz.as3.pcc.chessboard.ApplicationFacade;
import de.robinz.as3.pcc.chessboard.library.ChessboardMove;
import de.robinz.as3.pcc.chessboard.library.ChessboardMoveCollection;
import de.robinz.as3.pcc.chessboard.library.FieldNotation;
import de.robinz.as3.pcc.chessboard.library.Player;
import de.robinz.as3.pcc.chessboard.library.pieces.IPiece;
import de.robinz.as3.pcc.chessboard.library.pieces.King;
import de.robinz.as3.pcc.chessboard.library.pieces.Piece;
import de.robinz.as3.pcc.chessboard.library.pieces.Rook;
import de.robinz.as3.pcc.chessboard.library.vo.ChessboardGameVO;
import de.robinz.as3.pcc.chessboard.library.vo.PiecePositionVO;

/**
 * GameProxy
 *
 * @author robin heinel
 */
public class GameProxy extends BaseProxy
{
	public static const NAME : String = "GameProxy";

	private var _game : ChessboardGameVO;
	private var _currentPlayer : Player;
	private var _currentMove : int;
	private var _white : Player;
	private var _black : Player;

	public function GameProxy( data : Object = null ) {
		super( NAME, data );

		this._game = new ChessboardGameVO();
		this._currentMove = 0;
	}

	// Start proxy overrides

	public override function getProxyName() : String {
		return NAME;
	}

	// End proxy overrides


	// Start innerclass methods

	/* private function getMoveIndex( move : ChessboardMove ) : Boolean {
		var m : ChessboardMove;
		for each( m in this._game.moves.list ) {
			if ( m.equals( move )
		}
	} */

	// End innerclass methods


	// Start Proxy Interface

	public function moveIndex( move : ChessboardMove ) : int {
		var moves : ChessboardMoveCollection = this._game.moves;
		var m : ChessboardMove;
		var index : int = 0;
		for each( m in moves.list ) {
			if ( m.equals( move ) ) {
				return index;
			}
			index++;
		}

		return 0;
	}

	public function start( white : Player, black : Player ) : void {
		this._white = white;
		this._black = black;

		this._currentPlayer = white;
	}

	public function reset() : void {
		this._game = new ChessboardGameVO();
		this._currentMove = 0;
	}

	public function moveForward() : ChessboardMove {
		if ( this._currentMove >= this._game.moves.length ) {
			return null;
		}

		this._currentMove++;
		var move : ChessboardMove = this._game.moves.getAt( this._currentMove - 1 );
		return move;
	}

	public function moveBack() : ChessboardMove {
		if ( this._currentMove == 0 || this._game.moves.length == 0 ) {
			return null;
		}

		var move : ChessboardMove = this._game.moves.getAt( this._currentMove - 1 );
		this._currentMove--;
		return move;
	}

	public function move( m : ChessboardMove ) : void {
		if ( m.isMoveBack || m.isMoveForward ) {
			return;
		}
		if ( ! m.isCastlingRookMovement ) {
			this._currentMove++;
			this._game.moves.add( m );
		}

		// for rochade
		if ( m.piece is King ) {
			this._currentPlayer.moveKing();
		}
		if ( m.piece is Rook ) {
			if ( this._currentPlayer.isWhite ) {
				if ( m.fromField.toString() == "a1" ) {
					this._white.rookLeftMoved();
				}
				if ( m.fromField.toString() == "h1" ) {
					this._white.rookRightMoved();
				}
			} else {
				if ( m.fromField.toString() == "a8" ) {
					this._black.rookLeftMoved();
				}
				if ( m.fromField.toString() == "h8" ) {
					this._black.rookRightMoved();
				}
			}
		}

		if ( ! m.isCastlingRookMovement ) {
			this._currentPlayer = this._currentPlayer.isWhite ? this._black : this._white;
		}

	}

	public function getCurrentGame() : ChessboardGameVO {
		this._game.currentMove = this._currentMove;
		this._game.currentPlayer = this._currentPlayer;
		this._game.isLastMove = this._currentMove == this._game.moves.length
			? true
			: false;

		return this._game;
	}

	public function setPiece( pieceName : String, shortenNotation : String, isWhite : Boolean ) : void {
		var piece : IPiece = Piece.createByParams( pieceName, isWhite );
		var notation : FieldNotation = FieldNotation.createNotationByString( shortenNotation );

		sendNotification( ApplicationFacade.SET_PIECE, PiecePositionVO.create( piece, notation ) );
	}

	// End Proxy Interface


	// Start Innerclass Methods

	// End Innerclass Methods


	// Start Getter / Setters

	public function get currentMove() : int {
		return this._currentMove;
	}

	// End Getter / Setters
}
}