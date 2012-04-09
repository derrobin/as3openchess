package de.robinz.as3.pcc.chessboard.view
{
import de.robinz.as3.pcc.chessboard.ApplicationFacade;
import de.robinz.as3.pcc.chessboard.ApplicationFacade;
import de.robinz.as3.pcc.chessboard.library.vo.FontVO;
import de.robinz.as3.pcc.chessboard.library.vo.FontVOCollection;
import de.robinz.as3.pcc.chessboard.library.vo.PieceSettingsVO;
import de.robinz.as3.pcc.chessboard.library.vo.PieceSettingsVO;
import de.robinz.as3.pcc.chessboard.view.views.game.PieceSettingsDialog;
import de.robinz.as3.rzlib.ui.IListEntry;
import de.robinz.as3.rzlib.ui.ListEntry;

import flash.events.Event;
import flash.events.MouseEvent;

import mx.collections.ArrayCollection;
import mx.containers.TitleWindow;
import mx.controls.Button;

import org.puremvc.as3.interfaces.INotification;

/**
 * UI Control for Info Panel - Move History
 *
 * @author robin heinel
 */
public class PieceSettingsMediator extends DialogBaseMediator
{
	public static const NAME : String = "PieceSettingsMediator";

	// private var _pieceSettings : PieceSettingsVO;

	public function PieceSettingsMediator( viewStage : mainapp ) {
		super( NAME, viewStage );
	}

	// Start Mediator overrides ( Notification Delegates excluded, see below )

	// End Mediator overrides ( Notification Delegates excluded, see below )


	// Start Innerclass Methods

	private function bindControls( sets : PieceSettingsVO ) : void {
		this.popup.pieceSize.value = sets.fontSize;
		this.popup.pieceStyle.dataProvider = this.createFontList( sets.fonts );
		this.selectCurrentFont( sets.font );
	}

	private function readControls() : PieceSettingsVO {
		var sets : PieceSettingsVO = new PieceSettingsVO();
		sets.font = this.popup.pieceStyle.selectedItem.data as FontVO;
		sets.fontSize = this.popup.pieceSize.value as int;

		return sets;
	}


	private function applyChanges() : void {
		var fontSize : int = this.popup.pieceSize.value as int;
		var font : FontVO = this.popup.pieceStyle.selectedItem.data as FontVO;

		var sets : PieceSettingsVO = new PieceSettingsVO();

		sets.font = font;
		sets.fontSize = fontSize;

		sendNotification( ApplicationFacade.CHANGE_PIECE_SETTINGS, sets );
	}

	private function appear() : void {
		var view : TitleWindow = this.createDialog( "Piece Settings", 450, 325, PieceSettingsDialog, this.stage );

		view.addEventListener( PieceSettingsDialog.EVENT_CHANGE_STYLE, onChangeStyle );
		view.addEventListener( MouseEvent.CLICK, onMouseClick );
		view.addEventListener( PieceSettingsDialog.EVENT_CLOSE, onClose );

		this._dialog = view as PieceSettingsDialog;
		this._dialog.addEventListener( MouseEvent.CLICK, onMouseClick );
	}

	private function createFontList( fonts : FontVOCollection ) : ArrayCollection {
		var list : ArrayCollection = new ArrayCollection();

		for each( var font : FontVO in fonts.list ) {
			list.addItem( new ListEntry( font.name, font ) );
		}

		return list;
	}

	private function selectCurrentFont( font : FontVO ) : void {
		var ac : ArrayCollection = this.popup.pieceStyle.dataProvider as ArrayCollection;
		var f : FontVO;

		for each( var li : IListEntry in ac ) {
			f = li.data as FontVO;
			if ( f.id == font.id ) {
				this.popup.pieceStyle.selectedItem = li;
				return;
			}
		}
	}

	private function close() : void {
		sendNotification( ApplicationFacade.DISAPPEAR_PIECE_SETTINGS );
		this.disappear();
	}

	// End Innerclass Methods


	// Start Notification Delegates

	public override function listNotificationInterests() : Array {
		return [
			ApplicationFacade.APPEAR_PIECE_SETTINGS,
			ApplicationFacade.DISAPPEAR_PIECE_SETTINGS
		];
	}

	public override function handleNotification( n : INotification ) : void {
		switch( n.getName() ) {
			case ApplicationFacade.APPEAR_PIECE_SETTINGS:
				this.handleAppearPieceSettings( n.getBody() as PieceSettingsVO, n.getType() is String ? n.getType() as String : null );
			break;
			case ApplicationFacade.DISAPPEAR_PIECE_SETTINGS:
				this.handleDisappearPieceSettings();
			break;

		}
	}

	// End Notification Delegates


	// Start Notification Handlers

	private function handleAppearPieceSettings( sets : PieceSettingsVO, type : String ) : void {
		if ( type == ApplicationFacade.NOTIFICATION_TYPE_INTERRUPT_APPEAR ) {
			return;
		}
		this.appear();
		this.bindControls( sets );
		// this.refreshStyleEntries();
	}

	private function handleDisappearPieceSettings() : void {
		this.disappear();
	}

	// End Notification Handlers


	// Start Event Handlers

	private function onClose( e : Event ) : void {
		this.close();
	}

	private function onMouseClick( e : MouseEvent ) : void {
		if ( e.target is Button ) {
			var b : Button = e.target as Button;
			if ( b.id == this.popup.applyChanges.id ) {
				this.applyChanges();
			}
		}
	}

	private function onChangeStyle( e : Event ) : void {

	}

	// End Event Handlers


	// Start Getter / Setters

	protected function get popup() : PieceSettingsDialog {
		return this._dialog as PieceSettingsDialog;
	}

	// End Getter / Setters
}
}