package de.robinz.as3.pcc.chessboard.library {
import de.robinz.as3.pcc.chessboard.library.pieces.IPiece;
import de.robinz.as3.pcc.chessboard.library.vo.ChessboardFieldVO;

import mx.logging.ILogger;
import mx.logging.Log;

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
		var fromPosition : FieldNotation = FieldNotation.createNotationByString( field.notation );
		var moves : ChessboardMoveCollection = new ChessboardMoveCollection();
		var move : ChessboardMove;
		var piece : IPiece = position.getPieceAt( field.notation );
		var sequence : Array = getNotationSequence();
		var toNotation : FieldNotation;
		var notation : String;

//		var topPiece : PiecePositionVO = getNextPieceOnTop( fromPosition, position );
//		if ( topPiece != null ) {
//			log.debug( "next piece on top is: {0} ( {1} ) at field { {2} }", topPiece.piece.getName(), topPiece.piece.isWhite ? "white" : "black", topPiece.notation.toString() );
//		}

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

		// exclude fields behind pieces ( just for lanes/lines - rook, bishop, queen )
		if ( piece.hasAbilityToBeatDiagonal ) {
			// get field range for line - top/down
			// exclude by diff

			// get field range for line - down/top
			// exclude by diff
		}

		if ( piece.hasAbilityToBeatLine ) {
			// get field range for line / horizontal
			// exclude by diff

			// get field range for line / down
			// exclude by diff
		}

		return moves;
	}

//	private static function getNextPieceOnTop( notation : FieldNotation, position : ChessPosition ) : PiecePositionVO {
//		var currentField : FieldNotation = notation.getNextTop();
//
//		while ( currentField != null )  {
//			var piece : IPiece = position.getPieceAt( currentField.getNotation() );
//			if ( piece != null ) {
//				var pp : PiecePositionVO = new PiecePositionVO();
//				pp.notation = currentField;
//				pp.piece = piece;
//				return pp;
//			}
//
//			currentField = currentField.getNextTop();
//		}
//
//		return null;
//	}

//	private static function getNextPieceOnDown( notation : FieldNotation, position : ChessPosition ) : PiecePositionVO {
//		var currentField : FieldNotation = notation.getNextTop();
//
//		while ( currentField != null )  {
//			var piece : IPiece = position.getPieceAt( currentField.getNotation() );
//			if ( piece != null ) {
//				var pp : PiecePositionVO = new PiecePositionVO();
//				pp.notation = currentField;
//				pp.piece = piece;
//				return pp;
// 		var fields : ChessboardFieldCollection = new ChessboardFieldCollection();

//			}
//
//			currentField = currentField.getNextDown();
//		}
//
//		return null;
//	}

//	public static function getValidMovesByGeometric() : void {
//
//	}
}
}