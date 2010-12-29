package de.robinz.as3.pcc.chessboard.view
{
	import de.robinz.as3.pcc.chessboard.ApplicationFacade;
	import de.robinz.as3.pcc.chessboard.library.vo.PanelVO;
	import de.robinz.as3.pcc.chessboard.library.vo.PanelVOCollection;
	import de.robinz.as3.pcc.chessboard.tests.ApplicationTest;
	import de.robinz.as3.pcc.chessboard.view.views.ApplicationView;
	import de.robinz.as3.pcc.chessboard.view.views.Chessboard;

	import flash.events.Event;

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
	public class ApplicationMediator extends Mediator
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
		}

		private function registerPanels() : PanelVOCollection {
			var c : PanelVOCollection = new PanelVOCollection();
			c.add( PanelVO.createByParams( this.view.chessboardMoveHistory, 65, 100 ) );
			c.add( PanelVO.createByParams( this.view.chessboardTakenPieces, 35, 35 ) );
			return c;
		}

		private function showMoveHistory() : void {
			this.showPanel( this.view.chessboardMoveHistory );
		}
		private function hideMoveHistory() : void {
			this.hidePanel( this.view.chessboardMoveHistory );
		}
		private function showTakenPieces() : void {
			this.showPanel( this.view.chessboardTakenPieces );
		}
		private function hideTakenPieces() : void {
			this.hidePanel( this.view.chessboardTakenPieces );
		}

		private function hidePanel( panel : Panel ) : void {
			this.switchPanel( panel, false );
		}
		private function showPanel( panel : Panel ) : void {
			this.switchPanel( panel, true );
		}

		private function switchLeftContainer() : void {
			if ( this.isVisibleLeftPanels() ) {
				this.switchContainer( this.view.leftPanelContainer, true );
				return;
			}
			this.switchContainer( this.view.leftPanelContainer, false );
		}

		private function isVisibleLeftPanels() : Boolean {
			var p : PanelVO;
			for each( p in this._panels.list ) {
				if ( p.visible == true ) {
					return true;
				}
			}
			return false;
		}

		private function managePanelSizes() : void {
			var avs : int = 100; // availible space in percent
			var p : PanelVO;

			// TODO: refactor this later, this is should be common layout managing?
			var mh : PanelVO = this._panels.getByPanel( this.view.chessboardMoveHistory );
			var tp : PanelVO = this._panels.getByPanel( this.view.chessboardTakenPieces );

			var mhh : int = mh.visible == true ? mh.maxHeight : 0; // move history height
			var tph : int = tp.visible == true ? tp.maxHeight : 0; // taken pieces height

			if ( ( mhh + tph ) <= 100 ) {
				this.assignPanelSizes( mhh, tph );
				return;
			}

			mhh = mh.minHeight;

			if ( ( mhh + tph ) <= 100 ) {
				this.assignPanelSizes( mhh, tph );
				return;
			}

			tph = mh.minHeight;

			if ( ( mhh + tph ) <= 100 ) {
				this.assignPanelSizes( mhh, tph );
				return;
			}

			throw new Error( "Case not implemented!" );
		}

		private function assignPanelSizes( mhh : int, tph : int ) : void {
			this.view.chessboardMoveHistory.percentHeight = mhh;
			this.view.chessboardTakenPieces.percentHeight = tph;
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
				ApplicationFacade.APPEAR_MOVE_HISTORY_PANEL,
				ApplicationFacade.DISAPPEAR_MOVE_HISTORY_PANEL,
				ApplicationFacade.APPEAR_TAKEN_PIECES_PANEL,
				ApplicationFacade.DISAPPEAR_TAKEN_PIECES_PANEL
			];
		}

		public override function handleNotification( n : INotification ) : void {
			switch( n.getName() ) {
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

		private function handleAppearMoveHistoryPanel() : void {
			this.showMoveHistory();
			/* this.view.leftPanelContainer.visible = true;
			this.view.leftPanelContainer.includeInLayout = true;
			this.view.chessboardMoveHistory.visible = true;
			this.view.chessboardMoveHistory.includeInLayout = true; */
			//this.toogleMoveHistoryPanel( true );
		}
		private function handleDisappearMoveHistoryPanel() : void {
			this.hideMoveHistory();

			/* this.view.leftPanelContainer.visible = false;
			this.view.leftPanelContainer.includeInLayout = false;
			this.view.chessboardMoveHistory.visible = false;
			this.view.chessboardMoveHistory.includeInLayout = false; */
			//this.toogleMoveHistoryPanel( false );
		}
		private function handleAppearTakenPiecesPanel() : void {
			this.showTakenPieces();
			//this.toogleTakenPiecesPanel( true );
		}
		private function handleDisappearTakenPiecesPanel() : void {
			this.hideTakenPieces();
			//this.toogleTakenPiecesPanel( false );
		}


		// End Notification Handlers


		// Start Event Handlers

		private function onCreationComplete( e : Event ) : void {

		}

		// End Event Handlers


		// Start Getter / Setters

		protected function get chessboard() : Chessboard {
			return this.view.chessboard;
		}
		protected function get view() : ApplicationView {
			return this.app.applicationView;
		}
		public function get app() : mainapp {
			return this.viewComponent as mainapp;
		}

		// End Getter / Setters
	}
}