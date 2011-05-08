package de.robinz.as3.pcc.chessboard.library {
import flash.utils.Dictionary;

/**
 * de.robinz.as3.pcc.chessboard.library
 *
 * @author robin heinel
 */
public class Player {
	private var _name : String;
	private var _isWhite : Boolean;

	private var _castlingShortUsed : Boolean = false;
	private var _castlingLongUsed: Boolean = false;
	private var _kingHasMoved : Boolean = false;

	public function Player( name : String, isWhite : Boolean = false ) {
		this._isWhite = isWhite;
		this._name = name;
	}

	public function castlingShort() {
		this._castlingShortUsed = true;
	}
	public function castlingLong() {
		this._castlingLongUsed = true;
	}
	public function moveKing() {
		this._kingHasMoved = true;
	}

	public function get isWhite() : Boolean {
		return this._isWhite;
	}
	public function get name() : String {
		return this._name;
	}

}
}