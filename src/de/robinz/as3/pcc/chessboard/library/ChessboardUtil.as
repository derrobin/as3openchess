package de.robinz.as3.pcc.chessboard.library {
import de.robinz.as3.pcc.chessboard.library.pieces.IPiece;
import de.robinz.as3.pcc.chessboard.library.pieces.IPiece;
import de.robinz.as3.pcc.chessboard.library.vo.ChessboardFieldVO;

import de.robinz.as3.pcc.chessboard.view.views.chessboard.ChessboardFieldCollection;

import mx.logging.ILogger;
import mx.logging.Log;
import mx.utils.ArrayUtil;

/**
 * ChessboardUtil
 *
 * @author robin heinel
 */
public class ChessboardUtil {

	private static const LOGGER : String = "ChessboardUtil";
	private static var log : ILogger = Log.getLogger( LOGGER );


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
		var piece : IPiece = position.getPieceAt( field.notation.toString() );
		var validator : MoveValidator = new MoveValidator( field, position, piece );
		return validator.getValidMoves();
	}
}
}