package de.robinz.as3.pcc.chessboard.library.pieces
{

import de.robinz.as3.pcc.chessboard.library.ChessPosition;
import de.robinz.as3.pcc.chessboard.library.ChessboardMove;
import de.robinz.as3.pcc.chessboard.library.ChessboardMoveCollection;
import de.robinz.as3.pcc.chessboard.library.ChessboardUtil;
import de.robinz.as3.pcc.chessboard.library.FieldNotation;
import de.robinz.as3.pcc.chessboard.library.FieldNotationCollection;
import de.robinz.as3.pcc.chessboard.library.pieces.moverange.PawnRange;

/**
 * Pawn
 *
 * @author robin heinel
 */
public class Pawn extends Piece implements IPiece
{
	public static var NAME : String = "pawn";

	public function Pawn() {
		this._range = new PawnRange();
	}

	public override function getName() : String {
		return NAME;
	}

	public override function getSortIndex() : int {
		return 16;
	}
	public override function get notationChar() : String {
		return "B";
	}

	public function isStartPosition( notation : FieldNotation ) : Boolean {
		return this.isWhite && notation.row == 2 || ( ! this.isWhite && notation.row == 7 );
	}

	public override function getGeometricValidMoviesToField(
		field : FieldNotation,
		position : ChessPosition ) : ChessboardMoveCollection {

		var totalRange : FieldNotationCollection = this._range.getRange( field, position );
		var index : int = 1;

		if( !this.isWhite) {
			index = -1;
		}

		if( !this.isMoved  ) {
			var doubleField : FieldNotation = FieldNotation.createNotationByString( field.column + ( field.row + 2 * index ) );
			var oneField : FieldNotation = FieldNotation.createNotationByString( field.column + ( field.row + 1 * index ) );
			if( !position.getPieceAt( doubleField.getNotation() ) &&
				!position.getPieceAt( oneField.getNotation() )
			) {
				totalRange.add( doubleField );
			}
		}

		var fields : FieldNotationCollection = new FieldNotationCollection();
		for( var i : int = 0; i < totalRange.length; i++ ) {
			if( field.column == totalRange.getAt( i ).column ) {
				if( !position.getPieceAt( totalRange.getAt( i ).getNotation() ) ) {
					fields.add( totalRange.getAt(i) );
				}
			} else {
				if( position.getPieceAt( totalRange.getAt( i ).getNotation() ) &&
					position.getPieceAt( totalRange.getAt( i ).getNotation() ).isWhite != this.isWhite
				) {
					fields.add( totalRange.getAt(i) );
				}

			}
		}

		var moves : ChessboardMoveCollection = ChessboardUtil.convertNotationCollection2ChessboardMoveCollection( field,  fields, position, this );

		var enPassant : FieldNotation = getEnPassant( field, position  );
		if( enPassant ) {
			var move:ChessboardMove;

			move = new ChessboardMove();
			move.fromField = field;
			move.toField   = enPassant;
			move.piece = this;
			move.isEnPassant = true;
			moves.add( move );

		}

		return moves
	}

	private function getEnPassant( field : FieldNotation, position : ChessPosition ) : FieldNotation {
		var leftPiece : IPiece  = null;
		var rightPiece : IPiece = null;
		var leftField : FieldNotation  = null;
		var rightField : FieldNotation = null;
		var index : int = isWhite ? 1 : -1;

		if( !position.lastMove ) {
			return null;
		}

		if( FieldNotation.getColumn( field.column, -1 ) ) {
			leftField = FieldNotation.createNotationByString( FieldNotation.getColumn( field.column, -1 ) + field.row );
			leftPiece = position.getPieceAt( leftField.getNotation() );
		}

		if( FieldNotation.getColumn( field.column, 1 ) ) {
			rightField = FieldNotation.createNotationByString( FieldNotation.getColumn( field.column, 1 ) + field.row );
			rightPiece = position.getPieceAt( rightField.getNotation() );
		}

		if( leftPiece && leftPiece.getName() == NAME ) {
			if( position.lastMove.toField.equals( leftField ) && position.lastMove.isPawnDoubleJump  ) {
				return FieldNotation.createNotationByString( leftField.column + (leftField.row + index) );
			}
		}

		if( rightPiece && rightPiece.getName() == NAME ) {
			if( position.lastMove.toField.equals( rightField ) && position.lastMove.isPawnDoubleJump  ) {
				return FieldNotation.createNotationByString( rightField.column + (rightField.row + index) );
			}

		}

		return null;
	}

	public override function isMoveValid( m : ChessboardMove ) : Boolean {
		if( super.isMoveValid( m ) ) {
			var maxDiffRow : int = 1;
			var maxDiffCol : int = 0;
			var diffRow : int;
			var diffCol : int;

			if( this.isStartPosition( m.fromField ) ) {
				maxDiffRow = 2;
			}

			if( this.isWhite ) {
				diffRow = m.toField.row - m.fromField.row;
			} else {
				diffRow = m.fromField.row - m.toField.row;
			}

			if( diffRow < 0 ) {
				return false;
			}

			diffCol = Math.abs( FieldNotation.indexes.getItemIndex( m.fromField.column ) - FieldNotation.indexes.getItemIndex( m.toField.column ) );
			if( ( maxDiffRow >= diffRow ) && ( maxDiffCol >= diffCol ) && ( m.beatenPiece == null ) ) {
				return true;
			}

			if( m.beatenPiece && diffRow == 1 && diffCol == 1 ) {
				return true;
			}

		}

		return false;
	}
}
}