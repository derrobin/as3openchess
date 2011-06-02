package de.robinz.as3.pcc.chessboard.library.pieces
{

import de.robinz.as3.pcc.chessboard.library.ChessPosition;
import de.robinz.as3.pcc.chessboard.library.ChessboardMove;
import de.robinz.as3.pcc.chessboard.library.ChessboardMoveCollection;
import de.robinz.as3.pcc.chessboard.library.FieldNotation;

/**
 * IPiece
 *
 * @author robin heinel
 */
public interface IPiece
{
	function get fontKey() : String;
	function get isWhite() : Boolean;
	function get notationChar() : String;
	function get isMoved() : Boolean;
	function getGeometricValidMoviesToField( field:FieldNotation, position:ChessPosition ) : ChessboardMoveCollection;

	function setBlack() : void;
	function move() : void;
	function equals( piece : IPiece ) : Boolean;
	function isMoveValid( m : ChessboardMove ) : Boolean;

	// TODO: implement this as getter
	function getName() : String;
	// TODO: implement this as getter
	function getSortIndex() : int;
}
}