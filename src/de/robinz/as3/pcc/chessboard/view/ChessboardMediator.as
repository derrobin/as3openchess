package de.robinz.as3.pcc.chessboard.view
{
import de.robinz.as3.pcc.chessboard.ApplicationFacade;
import de.robinz.as3.pcc.chessboard.library.Notation;
import de.robinz.as3.pcc.chessboard.library.FontManager;
import de.robinz.as3.pcc.chessboard.library.ChessboardMove;
import de.robinz.as3.pcc.chessboard.library.pieces.IPiece;
import de.robinz.as3.pcc.chessboard.library.vo.ChessboardFieldVO;
import de.robinz.as3.pcc.chessboard.library.vo.PieceSettingsVO;
import de.robinz.as3.pcc.chessboard.view.views.Chessboard;
import de.robinz.as3.pcc.chessboard.view.views.chessboard.ChessboardField;
import de.robinz.as3.pcc.chessboard.view.views.chessboard.ChessboardFieldCollection;
import de.robinz.as3.pcc.chessboard.view.views.chessboard.ChessboardFieldCollection;

import flash.display.DisplayObject;
import flash.display.DisplayObjectContainer;
import flash.events.Event;
import flash.events.MouseEvent;

import mx.collections.ArrayCollection;
import mx.containers.Box;
import mx.controls.Alert;
import mx.controls.Spacer;
import mx.controls.Text;
import mx.core.Container;
import mx.core.DragSource;
import mx.events.DragEvent;
import mx.managers.DragManager;

import org.puremvc.as3.interfaces.INotification;
import org.puremvc.as3.patterns.mediator.Mediator;

/**
 * Chessboard Mediator
 *
 * @author robin heinel
 */
public class ChessboardMediator extends Mediator
{
	public static const NAME : String = "ChessboardMediator";

	public static const FIELD_SPACE : int = 1;

	public static const CSS_SELECTOR_FIELD_WHITE : String = "fieldWhite";
	public static const CSS_SELECTOR_FIELD_BLACK : String = "fieldBlack";
	public static const CSS_SELECTOR_FIELD_MOVE_HINT : String = "fieldMoveHint";

	private var _isBoardInspectMode : Boolean = false;
	private var _isBoardLocked : Boolean = false;
	private var _pieceSettings : PieceSettingsVO;

	public function ChessboardMediator( viewComponent : Chessboard ) {
		super( NAME, viewComponent );

		viewComponent.addEventListener( MouseEvent.CLICK, onMouseClick, true );
		//viewComponent.addEventListener( MouseEvent.MOUSE_OVER, onMouseOver, true );
		viewComponent.addEventListener( DragEvent.DRAG_ENTER, onDragEnter, true );
		viewComponent.addEventListener( DragEvent.DRAG_DROP, onDragDrop, true );
		viewComponent.addEventListener( MouseEvent.MOUSE_MOVE, onMouseMove, true );

		this.createFields();
	}


	// Start Innerclass Methods
	private function createFields() : void {
		var spacer : Spacer;
		var field : ChessboardField;

		var rows : String = "abcdefgh";
		var c : String; // char
		var container : Container;
		var i : int = 1;
		var j : int = 1;
		var notation : String;
		var isWhite : Boolean = true;

		for( j; j <= 8; j++ ) {
			isWhite = isWhite ? false : true;

			for( i; i <= rows.length; i++ ) {
				c = rows.charAt( i - 1 );
				notation = c + j.toString();
				field = this.createField( notation, isWhite );

				container = this.chessboard[ "row" + j ] as Container;
				container.addChild( this.createFieldSpacer( FIELD_SPACE ) );
				container.addChild( field );

				isWhite = isWhite ? false : true;
			}

			container.addChild( this.createFieldSpacer( FIELD_SPACE ) );
			i = 1;
		}
	}

	private function createFieldSpacer( width : int ) : Spacer {
		var s : Spacer = new Spacer();
		s.width = width;
		return s;
	}

	private function createField( notation : String, isWhite : Boolean ) : ChessboardField {
		var f : ChessboardField = new ChessboardField();
		f.id = notation;
		f.percentWidth = 12.5;
		f.percentHeight = 100;
		f.styleName = "field" + ( isWhite ? "White" : "Black" );

		var vo : ChessboardFieldVO = new ChessboardFieldVO();
		vo.isWhite = isWhite;
		f.data = vo;

		return f;
	}

	private function removePieceByNotation( n : Notation ) : Boolean {
		try {
			var field : ChessboardField = this.getField( n.toString() );
			field.removeAllChildren();
		} catch( e : Error ) {
			sendNotification( ApplicationFacade.ERROR, e );
			return false;
		}

		return true;
	}

	private function getFields() : ChessboardFieldCollection {
		var list : Array = new Array().concat(
			this.chessboard[ 'row1' ].getChildren(),
			this.chessboard[ 'row2' ].getChildren(),
			this.chessboard[ 'row3' ].getChildren(),
			this.chessboard[ 'row4' ].getChildren(),
			this.chessboard[ 'row5' ].getChildren(),
			this.chessboard[ 'row6' ].getChildren(),
			this.chessboard[ 'row7' ].getChildren(),
			this.chessboard[ 'row8' ].getChildren()
		);
		var o : Object;
		var c : ChessboardFieldCollection = new ChessboardFieldCollection();
		for each( o in list ) {
			if ( o is ChessboardField ) {
				c.add( o );
			}
		}

		return c;
	}

	// TODO: performance refactoring: use dictionary for indexing
	private function getField( notation : String ) : ChessboardField {
		var fields : ChessboardFieldCollection = this.getFields();
		var field : ChessboardField;
		for each( field in fields.list ) {
			if ( field.id == notation ) {
				return field;
			}
		}

		return null;
	}

	private function removeAllPieces() : void {
		var fields : ChessboardFieldCollection = this.getFields();
		var child : Object;
		var b : Box;

		for each( child in fields.list ) {
			if ( !( child is Box ) ) {
				continue;
			}

			b = child as Box;

			if ( b.styleName != CSS_SELECTOR_FIELD_BLACK && b.styleName != CSS_SELECTOR_FIELD_WHITE ) {
				continue;
			}

			b.removeAllChildren();
		}
	}

	private function getPieceAt( n : Notation ) : IPiece {
		var p : IPiece = null;

		try {
			var field : Box = this.getField( n.toString() );
			var text : Text = field.getChildAt( 0 ) as Text;
			p = text.data as IPiece;
		} catch ( e : Error ) {
			// No Piece found
			return null;
		}

		return p;
	}

	/**
	 *
	 * @return List of mx.controls.Text
	 *
	 */
	private function getCurrentPieceWrappers() : ArrayCollection {
		var fields : ChessboardFieldCollection = this.getFields();
		var field : ChessboardField;
		var list : ArrayCollection = new ArrayCollection();
		var text : Text;

		for each( field in fields.list ) {
			if ( ! field.hasPiece() ) {
				continue;
			}

			text = field.getText();
			list.addItem( text );
		}

		return list;
	}

	private function refreshPieces() : void {
		var wl : ArrayCollection = getCurrentPieceWrappers(); // wrapper list
		var piece : IPiece;
		var notation : Notation;
		var c : DisplayObjectContainer;
		var d : DisplayObject;
		var field : ChessboardField;

		for each( var t : Text in wl ) {
			piece = t.data as IPiece;
			field = t.parent as ChessboardField;
			notation = Notation.createNotationByString( field.id );
			t.parent.removeChild( t );

			this.setPiece( piece, notation );
		}
	}

	private function setPiece( p : IPiece, n : Notation ) : void {
		var field : Container = this.getField( n.toString() ) as Container;
		var text : Text = new Text();

		text.mouseChildren = false;
		text.text = p.fontKey;
		text.data = p;

		field.addChild( text );
	}

	private function markMoveHint( notation : String ) : void {
		var f : ChessboardField = this.getField( notation );

		if ( f == null ) {
			return;
		}

		f.styleName = CSS_SELECTOR_FIELD_MOVE_HINT;
		// dynamic font size, depends from piece settings
		f.setStyle( "fontSize", this._pieceSettings.fontSizeCssValue );

		this.refreshPieces();
	}

	private function removeAllMoveHints() : void {
		var c : ChessboardFieldCollection = this.getFields();
		var f : ChessboardField;
		var vo : ChessboardFieldVO;

		for each( f in c.list ) {
			if ( ! f.styleName == CSS_SELECTOR_FIELD_MOVE_HINT ) {
				continue;
			}

			vo = f.data as ChessboardFieldVO;
			f.styleName = vo.isWhite ? CSS_SELECTOR_FIELD_WHITE : CSS_SELECTOR_FIELD_BLACK;
		}
	}

	// End Innerclass Methods


	// Start Notification Delegates

	public override function listNotificationInterests() : Array {
		return [
			ApplicationFacade.FIELD_HINT,
			ApplicationFacade.REMOVE_ALL_FIELD_HINTS,
			ApplicationFacade.LOCK_BOARD,
			ApplicationFacade.UNLOCK_BOARD,
			ApplicationFacade.CHANGE_PIECE_SETTINGS,
			ApplicationFacade.ENABLE_BOARD_INSPECT_PIECE_MODE,
			ApplicationFacade.DISABLE_BOARD_INSPECT_PIECE_MODE,
			ApplicationFacade.REMOVE_PIECE,
			ApplicationFacade.REMOVE_ALL_PIECES,
			ApplicationFacade.SET_PIECE,
			ApplicationFacade.MOVE
		];
	}

	public override function handleNotification( n : INotification ) : void {
		switch( n.getName() ) {
			case ApplicationFacade.FIELD_HINT:
				this.handleFieldHint( n.getBody() as String );
			break;
			case ApplicationFacade.REMOVE_ALL_FIELD_HINTS:
				this.handleRemoveAllFieldHints();
			break;
			case ApplicationFacade.LOCK_BOARD:
				this.handleLookBoard();
			break;
			case ApplicationFacade.UNLOCK_BOARD:
				this.handleUnlockBoard();
			break;
			case ApplicationFacade.CHANGE_PIECE_SETTINGS:
				this.handleChangePieceSettings( n.getBody() as PieceSettingsVO );
			break;
			case ApplicationFacade.ENABLE_BOARD_INSPECT_PIECE_MODE:
				this.handleEnableBoardInspectMode();
			break;
			case ApplicationFacade.DISABLE_BOARD_INSPECT_PIECE_MODE:
				this.handleDisableBoardInspectMode();
			break;
			case ApplicationFacade.REMOVE_PIECE:
				this.handleRemovePiece( n.getBody() as ChessboardMove );
			break;
			case ApplicationFacade.REMOVE_ALL_PIECES:
				this.handleRemoveAllPieces();
			break;
			case ApplicationFacade.SET_PIECE:
				this.handleSetPiece( n.getBody() as ChessboardMove );
			break;
			case ApplicationFacade.MOVE:
				this.handleMove( n.getBody() as ChessboardMove );
			break;
		}
	}

	// End Notification Delegates


	// Start Notification Handlers

	private function handleFieldHint( notation : String ) : void {
		this.markMoveHint( notation );
	}

	private function handleRemoveAllFieldHints() : void {
		this.removeAllMoveHints();
	}

	private function handleLookBoard() : void {
		this._isBoardLocked = true;
	}

	private function handleUnlockBoard() : void {
		this._isBoardLocked = false;
	}

	private function handleChangePieceSettings( settings : PieceSettingsVO ) : void {
		// TODO: make condition to internal state
		this._pieceSettings = settings;
		this.refreshPieces();
	}

	private function handleEnableBoardInspectMode() : void {
		this._isBoardInspectMode = true;
	}

	private function handleDisableBoardInspectMode() : void {
		this._isBoardInspectMode = false;
	}

	private function handleRemovePiece( m : ChessboardMove ) : void {
		if ( this.removePieceByNotation( m.toPosition ) ) {
			sendNotification( ApplicationFacade.PIECE_REMOVED, m );
		}
	}

	private function handleRemoveAllPieces() : void {
		this.removeAllPieces();
	}

	private function handleSetPiece( m : ChessboardMove ) : void {
		var n : Notation = m.toPosition;
		var p : IPiece = m.piece;

		this.setPiece( p, n );
	}

	private function handleMove( m : ChessboardMove ) : void {
		var fromBox : Box = this.getField( m.fromPosition.toString() );
		var fromText : Text = fromBox.getChildAt( 0 ) as Text;
		var toBox : Box = this.getField( m.toPosition.toString() );

		toBox.addChild( fromText );
	}

	// End Notification Handlers


	// Start Event Handlers

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
			if ( e.target is ChessboardField ) {
				DragManager.acceptDragDrop( ChessboardField( e.target ) );
			}
		}

	}

	private function onDragDrop( e : DragEvent ) : void {
		if ( this._isBoardLocked ) {
			Alert.show( "All Movements are looked. You have to go to the end of the game for making the next move.", "Movement looked!" );
			return;
		}

		var tb : Box = Box( e.target ); // Target Box
		var fb : Box = Box( e.dragInitiator.parent ); // From Box

		var t : Text = Text( e.dragInitiator );
		var p : IPiece = t.data as IPiece;

		var fromPosition : Notation = Notation.createNotationByString( fb.id );
		var toPosition : Notation = Notation.createNotationByString( tb.id );

		var m : ChessboardMove = new ChessboardMove();
		m.fromPosition = fromPosition;
		m.toPosition = toPosition;
		m.piece = p;
		m.beatenPiece = this.getPieceAt( toPosition );

		sendNotification( ApplicationFacade.TRY_TO_MOVE, m );
	}

	/* private function onMouseOver( e : Event ) : void {
		if ( e.target is Box && !( e.target is HBox ) && !( e.target is VBox ) ) {
		}
	} */

	private function onMouseClick( e : Event ) : void {
		if ( this._isBoardLocked ) {
			Alert.show( "All Movements are looked. You have to go to the end of the game for making the next move.", "Movement looked!" );
			return;
		}

		if ( e.target is Text ) {
			var t : Text = ( e.target as Text );
			var box : Box = t.parent as Box;

			if ( _isBoardInspectMode ) {
				var piece : IPiece = t.data as IPiece;
				Alert.show(
					"Piece Name: " + piece.getName() + "\n" +
					"Piece FontKey: " + piece.fontKey
				, "Piece Inspection" );
			}
		}
	}

	// End Event Handlers


	// Start Getter / Setters

	private function get chessboard() : Chessboard {
		return this.viewComponent as Chessboard;
	}

	// End Getter / Setters
}
}