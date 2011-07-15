package de.robinz.as3.pcc.chessboard.library {
import de.robinz.as3.pcc.chessboard.library.common.LoggerFactory;
import de.robinz.as3.pcc.chessboard.library.pieces.IPiece;
import de.robinz.as3.pcc.chessboard.library.pieces.King;
import de.robinz.as3.pcc.chessboard.library.pieces.Pawn;
import de.robinz.as3.pcc.chessboard.library.vo.ChessboardGameVO;
import de.robinz.as3.pcc.chessboard.library.vo.PiecePositionVO;

import mx.logging.ILogger;

/**
 * MoveValidator
 *
 * @author robin heinel
 */
public class MoveValidator {
	private var log : ILogger;

	private var _game : ChessboardGameVO;
	private var _piece : PiecePositionVO;
	private var _position : ChessPosition;

	public static var CASTLING_SHORT : String = "castlingShort";
	public static var CASTLING_LONG : String = "castlingLong";
	public static var EN_PASSANT : String = "enPassant";


	public function MoveValidator( game : ChessboardGameVO, position : ChessPosition, piece : PiecePositionVO ) {
		this.log = LoggerFactory.getLogger( this );

		this._game 		= game;
		this._position 	= position;
		this._piece 	= piece;
	}

	public function getValidMoves() : ChessboardMoveCollection {
		var piece : IPiece = this._position.getPieceAt( this._piece.notation.toString() );

		// get valid fields by geometric
		var moves : ChessboardMoveCollection = this._piece.piece.getGeometricValidMoviesToField( this._piece.notation, this._position );

		// exclude fields behind pieces
		//var fieldsBehind : FieldNotationCollection = this.getFieldsBehindPieces();
		//moves.excludeToPositions( fieldsBehind );

		/*
		if ( this._game.check ) {
			log.info( "getValidMoves: check from {0} to {1}", this._game.check.fromPiece.piece.getName(), this._game.check.toKing.piece.isWhite ? "white" : "black" );
		}
		*/

		// merge special moves
		/*
		var specialMoves : FieldNotationCollection = this.getSpecialMoves();
		log.info( "getValidMoves: specialMoves found {0}", specialMoves.length );
		this.mergeMovesFromNotations( specialMoves, moves );
        */
		return moves;
	}

	private function mergeMovesFromNotations( notations : FieldNotationCollection, addToMoves : ChessboardMoveCollection ) : void {
		var m : ChessboardMove;
		var n : FieldNotation;
		for each ( n in notations.list ) {
			m = new ChessboardMove();
			m.fromField = this._piece.notation;
			m.piece = this._piece.piece;
			m.toField = n;
			m.game = this._game;

			m.isCastlingLong = n.name == CASTLING_LONG;
			m.isCastlingShort = n.name == CASTLING_SHORT;
			m.isEnPassant = n.name == EN_PASSANT;

			addToMoves.add( m );
		}
	}

	private function getSpecialMoves() : FieldNotationCollection {
		var field : FieldNotation;
		var moves : FieldNotationCollection = new FieldNotationCollection();

		log.debug( "getSpecialMoves: currentPlayer: " + this._game.currentPlayer.name );

		if ( this._piece.piece is King ) {
			moves.addCollection( this.getRochade() );
		}

		if ( this._piece.piece is Pawn ) {
			moves.add( this.getEnPassion() );
		}

		return moves;
	}

	private function getRochade() : FieldNotationCollection {
		var moves : FieldNotationCollection = new FieldNotationCollection();
		var p : Player = this._game.currentPlayer;

		if ( ! p.isKingMoved ) {
			/*
			var npl : PiecePositionVO = getNextPieceOnLane( 0, -1 ); // next piece left
			var npr : PiecePositionVO = getNextPieceOnLane( 0, +1 ); // next piece right

			if ( p.isWhite ) {
				if ( ! p.isRookRightMoved && npr != null && npr.piece is Rook && npr.notation.toString() == "h1" ) {
					moves.add( FieldNotation.createNotationByString( "g1", CASTLING_SHORT ) );
				}
				if ( ! p.isRookLeftMoved && npl != null && npl.piece is Rook && npl.notation.toString() == "a1" ) {
					moves.add( FieldNotation.createNotationByString( "c1", CASTLING_LONG ) );
				}
			} else {
				if ( ! p.isRookRightMoved && npr != null && npr.piece is Rook && npr.notation.toString() == "h8" ) {
					moves.add( FieldNotation.createNotationByString( "g8", CASTLING_SHORT ) );
				}
				if ( ! p.isRookLeftMoved && npl != null && npl.piece is Rook && npl.notation.toString() == "a8" ) {
					moves.add( FieldNotation.createNotationByString( "c8", CASTLING_LONG ) );
				}
			}
			*/
		}

		return moves;
	}

	private function getEnPassion() : FieldNotation {
		var lastMove : ChessboardMove = this._game.moves.getLastMove();
		var player : Player = this._game.currentPlayer;

		if ( lastMove == null ) {
			return null;
		}

		if ( lastMove.piece is Pawn && lastMove.isPawnDoubleJump ) {
			log.debug( "last piece was pawn with double jump." );
			var pawn : Pawn = lastMove.piece as Pawn;
			var notation : String;
			var rightColumn : String = FieldNotation.getColumn( this._piece.notation.column, -1 );
			var leftColumn : String = FieldNotation.getColumn( this._piece.notation.column, +1 );
			var newRow : int = player.isWhite ? this._piece.notation.row + 1 : this._piece.notation.row - 1;

			if ( lastMove.toField.row == this._piece.notation.row ) {
				if ( lastMove.toField.column == rightColumn ) {
					log.debug( "en passant on right" );
					notation = rightColumn + newRow.toString();

				}
				if ( lastMove.toField.column == leftColumn ) {
					log.debug( "en passant on left" );
					notation = leftColumn + newRow.toString();
				}

				if ( notation == null ) {
					return null;
				}

				return FieldNotation.createNotationByString( notation, EN_PASSANT );
			}
		}

		return null;
	}


}
}