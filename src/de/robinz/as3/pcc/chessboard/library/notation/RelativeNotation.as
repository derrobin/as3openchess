package de.robinz.as3.pcc.chessboard.library.notation
{
	/**
	 * this notation is used to represent the moves of the pieces in a board relative language
	 *
	 * @author robin heinel
	 */
	public class RelativeNotation implements IRelativeNotation
	{
		public static const DIRECTION_NORTH : String	= "N";
		public static const DIRECTION_SOUTH : String	= "S";
		public static const DIRECTION_WEST : String		= "W";
		public static const DIRECTION_EAST : String		= "O";

		private var _direction : String;
		private var _fields : int;

		public function get direction() : String { return this._direction; }
		public function get fields() : String { return this._direction; }

		public function RelativeNotation( direction : String, fields : int ) {
			var d : String = direction.charAt( 0 ).toUpperCase();

			// TODO: Validation auslagern
			if ( d != DIRECTION_NORTH || d != DIRECTION_SOUTH || d != DIRECTION_WEST || d!= DIRECTION_EAST ) {
				throw new TypeError( "Direction invalid!" );
			}

			if ( fields < 1 || fields > 8 ) {
				throw new TypeError( "Fields invalid!" );
			}

			this._direction = d;
			this._fields = fields;
		}

		public function toString() : String { return this._direction + this._fields.toString(); }

	}
}