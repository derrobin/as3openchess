package de.robinz.as3.pcc.chessboard.library
{
import de.robinz.as3.pcc.chessboard.library.common.LoggerFactory;
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

	public function getLastMove() : ChessboardMove {
		if ( this._list.length == 0 ) {
			return null;
		}
		return this.getAt( this._list.length - 1 );
	}

	public function hasNotationToPosition( notation : String ) : Boolean {
		var move : ChessboardMove;

		for each( move in this._list ) {
			if ( move.toPosition.toString() == notation ) {
				return true;
			}
		}

		return false;
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