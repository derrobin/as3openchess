package de.robinz.as3.pcc.chessboard.library.pieces
{
import de.robinz.as3.rzlib.collections.TypedCollection;

/**
 * PieceCollection
 *
 * @author robin heinel
 */
public class PieceCollection extends TypedCollection
{
	public function PieceCollection()
	{
		super( IPiece, COMPARISON_ISA );
	}

	/* Start TypedCollection Standard Methods */

	public function getAt( index : int ) : IPiece {
		return IPiece( this._getAt( index ) );
	}

	public function removeAt( index : int ) : IPiece {
		return IPiece( this._removeAt( index ) );
	}

	/* End TypedCollection Standard Methods */

}
}