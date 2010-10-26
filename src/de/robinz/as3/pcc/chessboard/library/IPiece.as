package de.robinz.as3.pcc.chessboard.library
{
	public interface IPiece
	{
		function get fontKey() : String;
		function get isWhite() : Boolean;

		function setWhite() : void;
		function setBlack() : void;

		function getName() : String;
	}
}