package de.robinz.as3.pcc.chessboard.library {
import de.robinz.as3.pcc.chessboard.library.FieldNotation;
import de.robinz.as3.pcc.chessboard.library.pieces.IPiece;
import de.robinz.as3.pcc.chessboard.library.vo.ChessboardFieldVO;
import de.robinz.as3.pcc.chessboard.view.views.chessboard.ChessboardField;

/**
 * ChessboardUtil
 *
 * @author robin heinel
 */
public class ChessboardUtil {

	public static function getNotationSequence() : Array {
		var sequence : Array = new Array();
		var rows : String = "abcdefgh";
		var notation : String;
		var i : int = 1;
		var j : int = 1;

		for( j = 8; j > 0; j-- ) {
			for( i; i <= rows.length; i++ ) {
				notation = rows.charAt( i - 1 ) + j.toString();
				sequence.push( notation );
			}
			i = 1;
		}

		return sequence;
	}

	public static function getValidMoves( field : ChessboardFieldVO, position : ChessPosition ) : ChessboardMoveCollection {
		var moves : ChessboardMoveCollection = new ChessboardMoveCollection();
		var move : ChessboardMove;
		var piece : IPiece = position.getPieceAt( field.notation );
		var sequence : Array = getNotationSequence();
		var toNotation : FieldNotation;
		var notation : String;
		var fromPosition : FieldNotation = FieldNotation.createNotationByString( field.notation );

		for each( notation in sequence ) {
			toNotation = FieldNotation.createNotationByString( notation );
			move = new ChessboardMove();
			move.fromPosition = fromPosition;
			move.toPosition = toNotation;
			move.beatenPiece = position.getPieceAt( notation.toString() );
			move.piece = piece;

			if ( piece.isMoveValide( move ) ) {
				moves.add( move );
			}
		}

		return moves;
	}
}
}