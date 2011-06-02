package de.robinz.as3.pcc.chessboard.library.pieces
{

import de.robinz.as3.pcc.chessboard.library.ChessPosition;
import de.robinz.as3.pcc.chessboard.library.ChessboardMove;
import de.robinz.as3.pcc.chessboard.library.ChessboardMoveCollection;
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

	public override function isMoveValid( m : ChessboardMove ) : Boolean {
		if( super.isMoveValid( m ) ) {
			var maxDiffRow : int = 1;
			var maxDiffCol : int = 0;
			var diffRow : int;
			var diffCol : int;

			if( this.isStartPosition( m.fromPosition ) ) {
				maxDiffRow = 2;
			}

			if( this.isWhite ) {
				diffRow = m.toPosition.row - m.fromPosition.row;
			} else {
				diffRow = m.fromPosition.row - m.toPosition.row;
			}

			if( diffRow < 0 ) {
				return false;
			}

			diffCol = Math.abs( FieldNotation.indexes.getItemIndex( m.fromPosition.column ) - FieldNotation.indexes.getItemIndex( m.toPosition.column ) );
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