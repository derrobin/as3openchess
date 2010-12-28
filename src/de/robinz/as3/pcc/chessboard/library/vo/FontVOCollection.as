package de.robinz.as3.pcc.chessboard.library.vo
{
	import de.robinz.as3.rzlib.collections.TypedCollection;

	/**
	 * FontVOCollection
	 *
	 * @author robin heinel
	 */
	public class FontVOCollection extends TypedCollection
	{
		public function FontVOCollection()
		{
			super( FontVO, COMPARISON_ISA );
		}

		public function getById( id : String ) : FontVO {
			var o : FontVO;
			for each( o in this.list ) {
				if ( o.id == id ) {
					return o;
				}
			}

			return null;
		}

		/* Start TypedCollection Standard Methods */

		public function getAt( index : int ) : FontVOCollection {
			return FontVOCollection( this._getAt( index ) );
		}

		public function removeAt( index : int ) : FontVOCollection {
			return FontVOCollection( this._removeAt( index ) );
		}

		/* End TypedCollection Standard Methods */

	}
}