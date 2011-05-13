package de.robinz.as3.pcc.chessboard.view
{
import de.robinz.as3.pcc.chessboard.ApplicationFacade;
import de.robinz.as3.pcc.chessboard.library.ChessPosition;
import de.robinz.as3.pcc.chessboard.library.ChessboardMove;
import de.robinz.as3.pcc.chessboard.library.ChessboardMoveCollection;
import de.robinz.as3.pcc.chessboard.library.ChessboardUtil;
import de.robinz.as3.pcc.chessboard.library.CssSelectors;
import de.robinz.as3.pcc.chessboard.library.FieldNotation;
import de.robinz.as3.pcc.chessboard.library.FontManager;
import de.robinz.as3.pcc.chessboard.library.pieces.IPiece;
import de.robinz.as3.pcc.chessboard.library.vo.ChessboardFieldVO;
import de.robinz.as3.pcc.chessboard.library.vo.ChessboardFieldVO;
import de.robinz.as3.pcc.chessboard.library.vo.ChessboardGameVO;
import de.robinz.as3.pcc.chessboard.library.vo.PieceSettingsVO;
import de.robinz.as3.pcc.chessboard.view.views.Chessboard;
import de.robinz.as3.pcc.chessboard.view.views.chessboard.ChessboardField;
import de.robinz.as3.pcc.chessboard.view.views.chessboard.ChessboardField;
import de.robinz.as3.pcc.chessboard.view.views.chessboard.ChessboardField;
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

/**
 * Chessboard Mediator
 *
 * @author robin heinel
 */
public class ChessboardMediator extends BaseMediator
{
	public static const NAME : String = "ChessboardMediator";

	public static const FIELD_SPACE : int = 1;

	public static const FIELD_COLOR_VALID_DROP : int = 0xFFF8C6;
	public static const FIELD_COLOR_MOVE_HINT : int = 0xccff99;
	public static const FIELD_COLOR_WHITE : int = 0xffffff;
	public static const FIELD_COLOR_BLACK : int = 0xbbbbbb;

	private var _game : ChessboardGameVO;
	private var _validMoves : ChessboardMoveCollection;

	private var _isBoardInspectMode : Boolean = false;
	private var _isBoardLocked : Boolean = false;
	private var _pieceSettings : PieceSettingsVO;
	private var _cachedFields : ChessboardFieldCollection;
	private var _hasMoveHints : Boolean = false;
	private var _hasValidDrop : Boolean = false;
	private var _dragMove : ChessboardMove;

	public function ChessboardMediator( viewComponent : Chessboard ) {
		super( NAME, viewComponent );

		viewComponent.addEventListener( MouseEvent.CLICK, onMouseClick, true );
		viewComponent.addEventListener( DragEvent.DRAG_ENTER, onDragEnter, true );
		viewComponent.addEventListener( DragEvent.DRAG_DROP, onDragDrop, true );
		viewComponent.addEventListener( DragEvent.DRAG_COMPLETE, onDragComplete, true );
		viewComponent.addEventListener( MouseEvent.MOUSE_MOVE, onMouseMove, true );
		viewComponent.addEventListener( MouseEvent.MOUSE_DOWN, onMouseDown, true );
		viewComponent.addEventListener( MouseEvent.MOUSE_UP, onMouseUp, true );

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

		// TODO: encapsulate this algorithm, mb use of ChessboardUtil.getNotationSequence()
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
		f.styleName = CssSelectors.BOARD_FIELD;
		f.setStyle( "backgroundColor", isWhite ? FIELD_COLOR_WHITE : FIELD_COLOR_BLACK );

		var vo : ChessboardFieldVO = new ChessboardFieldVO();
		vo.isWhite = isWhite;
		vo.notation = FieldNotation.createNotationByString( notation );
		f.data = vo;

		return f;
	}

	private function removePieceByNotation( n : FieldNotation ) : Boolean {
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
		if ( this._cachedFields != null ) {
			return this._cachedFields;
		}

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

		this._cachedFields = c;
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

			b.removeAllChildren();
		}
	}

	private function getPieceAt( n : FieldNotation ) : IPiece {
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
		var notation : FieldNotation;
		var c : DisplayObjectContainer;
		var d : DisplayObject;
		var field : ChessboardField;

		for each( var t : Text in wl ) {
			piece = t.data as IPiece;
			field = t.parent as ChessboardField;
			notation = FieldNotation.createNotationByString( field.id );
			t.parent.removeChild( t );

			this.setPiece( piece, notation );
		}
	}

	private function setPiece( p : IPiece, n : FieldNotation ) : void {
		var field : Container = this.getField( n.toString() ) as Container;
		var text : Text = new Text();

		text.mouseChildren = false;
		text.text = p.fontKey;
		text.data = p;

		field.addChild( text );
	}

	private function resetStyleForAllFields( resetStyle : *, styleProperty : String, isValidDrop : Boolean = false ) : void {
		var c : ChessboardFieldCollection = this.getFields();
		var f : ChessboardField;
		var vo : ChessboardFieldVO;
		var style : *;

		for each( f in c.list ) {
			vo = f.data as ChessboardFieldVO;
			style = f.getStyle( styleProperty ) as int;

			// log.debug( "resetStyleForAllFields: field: {0} / property: {1} / style: {2}", f.id, styleProperty, style.toString() );
			if ( style != resetStyle ) {
				continue;
			}
			if ( isValidDrop && this._validMoves != null && this._validMoves.hasNotationToPosition( vo.notation.toString() ) ) {
				// log.debug( "resetStyleForAllFields: set move hint to {0} at {1}", f.id, vo.notation.toString() );
				f.setStyle( styleProperty, FIELD_COLOR_MOVE_HINT );
				continue;
			}

			f.setStyle( styleProperty, vo.isWhite ? FIELD_COLOR_WHITE : FIELD_COLOR_BLACK );
		}
	}

	private function changeFieldStyle( field : ChessboardField, styleProperty : String, value : * ) : void {
		if ( field == null ) {
			return;
		}

		// dynamic font size, depends from piece settings
		field.setStyle( "fontSize", this._pieceSettings.fontSizeCssValue );
		field.setStyle( styleProperty, value );
	}

	private function changeFieldColor( notation : String, color : int ) : ChessboardField {
		var field : ChessboardField = this.getField( notation );
		this.changeFieldStyle( field, "backgroundColor", color );
		return field;
	}

	private function markValidDrop( notation : String ) : void {
		this.changeFieldColor( notation, FIELD_COLOR_VALID_DROP );
		this._hasValidDrop = true;
	}

//	private function markMoveHintByNotation( notation : String ) : void {
//		var field : ChessboardField = this.changeFieldColor( notation, FIELD_COLOR_MOVE_HINT );
//		this._hasMoveHints = true;
//	}

	private function markMoveHintByMove( validMove : ChessboardMove ) : void {
		var field : ChessboardField = this.changeFieldColor( validMove.toPosition.toString(), FIELD_COLOR_MOVE_HINT );
		field.validMove = validMove;
		this._hasMoveHints = true;
	}

	private function removeAllValidDrop() : void {
		this.resetStyleForAllFields( FIELD_COLOR_VALID_DROP, "backgroundColor", true );
		this._hasValidDrop = false;
	}

	private function removeAllMoveHints() : void {
		this.resetStyleForAllFields( FIELD_COLOR_MOVE_HINT, "backgroundColor" );
		this._hasMoveHints = false;
	}

	private function showMoveHints( field : ChessboardField, piece : IPiece ) : void {
		var validMoves : ChessboardMoveCollection = this._validMoves;
		var move : ChessboardMove;

		for each( move in validMoves.list ) {
			this.markMoveHintByMove( move );
		}
	}

	// End Innerclass Methods


	// Start Object Methods

	public function getPosition() : ChessPosition {
		var position : ChessPosition = new ChessPosition();
		var fields : ChessboardFieldCollection = this.getFields();
		var field : ChessboardField;
		var p : IPiece;
		var notation : String;

		for each( field in fields.list ) {
			p = field.hasPiece() ? field.getPiece() : null;
			notation = field.getNotation();

			position.setPiece( p, notation );
		}

		return position;
	}

	// End Object Methods


	// Start Notification Delegates

	public override function listNotificationInterests() : Array {
		return [
			ApplicationFacade.GAME_STARTED,
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
			case ApplicationFacade.GAME_STARTED:
				this.handleGameStarted( n.getBody() as ChessboardGameVO );
			break;
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

	private function handleGameStarted( game : ChessboardGameVO ) : void {
		this._game = game;
	}

	private function handleFieldHint( notation : String ) : void {
		//this.markMoveHintByMove( notation );
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
		var n : FieldNotation = m.toPosition;
		var p : IPiece = m.piece;

		this.setPiece( p, n );
	}

	private function handleMove( m : ChessboardMove ) : void {
		var fromBox : Box = this.getField( m.fromPosition.toString() );
		var fromText : Text = fromBox.getChildAt( 0 ) as Text;
		var toBox : Box = this.getField( m.toPosition.toString() );

		toBox.addChild( fromText );

		this._game = m.game;
	}

	// End Notification Handlers


	// Start Event Handlers

	private function onMouseMove( e : MouseEvent ) : void {
		var p : IPiece = __getPiece( e.target );

		if ( p != null ) {
			if ( this._game.currentPlayer.isWhite != p.isWhite ) {
				return;
			}
			this.prepareDrag( e );
		}

	}

	private function onMouseUp( e : MouseEvent ) : void {
		this.removeAllMoveHints();
	}

	private function prepareDrag( e : MouseEvent ) : void {
		var t : Text = e.target as Text;
		var piece : IPiece = t.data as IPiece;

		if ( piece == null ) {
			return;
		}

		var fm : FontManager = FontManager.getInstance();
		var ds : DragSource = new DragSource();

		ds.addData( t, "piece" );

		DragManager.doDrag( t, ds, e /* , fm.convertTextToFlexImage( piece.fontKey ) */ );
	}

	private function onMouseDown( e : MouseEvent ) : void {
		if ( e.target is Text && ( e.target as Text ).parent is ChessboardField ) {
			var t : Text = e.target as Text;
			var p : IPiece = t.data as IPiece;

			if ( this._game.currentPlayer.isWhite != p.isWhite ) {
				return;
			}

			var f : ChessboardField = t.parent as ChessboardField;

			// TODO: get valid moves from command?
			this._validMoves = ChessboardUtil.getValidMoves( this._game, f.data as ChessboardFieldVO, this.getPosition() );

			this.showMoveHints( f, p );
		}
	}

	private function onDragEnter( e : DragEvent ) : void {
		if ( e.dragSource.hasFormat( "piece" ) ) {
			if ( e.target is ChessboardField ) {
				var f : ChessboardField = e.target as ChessboardField;
				var notation : String = f.id;
				log.debug( "onDragEnter: piece at {0}", notation );


				if ( this._validMoves.hasNotationToPosition( notation ) ) {
					log.debug( "onDragEnter: validMoves has notation to position {0}", notation.toString() );
					DragManager.acceptDragDrop( f );

					this.removeAllValidDrop();
					this.markValidDrop( notation );
				}
			}
			// TODO: check if board field boundary is touched
			/*
			else if ( ! ( e.target is Text ) && ( e.target is Box && e.target.id != null && e.target.id.indexOf( "board" ) > -1 ) )  {
				if ( e.target.id == "board" ) {
					log.debug( "onDragEnter: dragging is inside the board" );
				}
			} else if ( e.target is Box || e.target is Text ) {
				log.debug( "onDragEnter: id:" + UIComponent( e.target ).id );
			} else if ( e.target is Text ) {

			} else {
				log.debug( "onDragEnter: dragging is outside the board" );
			}
			*/
		}

	}

	private function onDragComplete( e : DragEvent ) : void {
		log.debug( "onDragComplete: " );
		if ( this._dragMove == null ) {
			log.debug( "onDragComplete: no drag move found." );
			this.removeAllValidDrop();
			this.removeAllMoveHints();
			return;
		}

		sendNotification( ApplicationFacade.TRY_TO_MOVE, this._dragMove );
		this._dragMove = null;
	}

	private function onDragDrop( e : DragEvent ) : void {
		log.debug( "onDragDrop: " );
		if ( this._isBoardLocked ) {
			Alert.show( "All Movements are looked. You have to go to the end of the game for making the next move.", "Movement looked!" );
			return;
		}

		var toField : ChessboardField = ChessboardField( e.target ); // Target Box
		var fromField : ChessboardField = ChessboardField( e.dragInitiator.parent ); // From Box

		var t : Text = Text( e.dragInitiator );
		var p : IPiece = t.data as IPiece;

		var fromNotation : FieldNotation = FieldNotation.createNotationByString( fromField.id );
		var toNotation : FieldNotation = FieldNotation.createNotationByString( toField.id );

		var m : ChessboardMove = new ChessboardMove();
		m.validMoves = this._validMoves;
		m.validMove = toField.validMove;
		m.position = this.getPosition();
		m.game = this._game;

		m.fromPosition = fromNotation;
		m.toPosition = toNotation;
		m.piece = p;
		m.beatenPiece = this.getPieceAt( toNotation );

		this._validMoves = null;
		this.removeAllMoveHints();
		this.removeAllValidDrop();

		this._dragMove = m;
	}

	private function onMouseClick( e : Event ) : void {
		if ( this._isBoardLocked ) {
			Alert.show( "All Movements are looked. You have to go to the end of the game for making the next move.", "Movement looked!" );
			return;
		}

		if ( e.target is Text ) {
			var t : Text = ( e.target as Text );
			// var f : ChessboardField = t.parent as ChessboardField;
			var piece : IPiece = t.data as IPiece;

			if ( _isBoardInspectMode ) {
				Alert.show(
					"Piece Name: " + piece.getName() + "\n" +
					"Piece FontKey: " + piece.fontKey
				, "Piece Inspection" );
			}

			this.removeAllMoveHints();
		}
	}

	// End Event Handlers


	// Start Getter / Setters

	private function get chessboard() : Chessboard {
		return this.viewComponent as Chessboard;
	}

	// End Getter / Setters


	// Start internal class getters

	private function __getPiece( o : Object ) : IPiece {
		if ( o is Text ) {
			var t : Text = o as Text;
			if ( t.data is IPiece ) {
				var p : IPiece = t.data as IPiece;
				return p;
			}
		}

		return null;
	}

	// End internal class getters

}
}