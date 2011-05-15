package de.robinz.as3.pcc.chessboard.library {
import de.robinz.as3.pcc.chessboard.library.common.LoggerFactory;
import de.robinz.as3.pcc.chessboard.library.pieces.IPiece;
import de.robinz.as3.pcc.chessboard.library.pieces.King;
import de.robinz.as3.pcc.chessboard.library.pieces.Pawn;
import de.robinz.as3.pcc.chessboard.library.pieces.Rook;
import de.robinz.as3.pcc.chessboard.library.vo.ChessboardFieldVO;
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
	private var _field : ChessboardFieldVO;
	private var _piece : IPiece;
	private var _position : ChessPosition;

	public static var CASTLING_SHORT : String = "castlingShort";
	public static var CASTLING_LONG : String = "castlingLong";
	public static var EN_PASSANT : String = "enPassant";


	public function MoveValidator( game : ChessboardGameVO, field : ChessboardFieldVO, position : ChessPosition, piece : IPiece ) {
		this.log = LoggerFactory.getLogger( this );

		this._game = game;
		this._field = field;
		this._position = position;
		this._piece = piece;
	}

	public function getValidMoves() : ChessboardMoveCollection {
		var piece : IPiece = this._position.getPieceAt( this._field.notation.toString() );

		// get valid fields by geometric
		var moves : ChessboardMoveCollection = this.getValidMovesByPieceGeometric();

		// exclude fields behind pieces
		var fieldsBehind : FieldNotationCollection = this.getFieldsBehindPieces();
		moves.excludeToPositions( fieldsBehind );

		// merge special moves
		var specialMoves : FieldNotationCollection = this.getSpecialMoves();
		log.info( "getValidMoves: specialMoves found {0}", specialMoves.length );
		this.mergeMovesFromNotations( specialMoves, moves );

		return moves;
	}

	private function mergeMovesFromNotations( notations : FieldNotationCollection, addToMoves : ChessboardMoveCollection ) : void {
		var m : ChessboardMove;
		var n : FieldNotation;
		for each ( n in notations.list ) {
			m = new ChessboardMove();
			m.fromPosition = this._field.notation;
			m.piece = this._piece;
			m.toPosition = n;
			m.game = this._game;

			m.isCastlingLong = n.name == CASTLING_LONG;
			m.isCastlingShort = n.name == CASTLING_SHORT;
			m.isEnPassant = n.name == EN_PASSANT;

			addToMoves.add( m );
		}
	}

	private function getFieldsBehindPieces() : FieldNotationCollection {
		var list : FieldNotationCollection = new FieldNotationCollection(); // cross lanes

		if ( this._piece.hasAbilityToBeatDiagonal ) {
			list.addCollection( this.getFieldBehindCrossLanes() );
		}
		if ( this._piece.hasAbilityToBeatLine ) {
			list.addCollection( this.getFieldBehindDirectLanes() );
		}

		if ( this._piece is Pawn ) {
			var notation : FieldNotation = this.getFieldBehindPawnFirstMove();
			if ( notation != null ) {
				list.add( notation );
			}
		}

		return list;
	}

	private function getSpecialMoves() : FieldNotationCollection {
		var field : FieldNotation;
		var moves : FieldNotationCollection = new FieldNotationCollection();

		log.debug( "getSpecialMoves: currentPlayer: " + this._game.currentPlayer.name );

		if ( this._piece is King ) {
			moves.addCollection( this.getRochade() );
		}

		if ( this._piece is Pawn && ! this._piece.hasMoved ) {
			moves.add( this.getEnPassion() );
		}

		return moves;
	}

	private function getRochade() : FieldNotationCollection {
		var moves : FieldNotationCollection = new FieldNotationCollection();
		var p : Player = this._game.currentPlayer;

		if ( ! p.isKingMoved ) {
			var npl : PiecePositionVO = getNextPieceOnLane( 0, -1 ); // next piece left
			var npr : PiecePositionVO = getNextPieceOnLane( 0, +1 ); // next piece right

			if ( p.isWhite ) {
				if ( ! p.isRookRightMoved && npr != null && npr.piece is Rook && npr.notation.toString() == "h1" ) {
					//log.debug( "add notation for short rochade" );
					moves.add( FieldNotation.createNotationByString( "g1", CASTLING_SHORT ) );
				}
				if ( ! p.isRookLeftMoved && npl != null && npl.piece is Rook && npl.notation.toString() == "a1" ) {
					//log.debug( "add notation for long rochade" );
					moves.add( FieldNotation.createNotationByString( "c1", CASTLING_LONG ) );
				}
			} else {
				if ( ! p.isRookRightMoved && npr != null && npr.piece is Rook && npr.notation.toString() == "h8" ) {
					//log.debug( "add notation for short rochade" );
					moves.add( FieldNotation.createNotationByString( "g8", CASTLING_SHORT ) );
				}
				if ( ! p.isRookLeftMoved && npl != null && npl.piece is Rook && npl.notation.toString() == "a8" ) {
					//log.debug( "add notation for long rochade" );
					moves.add( FieldNotation.createNotationByString( "c8", CASTLING_LONG ) );
				}
			}
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
			var rightColumn : String = FieldNotation.getColumn( this._field.notation.column, -1 );
			var leftColumn : String = FieldNotation.getColumn( this._field.notation.column, +1 );
			var newRow : int = player.isWhite ? this._field.notation.row + 1 : this._field.notation.row - 1;

			if ( lastMove.toPosition.row == this._field.notation.row ) {
				if ( lastMove.toPosition.column == rightColumn ) {
					log.debug( "en passant on right" );
					notation = rightColumn + newRow.toString();

				}
				if ( lastMove.toPosition.column == leftColumn ) {
					log.debug( "en passant on left" );
					notation = leftColumn + newRow.toString();
				}

				return FieldNotation.createNotationByString( notation, EN_PASSANT );
			}
		}

		return null;
	}

	private function getFieldBehindPawnFirstMove() : FieldNotation {
		var pawn : Pawn = this._piece as Pawn;
		var n : FieldNotation = this._field.notation.clone();

		if ( pawn.isStartPosition( n ) ) {
			var p : IPiece;
			var setRow : int = 1;

			if ( ! this._piece.isWhite ) {
				setRow = -1;
			}

			n.setRow( setRow );
			p = this._position.getPieceAt( n.toString() );
			if ( p != null ) {
				log.debug( "move collision / pawn at {0}", n.toString() );
				n.setRow( setRow );
				return n;
			}
		}

		return null;
	}

	// get field range for line / diagonal
	private function getFieldBehindCrossLanes() {
		var list : FieldNotationCollection = new FieldNotationCollection();
		log.info( "diagonal: get next piece for top left" );
		var topLeft : FieldNotationCollection = getFieldsBehind( +1, -1 );
		log.info( "diagonal: get next piece for top left" );
		var topRight : FieldNotationCollection = getFieldsBehind( +1, +1 );
		log.info( "diagonal: get next piece for down left" );
		var downLeft : FieldNotationCollection = getFieldsBehind( -1, -1 );
		log.info( "diagonal: get next piece for down right" );
		var downRight : FieldNotationCollection = getFieldsBehind( -1, +1 );

		list.addCollection( topLeft );
		list.addCollection( topRight );
		list.addCollection( downLeft );
		list.addCollection( downRight );

		log.debug( "getFieldsBehindPieces: affected diagonal fields: {0}", list.toString() );
		return list;
	}

	// get field range for line / horizontal
	private function getFieldBehindDirectLanes() {
		var list : FieldNotationCollection = new FieldNotationCollection();

		log.info( "line: get next piece for top" );
		var top : FieldNotationCollection = getFieldsBehind( +1, 0 );
		log.info( "line: get next piece for bottom" );
		var bottom : FieldNotationCollection = getFieldsBehind( -1, 0 );
		log.info( "line: get next piece for left" );
		var left : FieldNotationCollection = getFieldsBehind(  0, -1 );
		log.info( "line: get next piece for right" );
		var right : FieldNotationCollection = getFieldsBehind( 0, +1 );

		list.addCollection( top );
		list.addCollection( bottom );
		list.addCollection( left );
		list.addCollection( right );

		log.debug( "getFieldsBehindPieces: affected line fields: {0}", list.toString() );
		return list;
	}

	public function getLaneFields( rowStep : int, columnStep : int ) : FieldNotationCollection {
		var fields : FieldNotationCollection = new FieldNotationCollection();
		var walker : FieldNotation = _field.notation.clone();

		do {
			if ( ! walker.checkRowSet( rowStep ) || ! walker.checkSetColumn( columnStep ) ) {
				log.debug( "walker has reached boundaries so get off." );
				break;
			}

			walker.setColumn( columnStep );
			walker.setRow( rowStep );

			log.debug( "getLaneFields: walker at position {0}", walker.toString() );

			fields.add( walker.clone() );
		} while( true );

		return fields;
	}

	private function getNextPieceOnLane( rowStep : int, columnStep : int ) : PiecePositionVO {
		var fields : FieldNotationCollection = this.getLaneFields( rowStep, columnStep );
		var p : IPiece;
		var pp : PiecePositionVO;

		for each( var field : FieldNotation in fields.list ) {
			p = this._position.getPieceAt( field.toString() );

			log.debug( "getNextPieceOnLane: field: {0}", field.toString() );

			if ( p != null ) {
				log.debug( "getNextPieceOnLane: piece: {0}", p.getName() );

				pp = new PiecePositionVO();
				pp.notation = FieldNotation.createNotationByString( field.getNotation() );
				pp.piece = p;
				return pp;
			}
		}

		return null;
	}

	private function getFieldsBehind( rowStep : int, columnStep : int ) : FieldNotationCollection {
		var fields : FieldNotationCollection = this.getLaneFields( rowStep, columnStep );
		var fieldsBehind : FieldNotationCollection = new FieldNotationCollection();
		var p : IPiece;
		var excludeNextFields : Boolean = false;

		for each( var field : FieldNotation in fields.list ) {
			p = this._position.getPieceAt( field.toString() );

			log.debug( "getNextPieceOnLane: field: {0}", field.toString() );

			if ( p != null ) {
				if ( p.isWhite == this._piece.isWhite || !p.isWhite == !this._piece.isWhite ) {
					log.debug( "walker has detected own figure at: {0}", field.toString() );
					fieldsBehind.add( field.clone() );
					log.debug( "getFieldsBehind: next fields are unvalid." );
					excludeNextFields = true;
				} else {
					if ( excludeNextFields ) {
						log.debug( "getFieldsBehind: {0} is a field behind.", field.toString() );
						fieldsBehind.add( field.clone() );
					}
					log.debug( "getFieldsBehind: next fields are unvalid." );
					excludeNextFields = true;
				}
			} else {
				if ( excludeNextFields ) {
					log.debug( "getFieldsBehind: {0} is a field behind.", field.toString() );
					fieldsBehind.add( field.clone() );
				}
			}

		}

		return fieldsBehind;
	}

	private function getValidMovesByPieceGeometric() : ChessboardMoveCollection {
		var fromPosition : FieldNotation = FieldNotation.createNotationByString( _field.notation.toString() );
		var moves : ChessboardMoveCollection = new ChessboardMoveCollection();
		var move : ChessboardMove;
		var sequence : Array = ChessboardUtil.getNotationSequence();
		var toNotation : FieldNotation;
		var notation : String;

		for each( notation in sequence ) {
			toNotation = FieldNotation.createNotationByString( notation );

			move = new ChessboardMove();
			move.fromPosition = fromPosition;
			move.toPosition = toNotation;
			move.beatenPiece = this._position.getPieceAt( notation.toString() );
			move.piece = this._piece;

			if ( this._piece.isMoveValide( move ) ) {
				moves.add( move );
			}
		}

		return moves;
	}
}
}