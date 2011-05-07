package de.robinz.as3.pcc.chessboard.view
{
import de.robinz.as3.pcc.chessboard.ApplicationFacade;
import de.robinz.as3.pcc.chessboard.library.vo.FontVO;
import de.robinz.as3.pcc.chessboard.library.vo.PieceSettingsVO;
import de.robinz.as3.pcc.chessboard.view.views.game.PieceSettingsDialog;
import de.robinz.as3.rzlib.ui.IListEntry;
import de.robinz.as3.rzlib.ui.ListEntry;

import flash.events.Event;
import flash.events.MouseEvent;

import mx.collections.ArrayCollection;
import mx.containers.TitleWindow;
import mx.controls.Button;
import mx.events.CloseEvent;

import org.puremvc.as3.interfaces.INotification;

/**
 * UI Control for Info Panel - Move History
 *
 * @author robin heinel
 */
public class PieceSettingsMediator extends DialogBaseMediator
{
	public static const NAME : String = "PieceSettingsMediator";

	public static const NOTIFICATION_TYPE_INTERRUPT_APPEAR : String = "interruptAppear";

	protected const TARGET_ID_APPLY_CHANGES : String = "applyChanges";


	//private var _popup : PieceSettingsDialog;
	private var _pieceSettings : PieceSettingsVO;

	public function PieceSettingsMediator( viewStage : mainapp ) {
		super( NAME, viewStage );
	}

	// Start Mediator overrides ( Notification Delegates excluded, see below )

	// End Mediator overrides ( Notification Delegates excluded, see below )


	// Start Innerclass Methods

	private function preSelectItems() : void {
		this.selectPieceStyle( this._pieceSettings.font );
		this.selectPieceSize( this._pieceSettings.fontSize );
	}

	private function selectPieceSize( fontSize : int ) : void {
		this.popup.pieceSize.value = fontSize;
	}

	private function selectPieceStyle( font : FontVO ) : void {
		var li : IListEntry;
		var f : FontVO;
		var ac : ArrayCollection = this.popup.pieceStyle.dataProvider as ArrayCollection;
		for each( li in ac ) {
			f = li.data as FontVO;
			if ( f.id == font.id ) {
				this.popup.pieceStyle.selectedItem = li;
				return;
			}
		}
	}

	private function refreshStyleEntries() : void {
		if ( this._popup == null ) {
			return;
		}

		var ac : ArrayCollection = new ArrayCollection();

		var font : FontVO;
		for each( font in this._pieceSettings.fonts.list ) {
			ac.addItem( new ListEntry( font.name, font ) );
		}

		this.popup.pieceStyle.dataProvider = ac;
		this.preSelectItems();
	}

	private function setPieceSettings( settings : PieceSettingsVO ) : void {
		this._pieceSettings = settings;
	}

	private function applyChanges() : void {
		var fontSize : int = this.popup.pieceSize.value as int;
		var font : FontVO = this.popup.pieceStyle.selectedItem == null
			? this._pieceSettings.font
			: this.popup.pieceStyle.selectedItem.data as FontVO;
		var ps : PieceSettingsVO = new PieceSettingsVO();

		this._pieceSettings.font = font;
		this._pieceSettings.fontSize = fontSize;

		sendNotification( ApplicationFacade.CHANGE_PIECE_SETTINGS, this._pieceSettings );
	}

	private function appear() : void {
		var view : TitleWindow = this.createDialog( "Piece Settings", 450, 325, PieceSettingsDialog, this.stage );

		view.addEventListener( PieceSettingsDialog.EVENT_CHANGE_STYLE, onChangeStyle );
		view.addEventListener( MouseEvent.CLICK, onMouseClick );
		view.addEventListener( PieceSettingsDialog.EVENT_CLOSE, onClose );


		this._popup = view as PieceSettingsDialog;
		this._popup.addEventListener( MouseEvent.CLICK, onMouseClick );
	}

	private function close() : void {
		sendNotification( ApplicationFacade.DISAPPEAR_PIECE_SETTINGS );
		this.disappear();
	}

	// End Innerclass Methods


	// Start Notification Delegates

	public override function listNotificationInterests() : Array {
		return [
			ApplicationFacade.SET_FONT_SETTINGS,
			ApplicationFacade.APPEAR_PIECE_SETTINGS,
			ApplicationFacade.DISAPPEAR_PIECE_SETTINGS
		];
	}

	public override function handleNotification( n : INotification ) : void {
		switch( n.getName() ) {
			case ApplicationFacade.SET_FONT_SETTINGS:
				this.handleSetFontSettings( n.getBody() as PieceSettingsVO );
			break;
			case ApplicationFacade.APPEAR_PIECE_SETTINGS:
				this.handleAppearPieceSettings( n.getType() is String ? n.getType() as String : null );
			break;
			case ApplicationFacade.DISAPPEAR_PIECE_SETTINGS:
				this.handleDisappearPieceSettings();
			break;

		}
	}

	// End Notification Delegates


	// Start Notification Handlers

	private function handleSetFontSettings( settings : PieceSettingsVO ) : void {
		this.setPieceSettings( settings );
		this.refreshStyleEntries();
	}

	private function handleAppearPieceSettings( type : String ) : void {
		if ( type == NOTIFICATION_TYPE_INTERRUPT_APPEAR ) {
			return;
		}
		this.appear();
		this.refreshStyleEntries();
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
			if ( b.id == TARGET_ID_APPLY_CHANGES ) {
				this.applyChanges();
			}
		}
	}

	private function onChangeStyle( e : Event ) : void {

	}

	// End Event Handlers


	// Start Getter / Setters

	protected function get popup() : PieceSettingsDialog {
		return this._popup as PieceSettingsDialog;
	}

	// End Getter / Setters
}
}