package de.robinz.as3.pcc.chessboard.library
{
import de.robinz.as3.rzlib.collections.TypedCollection;

/**
 * FieldNotationCollection
 *
 * @author robin heinel
 */
public class FieldNotationCollection extends TypedCollection
{
	public function FieldNotationCollection()
	{
		super( FieldNotation, COMPARISON_ISA );
	}

	public function addCollection( notations : FieldNotationCollection ) : void {
		if ( notations == null ) {
			return;
		}
		var notation : FieldNotation;
		for each( notation in notations.list ) {
			this.add( notation );
		}
	}

	/* Start TypedCollection Standard Methods */

	public override function add( o : Object ) : void {
		if ( o == null ) {
			return;
		}
		super.add( o );
	}


	public function getAt( index : int ) : FieldNotation {
		return FieldNotation( this._getAt( index ) );
	}

	public function removeAt( index : int ) : FieldNotationCollection {
		return FieldNotationCollection( this._removeAt( index ) );
	}

	/* End TypedCollection Standard Methods */

	public function toString() : String {
		var out : String = "";
		var notation : FieldNotation;
		for each( notation in this._list ) {
			out += notation.toString() + ",";
		}
		return out.substr( 0, out.length - 1 );
	}

}
}