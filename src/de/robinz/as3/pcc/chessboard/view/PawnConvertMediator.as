package de.robinz.as3.pcc.chessboard.view
{
import de.robinz.as3.pcc.chessboard.ApplicationFacade;
import de.robinz.as3.pcc.chessboard.library.ChessboardUtil;
import de.robinz.as3.pcc.chessboard.library.pieces.IPiece;
import de.robinz.as3.pcc.chessboard.library.pieces.Piece;
import de.robinz.as3.pcc.chessboard.library.vo.PawnConvertDialogVO;
import de.robinz.as3.pcc.chessboard.library.vo.PiecePositionVO;
import de.robinz.as3.pcc.chessboard.view.views.chessboard.ChessboardField;
import de.robinz.as3.pcc.chessboard.view.views.game.PawnConvertDialog;

import flash.display.DisplayObject;
import flash.events.Event;
import flash.events.MouseEvent;

import mx.controls.Text;

import org.puremvc.as3.interfaces.INotification;

/**
 * SaveGameDialogMediator
 *
 * @author robin heinel
 */
public class PawnConvertMediator extends DialogBaseMediator
{
	public static const NAME : String = "PawnConvertMediator";

	private var _data : PawnConvertDialogVO;

	public function PawnConvertMediator( viewStage : DisplayObject ) {
		super( NAME, viewStage );
		this._data = new PawnConvertDialogVO();
	}


	// Start Innerclass Methods

	private function createField( pieceName : String, notation : String, isWhite : Boolean, size : int = 75 ) : ChessboardField {
		var field : ChessboardField = ChessboardUtil.createBoardField( notation, true );

		field.setPiece( Piece.createByParams( pieceName, isWhite ) );
		field.width = size;
		field.height = size;

		field.setStyle( "borderColor", 0xbbbbbb );
		field.setStyle( "borderThickness", 1 );
		field.setStyle( "borderStyle", "solid" );
		field.setStyle( "borderSides", "top bottom right left" );

		field.addEventListener( MouseEvent.MOUSE_OVER, function() { field.setStyle( "borderColor", 0xff0000 ); } );
		field.addEventListener( MouseEvent.MOUSE_OUT, function() { field.setStyle( "borderColor", 0xbbbbbb ); } );

		return field;
	}

	private function convertPawn( toPiece : IPiece ) : void {
		var newPiece : PiecePositionVO = new PiecePositionVO();
		newPiece.notation = this._data.pawn.notation;
		newPiece.piece = Piece.createByParams( toPiece.getName(), toPiece.isWhite );
		newPiece.piece.move();

		sendNotification( ApplicationFacade.REMOVE_PIECE, this._data.pawn.notation, ApplicationFacade.PAWN_PROMOTION );
		sendNotification( ApplicationFacade.SET_PIECE, newPiece );
	}

	private function appear() : void {
		var view : PawnConvertDialog = this.createDialog( "Convert Pawn to: ", 380, 170, PawnConvertDialog, this.stage, true ) as PawnConvertDialog;

		var isWhite : Boolean = this._data.pawn.piece.isWhite;
		view.fieldStage.addChild( createField( "queen", "a1", isWhite ) );
		view.fieldStage.addChild( createField( "rook", "a2", isWhite ) );
		view.fieldStage.addChild( createField( "bishop", "a3", isWhite ) );
		view.fieldStage.addChild( createField( "knight", "a4", isWhite ) );

		view.initialize();

		view.fieldStage.addEventListener( MouseEvent.CLICK, onMouseClick );

		view.showCloseButton = false;

		this.flushData();
	}

	private function flushData() : void {
		if ( this.popUp == null ) {
			return;
		}
	}

	// End Innerclass Methods


	// Start Notification Delegates

	public override function listNotificationInterests() : Array {
		return [
			ApplicationFacade.PAWN_PROMOTION
		];
	}

	public override function handleNotification( n : INotification ) : void {
		switch( n.getName() ) {
			case ApplicationFacade.PAWN_PROMOTION:
				this.handlePawnPromotion( n.getBody() as PiecePositionVO );
			break;
		}
	}

	// End Notification Delegates


	// Start Notification Handlers

	private function handlePawnPromotion( pawn : PiecePositionVO ) : void {
		this._data.pawn = pawn;
		this.appear();
	}

	// End Notification Handlers


	// Start Event Handlers

	private function onMouseClick( e : Event ) : void {
		var piece : IPiece = null;

		if ( e.target is Text ) {
			var t : Text = e.target as Text;
			if ( t.data is IPiece ) {
				piece = t.data as IPiece;
			}
		}
		if ( e.target is ChessboardField ) {
			var field : ChessboardField = e.target as ChessboardField;
			piece = ( field.getChildAt( 0 ) as Text ).data as IPiece;
		}

		if ( piece != null ) {
			log.debug( "piece {0} choosen",  piece.getName() );
			this.convertPawn( piece );
			this.disappear();
			this.facade.removeMediator( PawnConvertMediator.NAME );
		}

	}

	// End Event Handlers


	// Start Getter / Setters

	protected function get popUp() : PawnConvertDialog {
		return this._dialog as PawnConvertDialog;
	}

	// End Getter / Setters

}
}