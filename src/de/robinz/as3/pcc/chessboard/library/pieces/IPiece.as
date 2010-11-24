package de.robinz.as3.pcc.chessboard.library.pieces
{
	public interface IPiece
	{
		function get fontKey() : String;
		function get isWhite() : Boolean;
		function get notationChar() : String;

		function setWhite() : void;
		function setBlack() : void;

		function getName() : String;
		function getSortIndex() : int;

	}
}