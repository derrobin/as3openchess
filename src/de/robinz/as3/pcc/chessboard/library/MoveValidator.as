package de.robinz.as3.pcc.chessboard.library {
import de.robinz.as3.pcc.chessboard.library.ChessboardMoveCollection;
import de.robinz.as3.pcc.chessboard.library.FieldNotation;
import de.robinz.as3.pcc.chessboard.library.common.LoggerFactory;
import de.robinz.as3.pcc.chessboard.library.pieces.IPiece;
import de.robinz.as3.pcc.chessboard.library.pieces.King;
import de.robinz.as3.pcc.chessboard.library.pieces.Pawn;
import de.robinz.as3.pcc.chessboard.library.pieces.Rook;
import de.robinz.as3.pcc.chessboard.library.vo.ChessboardFieldVO;

import de.robinz.as3.pcc.chessboard.library.vo.ChessboardGameVO;

import de.robinz.as3.pcc.chessboard.library.vo.PiecePositionVO;
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
		var moves : ChessboardMoveCollection = this.getValidMovesByPieceGeometric();

		var fieldsBehind : FieldNotationCollection = this.getFieldsBehindPieces();
		moves.excludeToPositions( fieldsBehind );

		// special moves
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

//		if ( ! ( this._piece is Pawn ) ) {
//			field = this.getEnPassion();
//			moves.add( this.getEnPassion() );
//		}


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

//	private function getEnPassion() : FieldNotation {
//		return null;
//	}



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

	private function getNextPieceOnLane( rowStep : int, columnStep : int ) : PiecePositionVO {
		var walker : FieldNotation = _field.notation.clone();
		var maxSteps : int = 8;
		var i : int = 0;
		var p : IPiece;
		var pp : PiecePositionVO;

		do {
			if ( ! walker.checkRowSet( rowStep ) || ! walker.checkSetColumn( columnStep ) ) {
				log.debug( "walker has reached boundaries so get off." );
				break;
			}

			walker.setColumn( columnStep );
			walker.setRow( rowStep );

			log.debug( "walker is at field {0}.", walker.toString() );
			p = this._position.getPieceAt( walker.toString() );

			if ( p != null ) {
				pp = new PiecePositionVO();
				pp.notation = FieldNotation.createNotationByString( walker.getNotation() );
				pp.piece = p;
				return pp;
			}

			if ( i >= maxSteps ) {
				log.warn( "loop exit condition failed, check your code!" );
				break;
			}

			i++;
		} while( true );

		return null;
	}

	private function getFieldsBehind( rowStep : int, columnStep : int ) : FieldNotationCollection {
		var walker : FieldNotation = _field.notation.clone();
		var maxSteps : int = 8;
		var i : int = 0;
		var p : IPiece;
		var excludeNextFields : Boolean = false;
		var fieldsBehind : FieldNotationCollection = new FieldNotationCollection();

		do {
			if ( ! walker.checkRowSet( rowStep ) || ! walker.checkSetColumn( columnStep ) ) {
				log.debug( "walker has reached boundaries so get off." );
				walker.checkRowSet( rowStep );
				walker.checkSetColumn( columnStep );
				break;
			}

			walker.setColumn( columnStep );
			walker.setRow( rowStep );

			log.debug( "walker is at field {0}.", walker.toString() );
			p = this._position.getPieceAt( walker.toString() );

			if ( p != null ) {
				if ( p.isWhite == this._piece.isWhite || !p.isWhite == !this._piece.isWhite ) {
					log.debug( "walker has detected own figure at: {0}", walker.toString() );
					fieldsBehind.add( walker.clone() );
					log.debug( "getFieldsBehind: next fields are unvalid." );
					excludeNextFields = true;
				} else {
					if ( excludeNextFields ) {
						log.debug( "getFieldsBehind: {0} is a field behind.", walker.toString() );
						fieldsBehind.add( walker.clone() );
					}
					log.debug( "getFieldsBehind: next fields are unvalid." );
					excludeNextFields = true;
				}
			} else {
				if ( excludeNextFields ) {
					log.debug( "getFieldsBehind: {0} is a field behind.", walker.toString() );
					fieldsBehind.add( walker.clone() );
				}
			}

			if ( i >= maxSteps ) {
				log.warn( "loop exit condition failed, check your code!" );
				break;
			}

			i++;
		} while( true );

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