package de.robinz.as3.pcc.chessboard.view
{
import de.robinz.as3.pcc.chessboard.ApplicationFacade;
import de.robinz.as3.pcc.chessboard.library.vo.PanelVO;
import de.robinz.as3.pcc.chessboard.library.vo.PanelVOCollection;
import de.robinz.as3.pcc.chessboard.tests.ApplicationTest;
import de.robinz.as3.pcc.chessboard.view.views.ApplicationView;
import de.robinz.as3.pcc.chessboard.view.views.Chessboard;

import flash.events.Event;

import flash.events.MouseEvent;

import flexunit.framework.TestSuite;

import mx.containers.Panel;
import mx.core.Container;

import org.puremvc.as3.interfaces.INotification;
import org.puremvc.as3.patterns.mediator.Mediator;

/**
 * ApplicationMediator
 *
 * @author robin heinel
 */
public class ApplicationMediator extends BaseMediator
{
	public static const UNIT_TESTS : Boolean = false;
	public static const NAME : String = "ApplicationMediator";

	private var _panels : PanelVOCollection;


	public function ApplicationMediator( m : mainapp ) {
		super( NAME, m );

		if ( UNIT_TESTS ) {
			chessboard.visible = false;
			chessboard.includeInLayout = false;

			view.testRunner.test = createSuite();
			view.testRunner.startTest();
		}

		this._panels = this.registerPanels();
		this.setDefaultPanelSize();
	}


	// Start Innerclass Methods

	private function setDefaultPanelSize() : void {
		this.view.chessboardMoveHistory.percentHeight = this._panels.getAt( 0 ).minHeight;
		this.view.chessboardTakenPieces.percentHeight = this._panels.getAt( 1 ).minHeight;
		this.view.chessboardGameActions.percentHeight = this._panels.getAt( 2 ).minHeight;
	}

	private function registerPanels() : PanelVOCollection {
		var c : PanelVOCollection = new PanelVOCollection();
		c.add( PanelVO.createByParams( this.view.chessboardMoveHistory, 65, 100 ) );
		c.add( PanelVO.createByParams( this.view.chessboardTakenPieces, 35, 35 ) );
		c.add( PanelVO.createByParams( this.view.chessboardGameActions, 15, 15 ) );
		return c;
	}

	private function hidePanel( panel : Panel ) : void {
		this.switchPanel( panel, false );
	}
	private function showPanel( panel : Panel ) : void {
		this.switchPanel( panel, true );
	}

	private function switchLeftContainer() : void {
		if ( this._panels.isVisiblePanels() ) {
			this.switchContainer( this.view.leftPanelContainer, true );
			return;
		}
		this.switchContainer( this.view.leftPanelContainer, false );
	}

	private function managePanelSizes() : void {
		var avs : int = 100; // availible space in percent
		var visiblePanels : PanelVOCollection = this._panels.getVisiblePanels();

		var p : PanelVO;
		var avg : int = Math.ceil( 100 / visiblePanels.length ); // average
		var value : int;
		var space : int = 100;

		for each( p in visiblePanels.list ) {
			value = p.minHeight;
			space = space - value;
			p.panel.percentHeight = value;
		}

		if ( space > 0 ) {
			var diff : int;
			for each( p in visiblePanels.list ) {
				diff = p.maxHeight - p.minHeight;
				if ( space >= diff ) {
					p.panel.percentHeight = p.maxHeight;
					space = space - diff;
					continue;
				}
				// TODO: add maxHeight to calculcation
				if ( space > 0 ) {
					p.panel.percentHeight = p.panel.percentHeight + space;
				}
			}
		}
	}

	private function switchPanel( panel : Panel, visible : Boolean = true ) : void {
		var vo : PanelVO = this._panels.getByPanel( panel );
		vo.visible = visible;

		this.switchContainer( panel, visible );
		this.managePanelSizes();
		this.switchLeftContainer();
	}

	private function switchContainer( c : Container, visible : Boolean = true ) : void {
		c.visible = visible;
		c.includeInLayout = visible;
	}

	private function createSuite() : TestSuite {
		var ts:TestSuite = new TestSuite();
		ts.addTest( ApplicationTest.suite() );
		return ts;
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