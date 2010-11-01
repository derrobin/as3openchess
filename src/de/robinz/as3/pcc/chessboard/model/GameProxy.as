package de.robinz.as3.pcc.chessboard.model
{
	import de.robinz.as3.pcc.chessboard.view.ChessboardMediator;

	import flash.utils.Dictionary;

	import org.puremvc.as3.patterns.proxy.Proxy;

	/**
	 * GameProxy
	 *
	 * @author Robin Heinel

	 */
	public class GameProxy extends Proxy
	{
		public static const NAME : String = "GameProxy";
		private var _gm : Dictionary; // Game Mediators
		private var _gameCount : int = 0;

		public function GameProxy( data : Object = null ) {
			super( NAME, data );
			this._gm = new Dictionary( true );
		}

		/**
		 *
		 * @param mediator
		 * @return gameId
		 *
		 */
		public function beginGame( mediator : ChessboardMediator ) : int {
			_gm[ _gm.length ] = mediator;
			return _gm.length;
		}

		public function endGame( gameId : int ) : Boolean {
			if ( gm[ gameId ] != null ) {
				gm[ gameId ] = null;
				return true;
			}

			return false;
		}

		public override function getProxyName() : String {
			return NAME;
		}
	}
}