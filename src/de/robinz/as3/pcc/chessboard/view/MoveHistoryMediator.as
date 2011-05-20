package de.robinz.as3.pcc.chessboard.view
{
import de.robinz.as3.pcc.chessboard.ApplicationFacade;
import de.robinz.as3.pcc.chessboard.library.ChessboardMove;
import de.robinz.as3.pcc.chessboard.library.pieces.Pawn;
import de.robinz.as3.pcc.chessboard.view.views.ChessboardMoveHistory;
import de.robinz.as3.pcc.chessboard.view.views.moveHistory.ChessboardMoveEntry;

import flash.display.DisplayObject;
import flash.events.MouseEvent;

import org.puremvc.as3.interfaces.INotification;

/**
 * UI Control for Info Panel - Move History
 *
 * @author robin heinel
 */
public class MoveHistoryMediator extends BaseMediator
{
	public static const NAME : String = "MoveHistoryMediator";

	private const ENTRY_COLOR_DEFAULT : int = 0xffffff;
	private const ENTRY_COLOR_HOOVER : int = 0xE3E3E3;
	private const ENTRY_COLOR_CURRENT_MOVE : int = 0xFFD1D1;


	public function MoveHistoryMediator( m : ChessboardMoveHistory ) {
		super( NAME, m );
	}

	// Start Mediator overrides ( Notification Delegates excluded, see below )

	// End Mediator overrides ( Notification Delegates excluded, see below )


	// Start Innerclass Methods

	private function hooverEntry( entry : ChessboardMoveEntry, newColor : int ) : void {
		var color : int = int( entry.getStyle( "backgroundColor" ) );
		if ( color == ENTRY_COLOR_CURRENT_MOVE ) {
			return;
		}
		entry.setStyle( "backgroundColor", newColor );
	}

	private function selectMoveEntry( m : ChessboardMove ) : void {
		var entry : ChessboardMoveEntry = this.getMoveEntry( m );
		if ( entry == null ) {
			return;
		}
		this.unselectAllMoveEntries();
		entry.setStyle( "backgroundColor", ENTRY_COLOR_CURRENT_MOVE );
	}

	private function unselectAllMoveEntries() : void {
		var childs : Array = this.view.moveList.getChildren();
		var child : ChessboardMoveEntry;
		for each( child in childs ) {
			child.setStyle( "backgroundColor", ENTRY_COLOR_DEFAULT );
		}
	}

	private function getMoveEntry( m : ChessboardMove ) : ChessboardMoveEntry {
		var childs : Array = this.view.moveList.getChildren();
		var child : ChessboardMoveEntry;
		var move : ChessboardMove;
		for each( child in childs ) {
			move = child.data as ChessboardMove;
			if ( move.equals( m ) ) {
				return child;
			}
		}
		return null;
	}

	private function removeLastEntry() : void {
		if ( this.view.moveList.numChildren == 0 ) {
			return;
		}
		var d : DisplayObject = this.view.moveList.getChildAt( 0 );
		this.view.moveList.removeChild( d );
	}

	private function reset() : void {
		this.view.moveList.removeAllChildren();
	}

	private function add( m : ChessboardMove ) : void {
		if ( m.validMove == null || m.isCastlingRookMovement ) {
			return;
		}

		var me : ChessboardMoveEntry = new ChessboardMoveEntry();
		me.initialize();
		me.data = m;

		me.moveNumber.text = m.game.currentMove + ".";

		if ( m.validMove.isCastlingShort ) {
			me.moveDescription.text = "O-O";
		} else if ( m.validMove.isCastlingLong ) {
			me.moveDescription.text = "O-O-O";
		} else {
			var divider : String = m.beatenPiece == null ? "-" : "x";
			var notationChar : String = m.piece.getName() == Pawn.NAME ? "" : m.piece.notationChar;
			me.moveDescription.text = notationChar + m.fromPosition.toString() + divider + m.toPosition.toString();
		}

		me.mouseChildren = false;
		me.mouseEnabled = true;
		me.useHandCursor = true;

		me.addEventListener( MouseEvent.MOUSE_OVER, onMoveEntryMouseOver );
		me.addEventListener( MouseEvent.MOUSE_OUT, onMoveEntryMouseOut );
		me.addEventListener( MouseEvent.CLICK, onMoveEntryClick );

		this.unselectAllMoveEntries();

		view.moveList.addChildAt( me, 0 );
	}

	// End Innerclass Methods


	// Start Notification Delegates

	public override function listNotificationInterests() : Array {
		return [
			ApplicationFacade.SELECT_MOVE_HISTORY_ENTRY,
			ApplicationFacade.NEW_GAME,
			ApplicationFacade.MOVE
		];
	}

	public override function handleNotification( n : INotification ) : void {
		switch( n.getName() ) {
			case ApplicationFacade.SELECT_MOVE_HISTORY_ENTRY:
				this.handleSelectMoveHistoryEntry( n.getBody() == null ? null : n.getBody() as ChessboardMove );
			break;
			case ApplicationFacade.NEW_GAME:
				this.handleNewGame();
			break;
			case ApplicationFacade.MOVE:
				this.handleMove( n.getBody() as ChessboardMove );
			break;
		}
	}

	// End Notification Delegates


	// Start Notification Handlers

	private function handleSelectMoveHistoryEntry( move : ChessboardMove ) : void {
		if ( move == null ) {
			this.unselectAllMoveEntries();
			return;
		}
		this.selectMoveEntry( move );
	}

	private function handleNewGame() : void {
		this.reset();
	}

	private function handleMove( move : ChessboardMove ) : void {
		//this.selectMoveEntry( move );
		if ( move.isMoveBack || move.isMoveForward ) {
			return;
		}
		this.add( move );
	}

	// End Notification Handlers


	// Start Event Handlers

	private function onMoveEntryMouseOver( e : MouseEvent ) : void {
		var entry : ChessboardMoveEntry = e.currentTarget as ChessboardMoveEntry;
		this.hooverEntry( entry, ENTRY_COLOR_HOOVER );
	}

	private function onMoveEntryMouseOut( e : MouseEvent ) : void {
		var entry : ChessboardMoveEntry = e.currentTarget as ChessboardMoveEntry;
		this.hooverEntry( entry, ENTRY_COLOR_DEFAULT );
	}

	private function onMoveEntryClick( e : MouseEvent ) : void {
		var entry : ChessboardMoveEntry = e.currentTarget as ChessboardMoveEntry;
		var move : ChessboardMove = entry.data as ChessboardMove;
		sendNotification( ApplicationFacade.MOVE_JUMP, move );
	}

	// End Event Handlers


	// Start Getter / Setters

	protected function get view() : ChessboardMoveHistory {
		return this.viewComponent as ChessboardMoveHistory;
	}

	// End Getter / Setters
}
}