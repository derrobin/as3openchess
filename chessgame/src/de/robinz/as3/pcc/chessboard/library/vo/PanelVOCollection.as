package de.robinz.as3.pcc.chessboard.library.vo
{
import de.robinz.as3.rzlib.collections.TypedCollection;

import mx.containers.Panel;
import mx.core.Container;

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

	public function getVisiblePanels() : PanelVOCollection {
		var list : PanelVOCollection = new PanelVOCollection();
		var p : PanelVO;
		for each( p in this.list ) {
			if ( p.visible == true ) {
				list.add( p );
			}
		}
		return list;
	}

	public function isVisiblePanels() : Boolean {
		return this.getVisiblePanels().length > 0;
	}

	public function getByPanel( panel : Container ) : PanelVO {
		var vo : PanelVO;
		for each( vo in this._list ) {
			if ( vo.container == panel ) {
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