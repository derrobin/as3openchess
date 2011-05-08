package de.robinz.as3.pcc.chessboard.library.pieces
{
import de.robinz.as3.pcc.chessboard.library.ChessboardMove;

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
	function get hasAbilityToBeatDiagonal() : Boolean;
	function get hasAbilityToBeatLine() : Boolean;

	function setWhite() : void;
	function setBlack() : void;
	function equals( piece : IPiece ) : Boolean;
	function isMoveValide( m : ChessboardMove ) : Boolean;

	// TODO: implement this as getter
	function getName() : String;
	// TODO: implement this as getter
	function getSortIndex() : int;
}
}