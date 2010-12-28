package de.robinz.as3.pcc.chessboard.view
{
	import de.robinz.as3.pcc.chessboard.ApplicationFacade;
	import de.robinz.as3.pcc.chessboard.tests.ApplicationTest;
	import de.robinz.as3.pcc.chessboard.view.views.ApplicationView;
	import de.robinz.as3.pcc.chessboard.view.views.Chessboard;

	import flash.events.Event;
	import flash.events.MouseEvent;

	import flexunit.framework.TestSuite;

	import mx.controls.Button;
	import mx.core.Container;
	import mx.styles.CSSStyleDeclaration;
	import mx.styles.StyleManager;

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

		private var tempChessboardWidth : int;
		private var tempChessboardHeight : int;

		public function ApplicationMediator( m : mainapp ) {
			super( NAME, m );

			if ( UNIT_TESTS ) {
				chessboard.visible = false;
				chessboard.includeInLayout = false;

				view.testRunner.test = createSuite();
				view.testRunner.startTest();
			}

			this.tempChessboardWidth = this.view.chessboard.width;
			this.tempChessboardHeight = this.view.chessboard.height;

			//m.addEventListener( MouseEvent.CLICK, onMouseClick );
		}


		// Start Innerclass Methods

/* 		private function onMouseClick( e : MouseEvent ) : void {
			if ( e.target is Button ) {
				var button : Button = e.target as Button;
				if ( button.id == "value1Button" ) {
					sendNotification( ApplicationFacade.CHANGE_PIECE_STYLE, this.view.value1.text );
				}
			}
		} */

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

		private function toogleMoveHistoryPanel( actived : Boolean ) : void {
			if ( actived && this.view.chessboardTakenPieces.visible == false ) {
				this.view.chessboardMoveHistory.percentHeight = 100;
			}
			// TODO: refactoring
			if ( actived && this.view.leftPanelContainer.visible == false ) {
				this.view.chessboard.percentWidth = 100;
				this.view.chessboard.percentHeight = 100;
				this.view.leftPanelContainer.visible = true;
				this.view.leftPanelContainer.includeInLayout = true;
			}
			if ( !actived && !this.view.chessboardTakenPieces.visible ) {
				this.view.chessboard.width = this.tempChessboardWidth;
				this.view.chessboard.height = this.tempChessboardHeight;
				this.view.leftPanelContainer.visible = false;
				this.view.leftPanelContainer.includeInLayout = false;
			}
		}

		private function toogleTakenPiecesPanel( actived : Boolean ) : void {
			if ( actived && this.view.chessboardMoveHistory.percentHeight == 100 ) {
				this.view.chessboardMoveHistory.percentHeight = 65;
			}
			if ( !actived && this.view.chessboardMoveHistory.percentHeight == 65 ) {
				this.view.chessboardMoveHistory.percentHeight = 100;
			}
			// TODO: refactoring
			if ( actived && this.view.leftPanelContainer.visible == false ) {
				this.view.chessboard.percentWidth = 100;
				this.view.chessboard.percentHeight = 100;
				this.view.leftPanelContainer.visible = true;
				this.view.leftPanelContainer.includeInLayout = true;
			}
			if ( !actived && !this.view.chessboardMoveHistory.visible ) {
				this.view.chessboard.width = this.tempChessboardWidth;
				this.view.chessboard.height = this.tempChessboardHeight;
				this.view.leftPanelContainer.visible = false;
				this.view.leftPanelContainer.includeInLayout = false;
			}
		}

		// End Innerclass Methods


		// Start Notification Delegates

		public override function listNotificationInterests() : Array {
			return [
				ApplicationFacade.TOGGLE_MOVE_HISTORY_PANEL,
				ApplicationFacade.TOGGLE_TAKEN_PIECES_PANEL,
				ApplicationFacade.APPEAR_MOVE_HISTORY_PANEL,
				ApplicationFacade.DISAPPEAR_MOVE_HISTORY_PANEL,
				ApplicationFacade.APPEAR_TAKEN_PIECES_PANEL,
				ApplicationFacade.DISAPPEAR_TAKEN_PIECES_PANEL
			];
		}

		public override function handleNotification( n : INotification ) : void {
			switch( n.getName() ) {
				case ApplicationFacade.TOGGLE_MOVE_HISTORY_PANEL:
					this.handleToggleMoveHistoryPanel();
				break;
				case ApplicationFacade.TOGGLE_TAKEN_PIECES_PANEL:
					this.handleToggleTakenPiecesPanel();
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

		private function handleToggleMoveHistoryPanel() : void {
			var actived : Boolean = this.toggleContainer( this.view.chessboardMoveHistory );
			if ( actived ) {
				sendNotification( ApplicationFacade.APPEAR_MOVE_HISTORY_PANEL );
			} else {
				sendNotification( ApplicationFacade.DISAPPEAR_MOVE_HISTORY_PANEL );
			}
		}

		private function handleToggleTakenPiecesPanel() : void {
			var actived : Boolean = this.toggleContainer( this.view.chessboardTakenPieces );
			if ( actived ) {
				sendNotification( ApplicationFacade.APPEAR_TAKEN_PIECES_PANEL );
			} else {
				sendNotification( ApplicationFacade.DISAPPEAR_TAKEN_PIECES_PANEL );
			}
		}

		private function handleAppearMoveHistoryPanel() : void {
			this.toogleMoveHistoryPanel( true );
		}
		private function handleDisappearMoveHistoryPanel() : void {
			this.toogleMoveHistoryPanel( false );
		}
		private function handleAppearTakenPiecesPanel() : void {
			this.toogleTakenPiecesPanel( true );
		}
		private function handleDisappearTakenPiecesPanel() : void {
			this.toogleTakenPiecesPanel( false );
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