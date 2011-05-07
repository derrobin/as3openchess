package de.robinz.as3.pcc.chessboard.view
{
import de.robinz.as3.pcc.chessboard.ApplicationFacade;
import de.robinz.as3.pcc.chessboard.library.ChessboardMove;
import de.robinz.as3.pcc.chessboard.library.pieces.IPiece;
import de.robinz.as3.pcc.chessboard.view.views.ChessboardTakenPieces;
import de.robinz.as3.pcc.chessboard.view.views.takenPieces.TakenPiece;

import mx.core.Container;

import org.puremvc.as3.interfaces.INotification;
import org.puremvc.as3.patterns.mediator.Mediator;

/**
 * UI Control for Info Panel - Taken Pieces
 *
 * @author robin heinel
 */
public class TakenPiecesMediator extends BaseMediator
{
	public static const NAME : String = "TakenPiecesMediator";

	public function TakenPiecesMediator( m : ChessboardTakenPieces ) {
		super( NAME, m );
	}


	// Start Innerclass Methods

	private function reset() : void {
		this.view.whitePieces.removeAllChildren();
		this.view.blackPieces.removeAllChildren();
	}

	private function addPiece( p : IPiece, addWrapper : Boolean = true ) : void {
		var tp : TakenPiece = new TakenPiece();
		tp.initialize();
		tp.piece.text = p.fontKey;
		tp.data = p;

		var targetContainer : Container;

		if ( p.isWhite ) {
			targetContainer = this.view.whitePieces;
		} else {
			targetContainer = this.view.blackPieces;
		}

		targetContainer.addChild( tp );

		// TODO: Sort Piece Queue ( mb use of outcommented insertPiece )
	}

	private function removePiece( p : IPiece ) : void {
		var wrapper : TakenPiece = this.getPieceWrapperFor( p );
		if ( wrapper == null ) {
			return;
		}
		wrapper.parent.removeChild( wrapper );
	}

	private function getPieceWrapperFor( piece : IPiece ) : TakenPiece {
		var tp : TakenPiece;
		var p : IPiece;
		var wrappers : Array = this.getPieceWrappers();
		for each( tp in wrappers ) {
			p = tp.data as IPiece;
			if ( ! p.equals( piece ) ) {
				continue;
			}

			return tp;
		}

		return null;
	}

	private function getPieceWrappers() : Array {
		return new Array().concat(
			this.view.whitePieces.getChildren(),
			this.view.blackPieces.getChildren()
		);
	}

	private function refreshPieces() : void {
		var piece : IPiece;
		var tp : TakenPiece;
		var wrappers : Array = this.getPieceWrappers();

		var i : int = 0;
		while ( wrappers.length > i ) {
			tp = wrappers[ i ] as TakenPiece;
			piece = tp.data as IPiece;

			// Remove Piece View from Viewstack
			tp.parent.removeChild( tp );

			// Add as new piece to viewstack with the right fontkey
			this.addPiece( piece );

			i++;
		};
	}

	/*
	private function insertPiece( c : Container, p : Piece ) : void {
		var childs = c.getChildren();
		var child : TakenPiece;
		var piece : IPiece;
		for each( child in childs ) {
			piece = child.data as IPiece;
			if ( piece.getSortIndex() == p.getSortIndex() ) {
				c.addChild();
			}
		}

		c.addChildAt( c, p.getSortIndex() );
	}
	*/

	// End Innerclass Methods


	// Start Notification Delegates

	public override function listNotificationInterests() : Array {
		return [
			ApplicationFacade.RESTORE_PIECE,
			ApplicationFacade.CHANGE_PIECE_SETTINGS,
			ApplicationFacade.NEW_GAME,
			ApplicationFacade.PIECE_REMOVED
		];
	}

	public override function handleNotification( n : INotification ) : void {
		switch( n.getName() ) {
			case ApplicationFacade.RESTORE_PIECE:
				this.handleRestorePiece( n.getBody() as IPiece );
			break;
			case ApplicationFacade.CHANGE_PIECE_SETTINGS:
				this.handleChangePieceSettings();
			break;
			case ApplicationFacade.NEW_GAME:
				this.handleNewGame();
			break;
			case ApplicationFacade.PIECE_REMOVED:
				this.handlePieceRemoved( n.getBody() as ChessboardMove );
			break;
		}
	}

	// End Notification Delegates


	// Start Notification Handlers

	private function handleRestorePiece( piece : IPiece ) : void {
		this.removePiece( piece );
	}

	private function handleChangePieceSettings() : void {
		// TODO: make condition to internal state
		this.refreshPieces();
	}

	private function handleNewGame() : void {
		this.reset();
	}

	private function handlePieceRemoved( m : ChessboardMove ) : void {
		this.addPiece( m.beatenPiece );
	}

	// End Notification Handlers


	// Start Event Handlers

	// End Event Handlers


	// Start Getter / Setters

	protected function get view() : ChessboardTakenPieces {
		return this.viewComponent as ChessboardTakenPieces;
	}

	// End Getter / Setters
}
}