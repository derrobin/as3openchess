package de.robinz.as3.pcc.chessboard.view
{
	import de.robinz.as3.pcc.chessboard.library.BoardNotation;
	import de.robinz.as3.pcc.chessboard.library.IBoardPiece;
	import de.robinz.as3.pcc.chessboard.view.views.Chessboard;

	import flash.events.Event;
	import flash.events.MouseEvent;

	import mx.containers.Box;
	import mx.containers.HBox;
	import mx.containers.VBox;
	import mx.controls.Text;
	import mx.core.DragSource;
	import mx.events.DragEvent;
	import mx.managers.DragManager;

	import org.puremvc.as3.patterns.mediator.Mediator;

	/**
	 * Chessboard Mediator
	 *
	 * @author Robin Heinel
	 *
	 */
	public class ChessboardMediator extends Mediator
	{
		public static const NAME : String = "ChessboardMediator";

		public function ChessboardMediator( viewComponent : Chessboard ) {
			super( NAME, viewComponent );

			viewComponent.addEventListener( MouseEvent.CLICK, onMouseClick, true );
			viewComponent.addEventListener( MouseEvent.MOUSE_OVER, onMouseOver, true );
			viewComponent.addEventListener( DragEvent.DRAG_ENTER, onDragEnter, true );
			viewComponent.addEventListener( DragEvent.DRAG_DROP, onDragDrop, true );
			viewComponent.addEventListener( MouseEvent.MOUSE_MOVE, onMouseMove, true );
		}

		private function onMouseMove( e : MouseEvent ) : void {
			if ( e.target is Text ) {
				var di : Text = Text( e.target );
				var ds : DragSource = new DragSource();

				ds.addData( di, "piece" );

				DragManager.doDrag( di, ds, e, null );
			}

		}

		private function onDragEnter( e : DragEvent ) : void {
			if ( e.dragSource.hasFormat( "piece" ) ) {
				if ( e.target is Box ) {
					DragManager.acceptDragDrop( Box( e.target ) );
				}
				if ( e.currentTarget is Box ) {
					DragManager.acceptDragDrop( Box( e.currentTarget ) );
				}
			}

		}

		private function onDragDrop( e : DragEvent ) : void {
			var b : Box = Box( e.target );
			var t : Text = Text( e.dragInitiator );

			//b = ( t.parent as Box ).removeChild( b );
			b.addChild( t );
			// ..
			// Text( e.dragInitiator ).x = Box( e.target ).mouseX;
			// Text( e.dragInitiator ).y = Box( e.target ).mouseY;
		}

		private function onMouseOver( e : Event ) : void {
			if ( e.target is Box && !( e.target is HBox ) && !( e.target is VBox ) ) {
				chessboard.info1.text = ( e.target as Box ).id;
			}
		}

		private function onMouseClick( e : Event ) : void {
			if ( e.target is Text ) {
				var t : Text = ( e.target as Text );
				var box : Box = t.parent as Box;
				chessboard.info2.text = "You clicked on a Piece with the FontKey [" + ( e.target as Text ).text + "] and the Notation [" + box.id + "]";
			}
		}

		public function setPiece( p : IBoardPiece, n : BoardNotation ) : void {
			var field : Box = this.chessboard[ n.row + n.column ] as Box;
			( field.getChildAt( 0 ) as Text ).text = p.fontKey;
		}

		private function get chessboard() : Chessboard {
			return this.viewComponent as Chessboard;
		}

	}
}