package de.robinz.as3.pcc.chessboard.library.managers
{
	public class PositionManager
	{
		private static var _instance : PositionManager;
		private static var _allowInstantiation : Boolean;

		public function PositionManager() {
			if ( !_allowInstantiation ) {
				throw new Error( "Error: Instantiation failed: Use static::getInstance() instead of new." );
			}
		}

		public static function getInstance() : PositionManager {
			if ( _instance == null ) {
				_allowInstantiation = true;
				_instance = new PositionManager();
				_allowInstantiation = false;
			}

			return _instance;
		}
	}
}