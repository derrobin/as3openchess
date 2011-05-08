package de.robinz.as3.pcc.chessboard.library {
import de.robinz.as3.pcc.chessboard.library.pieces.IPiece;

import flash.utils.Dictionary;

import mx.logging.ILogger;
import mx.logging.Log;

/**
 * de.robinz.as3.pcc.chessboard.library
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