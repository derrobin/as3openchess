package de.robinz.as3.pcc.chessboard.controller.move
{
import de.robinz.as3.pcc.chessboard.ApplicationFacade;
import de.robinz.as3.pcc.chessboard.controller.BaseCommand;
import de.robinz.as3.pcc.chessboard.library.ChessboardMove;
import de.robinz.as3.pcc.chessboard.library.ChessboardMove;
import de.robinz.as3.pcc.chessboard.library.FieldNotation;
import de.robinz.as3.pcc.chessboard.library.MoveValidator;
import de.robinz.as3.pcc.chessboard.library.Player;
import de.robinz.as3.pcc.chessboard.model.GameProxy;

import flash.sampler._getInvocationCount;

import org.puremvc.as3.interfaces.INotification;
import org.puremvc.as3.patterns.command.SimpleCommand;

/**
 * MoveCommand
 *
 * @author robin heinel
 */
public class MoveCommand extends BaseCommand
{
	// Start SimpleCommand overrides

	public override function execute( n : INotification ) : void {
		super.execute( n );

		if ( n.getBody() is ChessboardMove ) {
			this.move( n.getBody() as ChessboardMove );
		}
	}

	// End SimpleCommand overrides


	// Start Innerclass Methods

	private function move( m : ChessboardMove ) : void {
		// extra move for rochade
		// MoveValidator( m.game, m.piece );
		var vm : ChessboardMove = m.validMove;
		var p : Player = m.game.currentPlayer;
		if ( vm != null ) {
			if ( p.isWhite && vm.isCastlingShort ) {
				this.moveRook( p, m, "h1", "f1" );
			}
			if ( p.isWhite && vm.isCastlingLong ) {
				this.moveRook( p, m, "a1", "d1" );
			}
			if ( p.isBlack && vm.isCastlingShort ) {
				this.moveRook( p, m, "h8", "f8" );
			}
			if ( p.isBlack && vm.isCastlingLong ) {
				this.moveRook( p, m, "a8", "d8" );
			}
		}

		if ( m.validMove.isEnPassant ) {
			var field : FieldNotation = m.toPosition.clone();
			field.setRow( m.game.currentPlayer.isWhite ? -1 : +1 );

			log.debug( "remove enemy pawn at {0}", field.toString() );
			sendNotification( ApplicationFacade.REMOVE_PIECE, field );
		}

		if ( m.isMoveForward == false ) {
			this.gameProxy.move( m );
		}

		// give a reference to the corresponding game
		// now currentMove is right
		m.game = gameProxy.getCurrentGame();

		if ( m.game.isLastMove ) {
			sendNotification( ApplicationFacade.UNLOCK_BOARD );
		} else {
			sendNotification( ApplicationFacade.LOCK_BOARD );
		}

		log.debug( "next player: {0} ( {1} )", m.game.currentPlayer.name, m.game.currentPlayer.isWhite ? "white" : "black" );
	}

	private function moveRook( player : Player, parentMove : ChessboardMove, fromNotation : String, toNotation : String ) : void {
		var move : ChessboardMove = new ChessboardMove();
		move.fromPosition = FieldNotation.createNotationByString( fromNotation );
		move.toPosition = FieldNotation.createNotationByString( toNotation );
		move.game = parentMove.game;
		move.piece = parentMove.position.getPieceAt( fromNotation );
		move.isCastlingRookMovement = true;

		sendNotification( ApplicationFacade.MOVE, move );
	}

	// End Innerclass Methods


	// Start Getter / Setters

	// End Getter / Setters
}
}