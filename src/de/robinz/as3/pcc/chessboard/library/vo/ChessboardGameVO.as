package de.robinz.as3.pcc.chessboard.library.vo
{
import de.robinz.as3.pcc.chessboard.library.*;

/**
 * ChessboardGameVO
 *
 * @author robin heinel
 */
public class ChessboardGameVO
{
	public var moves : ChessboardMoveCollection;
	public var check : ChessCheckVO;
	public var name : String;
	public var dateStored : Date;
	public var currentMove : int;
	public var isLastMove : Boolean = true;
	public var currentPlayer : Player;

	private var _dateStart : Date;

	public function ChessboardGameVO() {
		this.moves = new ChessboardMoveCollection();
		this._dateStart = new Date();
	}

	public function get dateStart() : Date {
		return this._dateStart;
	}

}
}