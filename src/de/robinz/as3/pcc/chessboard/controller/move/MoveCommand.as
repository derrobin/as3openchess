package de.robinz.as3.pcc.chessboard.controller.move
{
import de.robinz.as3.pcc.chessboard.ApplicationFacade;
import de.robinz.as3.pcc.chessboard.controller.BaseCommand;
import de.robinz.as3.pcc.chessboard.library.ChessboardMove;
import de.robinz.as3.pcc.chessboard.library.ChessboardMoveCollection;
import de.robinz.as3.pcc.chessboard.library.ChessboardUtil;
import de.robinz.as3.pcc.chessboard.library.FieldNotation;
import de.robinz.as3.pcc.chessboard.library.Player;
import de.robinz.as3.pcc.chessboard.library.pieces.IPiece;
import de.robinz.as3.pcc.chessboard.library.pieces.Pawn;
import de.robinz.as3.pcc.chessboard.library.pieces.PieceCollection;
import de.robinz.as3.pcc.chessboard.library.vo.ChessCheckVO;
import de.robinz.as3.pcc.chessboard.library.vo.PiecePositionVO;

import de.robinz.as3.pcc.chessboard.library.vo.PiecePositionVOCollection;

import flash.utils.setTimeout;

import org.puremvc.as3.interfaces.INotification;

/**
 * MoveCommand
 *
 * @author robin heinel
 */
public class MoveCommand extends BaseCommand
{
	private var m : ChessboardMove;

	// Start SimpleCommand overrides

	public override function execute( n : INotification ) : void {
		super.execute( n );

		if ( n.getBody() is ChessboardMove ) {
			this.m = n.getBody() as ChessboardMove ;
			this.move();
		}
	}

	// End SimpleCommand overrides


	// Start Innerclass Methods

	private function move() : void {
		this.handleSpecialMoves();

		if ( m.piece is Pawn ) {
			this.checkPawnPromotion();
		}

		if ( m.isMoveForward == false && m.isMoveBack == false && m.isMoveJump == false ) {
			this.gameProxy.move( m );
			this.verifyCheck();
		} else {

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

	private function verifyCheck() : Boolean {
		var nextPlayer : Player = this.gameProxy.getCurrentGame().currentPlayer;
		var currentKing : PiecePositionVO = m.position.getKing( nextPlayer.isWhite );
		var enemyPieces : PiecePositionVOCollection = m.position.getPieces( ! nextPlayer.isWhite );

		var ep : PiecePositionVO; // enemy piece
		var validMoves : ChessboardMoveCollection;
		var validMove : ChessboardMove;
		for each( ep in enemyPieces.list ) {
			log.debug( "enemy piece {0} {1}", ep.notation.toString(), ep.piece.getName() );
			validMoves = ChessboardUtil.getValidMoves( m.game, m.position, ep );
			for each ( validMove in validMoves.list ) {
				log.debug( "valid move to {0} for piece {1}", validMove.toPosition.toString(), ep.piece.getName() );
				if ( validMove.toPosition.toString() == currentKing.notation.toString() ) {
					log.info( "cheek to player {0}", m.game.currentPlayer.name );
					m.game.check = ChessCheckVO.create( ep, currentKing );
					return true;
				}
			}
		}

		m.game.check = null;
		return false;
	}

	private function checkPawnPromotion() : void {
		var pp : PiecePositionVO = new PiecePositionVO();
		pp.notation = m.toPosition;
		pp.piece = m.piece;

		var targetRow : int = m.game.currentPlayer.isWhite ? 8 : 1;

		if ( m.toPosition.row == targetRow ) {
			sendNotification( ApplicationFacade.PAWN_PROMOTION, pp );
		}
	}

	private function handleSpecialMoves() : void {
		if ( m.validMove == null ) {
			return;
		}

		var vm : ChessboardMove = m.validMove;
		var p : Player = m.game.currentPlayer;

		// check extra move for rochade
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
	}

	private function moveRook( player : Player, parentMove : ChessboardMove, fromNotation : String, toNotation : String ) : void {
		var move : ChessboardMove = new ChessboardMove();
		move.fromPosition = FieldNotation.createNotationByString( fromNotation );
		move.toPosition = FieldNotation.createNotationByString( toNotation );
		move.position = parentMove.position;
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