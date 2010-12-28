package de.robinz.as3.pcc.chessboard.library.pieces
{
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

		function setWhite() : void;
		function setBlack() : void;
		function equals( piece : IPiece ) : Boolean;

		// TODO: implement this as getter
		function getName() : String;
		// TODO: implement this as getter
		function getSortIndex() : int;
	}
}