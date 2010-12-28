package de.robinz.as3.pcc.chessboard.library.vo
{
	/**
	 * FontVO
	 *
	 * @author robin heinel
	 */
	public class FontVO
	{
		public var id : String;
		public var name : String;
		public var instance : Class;
		/**
		 * [ 00 ] Pawn white
		 * [ 01 ] Pawn black
		 * [ 02 ] Rook w
		 * [ 03 ] Rook b
		 * [ 04 ] Bishop w
		 * [ 05 ] Bishop b
		 * [ 06 ] King w
		 * [ 07 ] King b
		 * [ 08 ] Queen w
		 * [ 09 ] Queen b
		 * [ 10 ] Knight w
		 * [ 11 ] Knight b
		 */
		public var keyMap : Array;

		public function FontVO()
		{
		}

		public static function create( id : String, name : String, instance : Class, keyMap : Array ) : FontVO {
			var o : FontVO = new FontVO();
			o.id = id;
			o.name = name;
			o.instance = instance;
			o.keyMap = keyMap;
			return o;
		}

	}
}