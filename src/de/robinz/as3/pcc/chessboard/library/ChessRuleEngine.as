package de.robinz.as3.pcc.chessboard.library {
import de.robinz.as3.pcc.chessboard.library.pieces.IPiece;
import de.robinz.as3.pcc.chessboard.library.vo.ChessboardGameVO;

import mx.effects.Move;

/**
 * de.robinz.as3.pcc.chessboard.library
 *
 * @author robin heinel
 */
public class ChessRuleEngine {
	private var _game : ChessboardGameVO;

	public function ChessRuleEngine( game : ChessboardGameVO ) {
		this._game = game;
	}

	public function isChess() : IPiece {
		return null;
	}

	public function isChessOnField( notation : String ) : IPiece {
		return null;
	}

	public function isSpecialMove( m : ChessboardMove ) : void {
	}

	public function isBehindPiece( piece : IPiece, notation : String ) : void {
	}

}
}