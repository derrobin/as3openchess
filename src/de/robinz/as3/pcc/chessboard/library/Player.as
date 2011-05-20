package de.robinz.as3.pcc.chessboard.library {
/**
 * Player
 *
 * @author robin heinel
 */
public class Player {
	private var _name : String;
	private var _isWhite : Boolean;

	private var _castlingShortUsed : Boolean = false;
	private var _castlingLongUsed: Boolean = false;
	private var _kingHasMoved : Boolean = false;
	private var _isRookLeftMoved : Boolean = false;
	private var _isRookRightMoved : Boolean = false;

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
	public function rookLeftMoved() {
		this._isRookLeftMoved = true;
	}
	public function rookRightMoved() {
		this._isRookRightMoved = true;
	}

	public function get isWhite() : Boolean {
		return this._isWhite;
	}
	public function get isBlack() : Boolean {
		return !this._isWhite;
	}

	public function get isKingMoved() : Boolean {
		return this._kingHasMoved;
	}
	public function get isRookLeftMoved() : Boolean {
		return this._isRookLeftMoved;
	}
	public function get isRookRightMoved() : Boolean {
		return this._isRookRightMoved;
	}
	public function get name() : String {
		return this._name;
	}

}
}