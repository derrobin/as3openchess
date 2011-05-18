package de.robinz.as3.pcc.chessboard.library {
import de.robinz.as3.pcc.chessboard.library.FieldNotation;
import de.robinz.as3.pcc.chessboard.library.pieces.IPiece;

import de.robinz.as3.pcc.chessboard.library.pieces.King;

import de.robinz.as3.pcc.chessboard.library.pieces.PieceCollection;

import de.robinz.as3.pcc.chessboard.library.vo.PiecePositionVO;
import de.robinz.as3.pcc.chessboard.library.vo.PiecePositionVOCollection;

import flash.utils.Dictionary;

import mx.logging.ILogger;
import mx.logging.Log;

/**
 * ChessPosition
 *
 * @author robin heinel
 */
public class ChessPosition {
	private var log : ILogger = Log.getLogger( "ChessPosition" );

	protected var _position : Dictionary;

	public function ChessPosition() {
		this._position = new Dictionary();
		this.initPosition();
	}

	private function initPosition() : void {
		var sequence = ChessboardUtil.getNotationSequence();
		var notation : String;
		var i : int = 0;

		for each ( notation in sequence ) {
			this._position[ notation ] = null;
			i++;
		}

		log.debug( "initPosition: {0} notations created.", i.toString() );
	}

	public function setPiece( piece : IPiece, notation : String, overWrite : Boolean = false ) : void {
		if ( ! this._position.hasOwnProperty( notation ) ) {
			log.warn( "unvalid position!" );
			return;
		}
		if ( !overWrite && this._position[ notation ] != null ) {
			log.warn( "position already set!" );
			return;
		}

		this._position[ notation ] = piece;
	}

	public function removePiece( notation : String ) : void {
		if ( ! this._position.hasOwnProperty( notation ) ) {
			log.warn( "unvalid position!" );
			return;
		}

		this._position[ notation ] = null;
	}

	public function getPieces( white : Boolean ) : PiecePositionVOCollection {
		var list : PiecePositionVOCollection = new PiecePositionVOCollection();
		var piece : IPiece;

		for ( var notation : String in this._position ) {
			piece = this._position[ notation ];

			if ( piece == null ) {
				continue;
			}

			if ( piece.isWhite == white ) {
				list.add( PiecePositionVO.create( piece, FieldNotation.createNotationByString( notation ) ) );
			}
		}

		return list;
	}

	public function getKing( white : Boolean ) : PiecePositionVO {
		var king : IPiece;
		var piece : IPiece;

		for ( var notation : String in this._position ) {
			piece = this._position[ notation ];

			if ( piece == null ) {
				continue;
			}

			if ( piece.isWhite == white && piece is King ) {
				return PiecePositionVO.create( piece, FieldNotation.createNotationByString( notation ) );
			}
		}

		return null;
	}

	public function setPosition( position : ChessPosition ) : void {
		this._position = position.getPosition();
	}

	public function getPosition() : Dictionary {
		return this._position;
	}

	public function getPieceAt( notation : String ) : IPiece {
		return this._position[ notation ];
	}

}
}