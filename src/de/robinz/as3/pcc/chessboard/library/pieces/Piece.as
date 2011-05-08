package de.robinz.as3.pcc.chessboard.library.pieces
{
import de.robinz.as3.pcc.chessboard.library.FontManager;
import de.robinz.as3.pcc.chessboard.library.ChessboardMove;

/**
 * Piece
 *
 * @author robin heinel
 */
public class Piece implements IPiece
{
	private var _isWhite : Boolean = true;
	private var _useFontKey : Boolean = false;
	private var _fontKey : String;

	public static function createByParams( name : String, white : Boolean = true ) : IPiece {
		var p : IPiece = factoryByName( name );

		if ( ! white ) {
			p.setBlack();
		}

		return p as IPiece;
	}

	private static function factoryByName( name : String ) : IPiece {
		switch( name ) {
			case Pawn.NAME:		return new Pawn();
			case Rook.NAME:		return new Rook();
			case Bishop.NAME:	return new Bishop();
			case Knight.NAME:	return new Knight();
			case Queen.NAME:	return new Queen();
			case King.NAME:		return new King();
		};

		throw new Error( "No Piece not Found!" );
	}

	public function setWhite() : void {
		this._isWhite = true;
	}

	public function setBlack() : void {
		this._isWhite  = false;
	}

	public function equals( piece : IPiece ) : Boolean {
		var name1 : String = this.getName();
		var name2 : String = piece.getName();
		if ( name1 == name2 ) {
			if ( this._isWhite == piece.isWhite ) {
				return true;
			}
		}
		return false;
	}

	public function isMoveValide( m : ChessboardMove ) : Boolean {
		if( m.beatenPiece ) {
			if( m.beatenPiece.isWhite == this.isWhite ) {
				return false;
			}
		}
		return true;
	}

	public function get fontKey() : String {
		if ( this._useFontKey ) {
			return this._fontKey;
		}
		return FontManager.getInstance().getFontKeyByPiece( this );
	}

	public function set fontKey( value : String ) : void {
		if ( !( this is FakedPiece ) ) {
			throw new Error("Only Fake's should use setFontKey()!");
		}

		this._useFontKey = true;
		this._fontKey = value;
	}

	public function getName() : String {
		throw new Error( "Not Implemented!" );
	}

	public function getSortIndex() : int {
		throw new Error( "Not Implemented!" );
	}

	public function get notationChar() : String {
		throw new Error( "Not Implemented!" );
	}

	public function get isWhite() : Boolean {
		return this._isWhite;
	}

	public function get hasAbilityToBeatDiagonal() : Boolean {
		return false;
	}
	public function get hasAbilityToBeatLine() : Boolean {
		return false;
	}
}
}