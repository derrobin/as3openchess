package de.robinz.as3.pcc.chessboard.view
{
	import de.robinz.as3.pcc.chessboard.ApplicationFacade;
	import de.robinz.as3.pcc.chessboard.library.Notation;
	import de.robinz.as3.pcc.chessboard.library.managers.FontManager;
	import de.robinz.as3.pcc.chessboard.library.notation.ChessboardMove;
	import de.robinz.as3.pcc.chessboard.library.pieces.IPiece;
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

	import org.puremvc.as3.interfaces.INotification;
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
				var piece : IPiece = di.data as IPiece;

				if ( piece == null ) {
					return;
				}

				var fm : FontManager = FontManager.getInstance();
				var ds : DragSource = new DragSource();

				ds.addData( di, "piece" );

				DragManager.doDrag( di, ds, e/* , fm.convertTextToFlexImage( piece.fontKey ) */ );
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
			var tb : Box = Box( e.target ); // Target Box
			var fb : Box = Box( e.dragInitiator.parent ); // From Box

			var t : Text = Text( e.dragInitiator );
			var p : IPiece = t.data as IPiece;
			//b = ( t.parent as Box ).removeChild( b );

			var fromPosition : Notation = Notation.createNotationByString( fb.id );
			var toPosition : Notation = Notation.createNotationByString( tb.id );
			//n.column

			var m : ChessboardMove = new ChessboardMove();
			m.fromPosition = fromPosition;
			m.toPosition = toPosition;
			m.piece = p;

			sendNotification( ApplicationFacade.TRY_TO_MOVE, m );

			/*
			var targetField : Box = this.getFieldAt( toPosition );

			tb.addChild( t );
			*/


			// ..
			// Text( e.dragInitiator ).x = Box( e.target ).mouseX;
			// Text( e.dragInitiator ).y = Box( e.target ).mouseY;
		}

		private function onMouseOver( e : Event ) : void {
			if ( e.target is Box && !( e.target is HBox ) && !( e.target is VBox ) ) {
				//chessboard.info1.text = ( e.target as Box ).id;
			}
		}

		private function onMouseClick( e : Event ) : void {
			if ( e.target is Text ) {
				var t : Text = ( e.target as Text );
				var box : Box = t.parent as Box;
				//chessboard.info2.text = "You clicked on a Piece with the FontKey [" + ( e.target as Text ).text + "] and the Notation [" + box.id + "]";
			}
		}

		private function getFieldAt( n : Notation ) : Box {
			try {
				var b : Box = this.chessboard[ n.toString() ] as Box;
				return b;
			} catch( e : Error ) {
				trace( e.getStackTrace() );
			}
			return null;
		}

		public function removePieceFromNotation( n : Notation ) : Boolean {
			try {
				var field : Box = this.chessboard[ n.row + n.column ] as Box;
				field.removeAllChildren();
			} catch( e : Error ) {
				// TODO: Logging
				trace("ERROR:removePieceFromPosition()!");
				return false;
			}

			return true;
		}

		private function getRowChildren() : Array {
			return new Array().concat(
				this.chessboard.row1.getChildren(),
				this.chessboard.row2.getChildren(),
				this.chessboard.row3.getChildren(),
				this.chessboard.row4.getChildren(),
				this.chessboard.row5.getChildren(),
				this.chessboard.row6.getChildren(),
				this.chessboard.row7.getChildren(),
				this.chessboard.row8.getChildren()
			);
		}

		public function removeAllPieces() : void {
			var childs : Array = this.getRowChildren();
			var child : Object;
			var b : Box;

			for each( child in childs ) {
				if ( !( child is Box ) ) {
					continue;
				}

				b = child as Box;

				if ( b.styleName != "fieldBlack" && b.styleName != "fieldWhite" ) {
					continue;
				}

				b.removeAllChildren();
			}
		}

		public function getPieceAt( n : Notation ) : IPiece {
			var p : IPiece = null;

			try {
				var field : Box = this.getFieldAt( n );
				var text : Text = field.getChildAt( 0 ) as Text;
				p = text.data as IPiece;
			} catch ( e : Error ) {
				// TODO: logging
				trace("ERROR:getPieceAt()");
			}

			return p;
		}

		public function setPiece( p : IPiece, n : Notation ) : void {
			var field : Box = this.chessboard[ n.row + n.column ] as Box;
			var text : Text = new Text();

			text.mouseChildren = false;
			text.text = p.fontKey;
			text.data = p;

			field.addChild( text );
		}

		public override function listNotificationInterests() : Array {
			return [
				ApplicationFacade.MOVE
			];
		}

		public override function handleNotification( n : INotification ) : void {
			switch( n.getName() ) {
				case ApplicationFacade.MOVE:
					this.handleMove( n.getBody() as ChessboardMove );
				break;
			}
		}

		private function handleMove( m : ChessboardMove ) : void {
			var fromBox : Box = this.getFieldAt( m.fromPosition );
			var fromText : Text = fromBox.getChildAt( 0 ) as Text;
			var toBox : Box = this.getFieldAt( m.toPosition );

			toBox.addChild( fromText );
		}

		private function get chessboard() : Chessboard {
			return this.viewComponent as Chessboard;
		}

	}
}