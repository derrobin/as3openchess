package de.robinz.as3.pcc.chessboard.library.pieces.rules.result
{
	import de.robinz.as3.pcc.chessboard.library.notation.IRelativeNotation;
	import de.robinz.as3.rzlib.collections.TypedCollection;

	public class RelativeNotationList extends TypedCollection
	{
		public static const NOTATION_AND : String  = "&";

		private var _isLoop : Boolean = false;

		public function get isLoop() : Boolean { return this._isLoop; }

		public function RelativeNotationList() {
			super( IRelativeNotation, TypedCollection.COMPARISON_ISA );
		}

		public function setLoop( value : Boolean = true ) : void {
			this._isLoop = value;
		}

		public function toString() : String {
			var n : IRelativeNotation;
			var out : String;

			for each( this._list as n ) {
				out += n.toString() + NOTATION_AND;
			}

			out = out.substr( 0, out.length - NOTATION_AND.length );

			if ( this.isLoop ) {
				out =+ "LOOP(" + out + ")";
			}

			return out;
		}


		public function getAt( index : int ) : IRelativeNotation {
			return IRelativeNotation( this._getAt( index ) );
		}

		public function removeAt( index : int ) : IRelativeNotation {
			return IRelativeNotation( this._removeAt( index ) );
		}

	}
}