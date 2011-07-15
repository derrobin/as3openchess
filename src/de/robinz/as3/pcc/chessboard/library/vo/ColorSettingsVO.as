package de.robinz.as3.pcc.chessboard.library.vo {
/**
 * ColorSettingsVO
 *
 * @author robin heinel
 */
public class ColorSettingsVO {
	public var mainBackground : int;
	public var menuBarBackground : int;
	public var fieldWhite : int;
	public var fieldBlack : int;
	public var fieldValidDrop : int;
	public var fieldMoveHint : int;
	public var boardGapColor : int;
	public var boardBorderFont : int;
	public var boardBorderBackground : int;
	public var pieceBlack : int;
	public var pieceBlackBorder : int;
	public var pieceWhite : int;
	public var pieceWhiteBorder : int;

	public static function create(
		mainBackground : int,
		menuBarBackground : int,
		fieldWhite : int,
		fieldBlack : int,
		fieldValidDrop : int,
		fieldMoveHint : int,
		boardGapColor : int,
		boardBorderFont : int,
		boardBorderBackground : int,
		pieceWhite : int,
		pieceWhiteBorder : int,
		pieceBlack : int,
		pieceBlackBorder : int

	) : ColorSettingsVO {

		var o : ColorSettingsVO = new ColorSettingsVO();

		o.mainBackground = mainBackground;
		o.menuBarBackground = menuBarBackground;
		o.fieldBlack = fieldBlack;
		o.fieldWhite = fieldWhite;
		o.fieldValidDrop = fieldValidDrop;
		o.fieldMoveHint = fieldMoveHint;
		o.boardGapColor = boardGapColor;
		o.boardBorderBackground = boardBorderBackground;
		o.boardBorderFont = boardBorderFont;
		o.pieceWhite = pieceWhite;
		o.pieceWhiteBorder = pieceWhiteBorder;
		o.pieceBlack = pieceBlack;
		o.pieceBlackBorder = pieceBlackBorder;

		return o;
	}


}
}