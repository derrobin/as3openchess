package de.robinz.as3.pcc.chessboard.library
{
import flash.utils.Dictionary;

import mx.collections.ArrayCollection;
import mx.events.CollectionEvent;

/**
 * ChessboardGame
 *
 * @author robin heinel
 */
public class ChessboardGameCollection
{
	private var _collection : Dictionary;

	public function ChessboardGameCollection( collection : Dictionary )
	{
		this._collection = collection;
	}

	public function get collection() : Dictionary {
		return this._collection;
	}

	public function list() : ArrayCollection {
		var list : ArrayCollection = new ArrayCollection();
		var o : ChessboardGame;
		for each( o in this._collection ) {
			list.addItem( o );
		}
		return list;
	}

	public function has( gameName : String ) : Boolean {
		return this._collection[ gameName ] != null;
	}

	public function modify( game : ChessboardGame ) : Boolean {
		if ( ! this.has( game.name ) ) {
			return false;
		}

		this._collection[ game.name ] = game;
		return true;
	}

	public function add( game : ChessboardGame ) : Boolean {
		if ( this.has( game.name ) ) {
			return false;
		}

		this._collection[ game.name ] = game;
		return true;
	}

}
}