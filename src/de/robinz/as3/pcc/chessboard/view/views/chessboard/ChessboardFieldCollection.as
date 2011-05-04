package de.robinz.as3.pcc.chessboard.view.views.chessboard
{
import de.robinz.as3.rzlib.collections.TypedCollection;

/**
 * ChessboardFieldCollection
 *
 * @author robin heinel
 */
public class ChessboardFieldCollection extends TypedCollection
{
	public function ChessboardFieldCollection()
	{
		super( ChessboardField, COMPARISON_ISA );
	}


	/* Start TypedCollection Standard Methods */

	public function getAt( index : int ) : ChessboardField {
		return ChessboardField( this._getAt( index ) );
	}

	public function removeAt( index : int ) : ChessboardField {
		return ChessboardField( this._removeAt( index ) );
	}

	/* End TypedCollection Standard Methods */

}
}