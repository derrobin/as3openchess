package de.robinz.as3.pcc.chessboard.library.pieces
{
/**
 * FakedPiece
 *
 * @author robin heinel
 */
public class FakedPiece extends Piece implements IPiece
{
	public static var NAME : String = "fakedPiece";

	public function FakedPiece() {
		this._useFontKey = true;
	}

	public override function getName() : String {
		return NAME;
	}

	public override function getSortIndex() : int {
		return 8;
	}

	public override function get notationChar() : String {
		return "X";
	}

	public function setFontKey( value : String ) : void {
		this._fontKey = value;
	}

}
}