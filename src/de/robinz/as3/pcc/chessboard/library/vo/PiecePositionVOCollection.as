package de.robinz.as3.pcc.chessboard.library.vo
{
import de.robinz.as3.rzlib.collections.TypedCollection;

import mx.containers.Panel;

/**
 * FontVOCollection
 *
 * @author robin heinel
 */
public class PiecePositionVOCollection extends TypedCollection
{
	public function PiecePositionVOCollection()
	{
		super( PiecePositionVO, COMPARISON_ISA );
	}

	/* Start TypedCollection Standard Methods */

	public function getAt( index : int ) : PiecePositionVO {
		return PiecePositionVO( this._getAt( index ) );
	}

	public function removeAt( index : int ) : PiecePositionVO {
		return PiecePositionVO( this._removeAt( index ) );
	}

	/* End TypedCollection Standard Methods */

}
}