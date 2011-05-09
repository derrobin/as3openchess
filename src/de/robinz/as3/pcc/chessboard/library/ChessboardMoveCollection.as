package de.robinz.as3.pcc.chessboard.library
{
import de.robinz.as3.pcc.chessboard.library.ChessboardMove;
import de.robinz.as3.pcc.chessboard.library.ChessboardMove;
import de.robinz.as3.pcc.chessboard.library.common.LoggerFactory;
import de.robinz.as3.pcc.chessboard.library.vo.PiecePositionVO;
import de.robinz.as3.pcc.chessboard.library.vo.PiecePositionVOCollection;
import de.robinz.as3.rzlib.collections.TypedCollection;

import mx.logging.ILogger;

/**
 * ChessboardMoveCollection
 *
 * @author robin heinel
 */
public class ChessboardMoveCollection extends TypedCollection
{
	private var log : ILogger;

	public function ChessboardMoveCollection()
	{
		super( ChessboardMove, COMPARISON_ISA );
		this.log = LoggerFactory.getLogger( this );
	}

	// TODO: check usage
	public function getToPosition() : PiecePositionVOCollection {
		var move : ChessboardMove;
		var list : PiecePositionVOCollection = new PiecePositionVOCollection();
		var p : PiecePositionVO;

		for each( move in this._list ) {
			p = new PiecePositionVO();
			p.notation = move.toPosition;
			p.piece = move.piece;

			list.add( p );
		}

		return list;
	}

	public function excludeToPositions( notations : FieldNotationCollection ) : void {
		var move : ChessboardMove;
		var notation : FieldNotation;
		var excludeMoves : Array = [];
		var itemIndex : int;

		for each( move in this._list ) {
			log.debug( "excludeToPositions: move to position: {0}", move.toPosition.toString() );
			for each( notation in notations.list ) {
				if ( notation.equals( move.toPosition ) ) {
					log.debug( "excludeToPositions: mark to field to exclude {0}", notation.toString() );
					excludeMoves.push( move );
				}
			}
		}

		for each( var excludeMove : ChessboardMove in excludeMoves ) {
			itemIndex = this._list.getItemIndex( excludeMove );
			if ( itemIndex > -1 ) {
				log.debug( "excludeToPositions: remove item at index: {0}", itemIndex )
				this._list.removeItemAt( itemIndex );
			}
		}
	}

	/* Start TypedCollection Standard Methods */

	public function getAt( index : int ) : ChessboardMove {
		return ChessboardMove( this._getAt( index ) );
	}

	public function removeAt( index : int ) : ChessboardMove {
		return ChessboardMove( this._removeAt( index ) );
	}

	/* End TypedCollection Standard Methods */

}
}