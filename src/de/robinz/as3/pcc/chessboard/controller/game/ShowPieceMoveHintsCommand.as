package de.robinz.as3.pcc.chessboard.controller.game
{
import de.robinz.as3.pcc.chessboard.ApplicationFacade;
import de.robinz.as3.pcc.chessboard.library.ChessboardGame;
import de.robinz.as3.pcc.chessboard.library.ChessboardMove;
import de.robinz.as3.pcc.chessboard.library.Notation;
import de.robinz.as3.pcc.chessboard.library.vo.BoardPieceVO;
import de.robinz.as3.pcc.chessboard.model.GameProxy;
import de.robinz.as3.pcc.chessboard.model.SaveGameProxy;
import de.robinz.as3.pcc.chessboard.view.ApplicationMediator;
import de.robinz.as3.pcc.chessboard.view.ChessboardMediator;
import de.robinz.as3.pcc.chessboard.view.SaveGameDialogMediator;

import org.puremvc.as3.interfaces.INotification;
import org.puremvc.as3.patterns.command.SimpleCommand;

/**
 * ShowPieceMoveHintsCommand
 *
 * @author robin heinel
 */
public class ShowPieceMoveHintsCommand extends SimpleCommand
{
	// Start SimpleCommand overrides

	public override function execute( n : INotification ) : void {
		 //this.showPieceMoveHints( n.getBody() as BoardPieceVO );
	}

	// End SimpleCommand overrides


	// Start Innerclass Methods

//	private function showPieceMoveHints( bp : BoardPieceVO ) : void {
//		var rows : String = "abcdefgh";
//		var c : String; // char
//		var i : int = 1;
//		var j : int = 1;
//		var notation : String;
//		var isWhite : Boolean = true;
//		var move : ChessboardMove;
//		var fromPosition : Notation = Notation.createNotationByString( bp.notation );
//
//		// TODO: encapsulate this algorithm ( copied from ChessboardMediator )
//		for( j; j <= 8; j++ ) {
//			isWhite = isWhite ? false : true;
//
//			for( i; i <= rows.length; i++ ) {
//				c = rows.charAt( i - 1 );
//				notation = c + j.toString();
//
//				move = new ChessboardMove();
//				move.fromPosition = fromPosition;
//				move.toPosition = Notation.createNotationByString( notation );
//
//				bp.piece.isMoveValide();
//
//				trace( notation );
//			}
//
//			i = 1;
//		}
//	}

	// End Innerclass Methods


	// Start Getter / Setters

	private function get gameProxy() : GameProxy {
		return this.facade.retrieveProxy( GameProxy.NAME ) as GameProxy;
	}

	private function get boardMediator() : ChessboardMediator {
		return this.facade.retrieveMediator( ChessboardMediator.NAME ) as ChessboardMediator;
	}

	// End Getter / Setters
}
}