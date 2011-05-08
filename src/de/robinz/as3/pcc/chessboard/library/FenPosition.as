package de.robinz.as3.pcc.chessboard.library {
import de.robinz.as3.pcc.chessboard.library.FieldNotation;
import de.robinz.as3.pcc.chessboard.library.common.LoggerFactory;
import de.robinz.as3.pcc.chessboard.library.pieces.Bishop;
import de.robinz.as3.pcc.chessboard.library.pieces.IPiece;

import de.robinz.as3.pcc.chessboard.library.pieces.King;

import de.robinz.as3.pcc.chessboard.library.pieces.Knight;
import de.robinz.as3.pcc.chessboard.library.pieces.Pawn;

import de.robinz.as3.pcc.chessboard.library.pieces.Queen;

import de.robinz.as3.pcc.chessboard.library.pieces.Rook;

import flash.utils.Dictionary;

import mx.logging.ILogger;
import mx.logging.Log;

/**
 * FENPosition
 *
 * @author robin heinel
 */
public class FENPosition {
	private var log : ILogger;

	private var _position : Dictionary;

	public function FENPosition() {
		this.log = LoggerFactory.getLogger( this, false );
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

	public function getNotationChar( piece : IPiece ) : String {
		switch( piece.getName() ) {
			case Pawn.NAME: return piece.isWhite ?      "P" : "p";
			case Bishop.NAME: return piece.isWhite ?    "B" : "b";
			case Knight.NAME: return piece.isWhite ?    "N" : "n";
			case Rook.NAME: return piece.isWhite ?      "R" : "r";
			case Queen.NAME: return piece.isWhite ?     "Q" : "q";
			case King.NAME: return piece.isWhite ?      "K" : "k";
		}
		log.error( "no notation char found!" );
		return "";
	}

	public function setPiece( piece : IPiece, notation : String ) : void {
		if ( ! this._position.hasOwnProperty( notation ) ) {
			log.warn( "unvalid position!" );
			return;
		}
		if ( this._position[ notation ] != null ) {
			log.warn( "position already set!" );
			return;
		}

		this._position[ notation ] = piece;
	}

	public function getNotation() : String {
		var sequence = ChessboardUtil.getNotationSequence();
		var notation : String;
		var p : IPiece;
		var i : int = 0; // counter for iteration
		var c : int = 0; // counter for empty fields
		var out : String = "";
		var rd : String = "/"; // row delimiter

		for each ( notation in sequence ) {
			p = this._position[ notation ];

			if ( i != 0 && ( i + 1 ) % 8 == 0 ) {
				out += c > 0 ? ( c + 1 ).toString() : "";
				c = 0;
				if ( p ) {
					out += this.getNotationChar( p );
				}
				out += rd;
				i++;
				continue;
			}

			if ( p == null ) {
				c++;
				i++;
				continue;
			}

			if ( c > 0 ) {
				out += c.toString();
				c = 0;
			}

			out += this.getNotationChar( p );
			i++;
		}

		// remove last delimiter
		out = out.substr( 0, out.length - rd.length );

		return out;
	}

	public function toString() : String {
		return this.getNotation();
	}
}
}