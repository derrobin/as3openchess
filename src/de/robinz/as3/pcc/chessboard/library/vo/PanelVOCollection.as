package de.robinz.as3.pcc.chessboard.library.vo
{
	import de.robinz.as3.rzlib.collections.TypedCollection;

	import mx.containers.Panel;

	/**
	 * FontVOCollection
	 *
	 * @author robin heinel
	 */
	public class PanelVOCollection extends TypedCollection
	{
		public function PanelVOCollection()
		{
			super( PanelVO, COMPARISON_ISA );
		}


		public function getByPanel( panel : Panel ) : PanelVO {
			var p : Panel;
			var vo : PanelVO;
			for each( vo in this._list ) {
				if ( vo.panel == panel ) {
					return vo;
				}
			}

			return null;
		}

		/* Start TypedCollection Standard Methods */

		public function getAt( index : int ) : PanelVO {
			return PanelVO( this._getAt( index ) );
		}

		public function removeAt( index : int ) : PanelVO {
			return PanelVO( this._removeAt( index ) );
		}

		/* End TypedCollection Standard Methods */

	}
}