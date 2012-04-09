package de.robinz.as3.pcc.chessboard.library.pieces
{

import de.robinz.as3.pcc.chessboard.library.ChessPosition;
import de.robinz.as3.pcc.chessboard.library.ChessboardMove;
import de.robinz.as3.pcc.chessboard.library.ChessboardMoveCollection;
import de.robinz.as3.pcc.chessboard.library.ChessboardUtil;
import de.robinz.as3.pcc.chessboard.library.FieldNotation;
import de.robinz.as3.pcc.chessboard.library.FieldNotationCollection;
import de.robinz.as3.pcc.chessboard.library.FontManager;
import de.robinz.as3.pcc.chessboard.library.pieces.moverange.IMoveRange;

/**
 * Piece
 *
 * @author robin heinel
 */
public class Piece implements IPiece
{
	private 	var _isWhite 	: Boolean = true;
	protected 	var _useFontKey : Boolean = false;
	private 	var _isMoved 	: Boolean = false;

	protected 	var _fontKey 	: String;

	protected var _range : IMoveRange;

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
		}

		throw new Error( "No Piece not Found!" );
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

	public function isMoveValid( m : ChessboardMove ) : Boolean {
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

	public function get isMoved() : Boolean {
		return this._isMoved;
	}

	public function move() : void {
		this._isMoved = true;
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

	public function getGeometricValidMoviesToField( field:FieldNotation, position:ChessPosition ):ChessboardMoveCollection {
		var fields : FieldNotationCollection = this._range.getRange( field, position );
		return ChessboardUtil.convertNotationCollection2ChessboardMoveCollection( field,  fields, position, this );
	}

	protected function getValidRange( from : FieldNotation, fields:FieldNotationCollection, position:ChessPosition ):ChessboardMoveCollection {
		var moves:ChessboardMoveCollection = ChessboardUtil.convertNotationCollection2ChessboardMoveCollection( from,  fields, position, this );
		var res : ChessboardMoveCollection = new ChessboardMoveCollection();

		for ( var i:int = 0; i < moves.length; i++ ) {

			if ( isMoveValid( moves.getAt( i ) ) ) {
				res.add( moves.getAt( i ) );
			}

		}

		return res;
	}

}
}