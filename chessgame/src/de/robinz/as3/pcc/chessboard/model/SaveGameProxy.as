package de.robinz.as3.pcc.chessboard.model
{
import de.robinz.as3.pcc.chessboard.library.ChessboardGameCollection;
import de.robinz.as3.pcc.chessboard.library.vo.ChessboardGameVO;

import flash.utils.Dictionary;

/**
 * SaveGameProxy
 *
 * @author robin heinel
 */
public class SaveGameProxy extends BaseProxy
{
	public static const NAME : String = "SaveGameProxy";

	public static const DEFAULT_NAME_MAX : int = 100;
	public static const DEFAULT_NAME_PREFFIX : String = "unnamed";
	public static const DEFAULT_NAME_PREFFIX_SEPERATOR : String = "-";

	private var _games : ChessboardGameCollection;

	public function SaveGameProxy( data : Object = null ) {
		super( NAME, data );

		this._games = new ChessboardGameCollection( new Dictionary( true ) );
	}


	// Start proxy overrides

	public override function getProxyName() : String {
		return NAME;
	}

	// End proxy overrides


	// Start Proxy Interface

	public function getDefaultName() : String {
		var defaultName : String;
		for( var i : int = 0; i <= DEFAULT_NAME_MAX; i++ ) {
			defaultName = this.defaultName( i );
			if ( this._games.has( defaultName ) ) {
				continue;
			}
			return defaultName;
		}
		return "";
	}

	public function getGames() : ChessboardGameCollection {
		return this._games;
	}

	public function save( game : ChessboardGameVO ) : void {
		if ( this._games.modify( game ) ) {
			return;
		}

		this._games.add( game );
	}

	// End Proxy Interface


	// Start Innerclass Methods

	private function defaultName( counter : int ) : String {
		return DEFAULT_NAME_PREFFIX + DEFAULT_NAME_PREFFIX_SEPERATOR + String( counter );
	}

	// End Innerclass Methods


	// Start Getter / Setters

	// End Getter / Setters
}
}