package de.robinz.as3.pcc.chessboard.library
{
import de.robinz.as3.pcc.chessboard.library.ChessboardMove;
import de.robinz.as3.rzlib.collections.TypedCollection;

	/**
	 * ChessboardMoveCollection
	 *
	 * @author robin heinel
	 */
	public class ChessboardMoveCollection extends TypedCollection
	{
		public function ChessboardMoveCollection()
		{
			super( ChessboardMove, COMPARISON_ISA );
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