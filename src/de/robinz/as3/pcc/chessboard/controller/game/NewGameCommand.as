package de.robinz.as3.pcc.chessboard.controller.game
{
import de.robinz.as3.pcc.chessboard.ApplicationFacade;
import de.robinz.as3.pcc.chessboard.controller.BaseCommand;
import de.robinz.as3.pcc.chessboard.library.Player;
import de.robinz.as3.pcc.chessboard.library.pieces.Bishop;
import de.robinz.as3.pcc.chessboard.library.pieces.King;
import de.robinz.as3.pcc.chessboard.library.pieces.Knight;
import de.robinz.as3.pcc.chessboard.library.pieces.Pawn;
import de.robinz.as3.pcc.chessboard.library.pieces.Queen;
import de.robinz.as3.pcc.chessboard.library.pieces.Rook;
import de.robinz.as3.pcc.chessboard.model.GameProxy;

import org.puremvc.as3.interfaces.INotification;
import org.puremvc.as3.patterns.command.SimpleCommand;

/**
 * NewGameCommand
 *
 * @author robin heinel
 */
public class NewGameCommand extends BaseCommand
{
	// Start SimpleCommand overrides

	public override function execute( n : INotification ) : void {
		super.execute( n );

		sendNotification( ApplicationFacade.REMOVE_ALL_PIECES );
		sendNotification( ApplicationFacade.DISABLE_BOARD_INSPECT_PIECE_MODE );
		sendNotification( ApplicationFacade.UNLOCK_BOARD );

		this.setEnPassantTest();
		this.gameProxy.reset();

		this.gameProxy.start(
				new Player( "White", true ),
				new Player( "Black" )
		);

		sendNotification( ApplicationFacade.GAME_STARTED, gameProxy.getCurrentGame() );
	}

	// End SimpleCommand overrides


	// Start Innerclass Methods

	private function setDefault() : void {
		this.setWhitePiece( Pawn.NAME, "a2" );
		this.setWhitePiece( Pawn.NAME, "b2" );
		this.setWhitePiece( Pawn.NAME, "c2" );
		this.setWhitePiece( Pawn.NAME, "d2" );
		this.setWhitePiece( Pawn.NAME, "e2" );
		this.setWhitePiece( Pawn.NAME, "f2" );
		this.setWhitePiece( Pawn.NAME, "g2" );
		this.setWhitePiece( Pawn.NAME, "h2" );
		this.setWhitePiece( Rook.NAME, "a1" );
		this.setWhitePiece( Rook.NAME, "h1" );
		this.setWhitePiece( Bishop.NAME, "c1" );
		this.setWhitePiece( Bishop.NAME, "f1" );
		this.setWhitePiece( Knight.NAME, "b1" );
		this.setWhitePiece( Knight.NAME, "g1" );
		this.setWhitePiece( Queen.NAME, "d1" );
		this.setWhitePiece( King.NAME, "e1" );

		this.setBlackPiece( Pawn.NAME, "a7" );
		this.setBlackPiece( Pawn.NAME, "b7" );
		this.setBlackPiece( Pawn.NAME, "c7" );
		this.setBlackPiece( Pawn.NAME, "d7" );
		this.setBlackPiece( Pawn.NAME, "e7" );
		this.setBlackPiece( Pawn.NAME, "f7" );
		this.setBlackPiece( Pawn.NAME, "g7" );
		this.setBlackPiece( Pawn.NAME, "h7" );
		this.setBlackPiece( Rook.NAME, "a8" );
		this.setBlackPiece( Rook.NAME, "h8" );
		this.setBlackPiece( Bishop.NAME, "c8" );
		this.setBlackPiece( Bishop.NAME, "f8" );
		this.setBlackPiece( Knight.NAME, "b8" );
		this.setBlackPiece( Knight.NAME, "g8" );
		this.setBlackPiece( Queen.NAME, "d8" );
		this.setBlackPiece( King.NAME, "e8" );
	}

	private function setEnPassantTest() : void {
		this.setBlackPiece( Pawn.NAME, "b7" );
		this.setWhitePiece( Pawn.NAME, "c5" );
		this.setBlackPiece( Pawn.NAME, "e4" );
		this.setWhitePiece( Pawn.NAME, "f2" );
		this.setWhitePiece( Bishop.NAME, "c1" );
		this.setBlackPiece( Bishop.NAME, "c2" );
	}

	private function setWhitePiece( piece : String, shortenNotation : String ) : void {
		this.gameProxy.setPiece( piece, shortenNotation, true );
	}

	private function setBlackPiece( piece : String, shortenNotation : String ) : void {
		this.gameProxy.setPiece( piece, shortenNotation, false );
	}

	// End Innerclass Methods


	// Start Getter / Setters

	// End Getter / Setters

}
}