package de.robinz.as3.pcc.chessboard.view
{
import de.robinz.as3.pcc.chessboard.ApplicationFacade;
import de.robinz.as3.pcc.chessboard.library.vo.PanelVO;
import de.robinz.as3.pcc.chessboard.library.vo.PanelVOCollection;
import de.robinz.as3.pcc.chessboard.view.views.ApplicationView;
import de.robinz.as3.pcc.chessboard.view.views.Chessboard;

import flash.events.Event;

import mx.containers.Panel;
import mx.core.Container;

import org.puremvc.as3.interfaces.INotification;

/**
 * ApplicationMediator
 *
 * @author robin heinel
 */
public class ApplicationMediator extends BaseMediator
{
	public static const NAME : String = "ApplicationMediator";

	private var _panels : PanelVOCollection;


	public function ApplicationMediator( m : mainapp ) {
		super( NAME, m );
		this.registerPanels();
	}


	// Start Innerclass Methods

	private function registerPanels() : void {
		this._panels = new PanelVOCollection();
		this._panels.add( PanelVO.createByParams( this.view.chessboardMoveHistory ) );
		this._panels.add( PanelVO.createByParams( this.view.chessboardTakenPieces ) );
		this._panels.add( PanelVO.createByParams( this.view.chessboardGameActions ) );
	}

	private function hidePanel( panel : Container ) : void {
		this.switchPanel( panel, false );
	}
	private function showPanel( c : Container ) : void {
		this.switchPanel( c, true );
	}


	private function switchPanel( panel : Container, visible : Boolean = true ) : void {
		var vo : PanelVO = this._panels.getByPanel( panel );
		vo.visible = visible;

		this.switchContainer( panel, visible );
	}

	private function switchContainer( c : Container, visible : Boolean = true ) : void {
		c.visible = visible;
		c.includeInLayout = visible;
	}

	private function toggleContainer( c : Container ) : Boolean {
		if ( c.visible ) {
			c.visible = false;
			c.includeInLayout = false;
			return false;
		}

		c.visible = true;
		c.includeInLayout = true;
		return true;
	}

	// End Innerclass Methods


	// Start Notification Delegates

	public override function listNotificationInterests() : Array {
		return [
			ApplicationFacade.APPEAR_GAME_ACTIONS_PANEL,
			ApplicationFacade.DISAPPEAR_GAME_ACTIONS_PANEL,
			ApplicationFacade.APPEAR_MOVE_HISTORY_PANEL,
			ApplicationFacade.DISAPPEAR_MOVE_HISTORY_PANEL,
			ApplicationFacade.APPEAR_TAKEN_PIECES_PANEL,
			ApplicationFacade.DISAPPEAR_TAKEN_PIECES_PANEL
		];
	}

	public override function handleNotification( n : INotification ) : void {
		switch( n.getName() ) {
			case ApplicationFacade.APPEAR_GAME_ACTIONS_PANEL:
				this.handleAppearGameActionsPanel();
			break;
			case ApplicationFacade.DISAPPEAR_GAME_ACTIONS_PANEL:
				this.handleDisappearGameActionsPanel();
			break;
			case ApplicationFacade.APPEAR_MOVE_HISTORY_PANEL:
				this.handleAppearMoveHistoryPanel();
			break;
			case ApplicationFacade.DISAPPEAR_MOVE_HISTORY_PANEL:
				this.handleDisappearMoveHistoryPanel();
			break;
			case ApplicationFacade.APPEAR_TAKEN_PIECES_PANEL:
				this.handleAppearTakenPiecesPanel();
			break;
			case ApplicationFacade.DISAPPEAR_TAKEN_PIECES_PANEL:
				this.handleDisappearTakenPiecesPanel();
			break;
		}
	}

	// End Notification Delegates


	// Start Notification Handlers

	private function handleAppearGameActionsPanel() : void {
		this.showPanel( this.view.chessboardGameActions );
	}
	private function handleDisappearGameActionsPanel() : void {
		this.hidePanel( this.view.chessboardGameActions );
	}
	private function handleAppearMoveHistoryPanel() : void {
		this.showPanel( this.view.chessboardMoveHistory );
	}
	private function handleDisappearMoveHistoryPanel() : void {
		this.hidePanel( this.view.chessboardMoveHistory );
	}
	private function handleAppearTakenPiecesPanel() : void {
		this.showPanel( this.view.chessboardTakenPieces );
	}
	private function handleDisappearTakenPiecesPanel() : void {
		this.hidePanel( this.view.chessboardTakenPieces );
	}


	// End Notification Handlers


	// Start Event Handlers

	private function onCreationComplete( e : Event ) : void {

	}

	// End Event Handlers


	// Start Getter / Setters

	protected function get chessboard() : Chessboard {
		return this.view[ 'chessboard' ];
	}
	protected function get view() : ApplicationView {
		return this.app[ 'applicationView' ];
	}
	public function get app() : mainapp {
		return this.viewComponent as mainapp;
	}

	// End Getter / Setters
}
}