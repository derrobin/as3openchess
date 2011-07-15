package de.robinz.as3.pcc.chessboard.view {
import de.robinz.as3.pcc.chessboard.ApplicationFacade;
import de.robinz.as3.pcc.chessboard.library.ChessPosition;
import de.robinz.as3.pcc.chessboard.library.ChessboardMove;
import de.robinz.as3.pcc.chessboard.library.ChessboardMoveCollection;
import de.robinz.as3.pcc.chessboard.library.ChessboardUtil;
import de.robinz.as3.pcc.chessboard.library.CssProperties;
import de.robinz.as3.pcc.chessboard.library.CssSelectors;
import de.robinz.as3.pcc.chessboard.library.CssUtil;
import de.robinz.as3.pcc.chessboard.library.FieldNotation;
import de.robinz.as3.pcc.chessboard.library.pieces.IPiece;
import de.robinz.as3.pcc.chessboard.library.vo.ChessboardFieldVO;
import de.robinz.as3.pcc.chessboard.library.vo.ChessboardGameVO;
import de.robinz.as3.pcc.chessboard.library.vo.ColorSettingsVO;
import de.robinz.as3.pcc.chessboard.library.vo.PiecePositionVO;
import de.robinz.as3.pcc.chessboard.library.vo.PieceSettingsVO;
import de.robinz.as3.pcc.chessboard.model.GameProxy;
import de.robinz.as3.pcc.chessboard.view.views.Chessboard;
import de.robinz.as3.pcc.chessboard.view.views.chessboard.ChessboardField;
import de.robinz.as3.pcc.chessboard.view.views.chessboard.ChessboardFieldCollection;

import flash.events.Event;
import flash.events.MouseEvent;

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
public class ChessboardMediator extends BaseMediator {
	public static const NAME : String = "ChessboardMediator";

	public static const FIELD_SPACE : int = 1;

	private var _game : ChessboardGameVO;
	private var _validMoves : ChessboardMoveCollection;
	private var _colors : ColorSettingsVO = new ColorSettingsVO();

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

		for ( j; j <= 8; j++ ) {
			isWhite = isWhite ? false : true;

			for ( i; i <= rows.length; i++ ) {
				c = rows.charAt( i - 1 );
				notation = c + j.toString();
				field = ChessboardUtil.createBoardField( notation, isWhite, this._colors.fieldWhite, this._colors.fieldBlack );

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

	// TODO: performance: use dictionary for indexing
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

	private function refreshPieces() : void {
		var piece : IPiece;
		var fields : ChessboardFieldCollection = this.getFields();
		var field : ChessboardField;
		var t : Text;

		for each( field in fields.list ) {
			field.refreshFontKey();

			t = field.getText();

			if ( t == null ) {
				continue;
			}

			t.setStyle( CssProperties.FONT_SIZE, this._pieceSettings.fontSize );
		}
	}

	private function setPiece( pp : PiecePositionVO ) : void {
		var field : ChessboardField = this.getField( pp.notation.toString() );

		field.setPiece( pp.piece );

		field.setPieceFilter( pp.piece.isWhite ? this._colors.pieceWhiteBorder : this._colors.pieceBlackBorder );

		field.getText().setStyle( CssProperties.COLOR, pp.piece.isWhite ? this._colors.pieceWhite : this._colors.pieceBlack );
	}

	private function resetFieldColors() : void {
		var c : ChessboardFieldCollection = this.getFields();
		var f : ChessboardField;
		var vo : ChessboardFieldVO;

		for each( f in c.list ) {
			vo = f.data as ChessboardFieldVO;
			f.setStyle( CssProperties.BACKGROUND_COLOR, vo.isWhite ? this._colors.fieldWhite : this._colors.fieldBlack );

			if ( f.getText() != null && f.getPiece() != null ) {
				f.getText().setStyle( CssProperties.COLOR, f.getPiece().isWhite ? this._colors.pieceWhite : this._colors.pieceBlack );
				f.setPieceFilter( f.getPiece().isWhite ? this._colors.pieceWhiteBorder : this._colors.pieceBlackBorder );
			}

		}
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
				f.setStyle( styleProperty, this._colors.fieldMoveHint );
				continue;
			}

			f.setStyle( styleProperty, vo.isWhite ? this._colors.fieldWhite : this._colors.fieldBlack );
		}
	}

	private function changeFieldStyle( field : ChessboardField, styleProperty : String, value : * ) : void {
		if ( field == null ) {
			return;
		}

		// dynamic font size, depends from piece settings
		field.setStyle( "fontSize", this._pieceSettings.fontSize );
		field.setStyle( styleProperty, value );
	}

	private function changeFieldColor( notation : String, color : int ) : ChessboardField {
		var field : ChessboardField = this.getField( notation );
		this.changeFieldStyle( field, "backgroundColor", color );
		return field;
	}

	private function markValidDrop( notation : String ) : void {
		this.changeFieldColor( notation, this._colors.fieldValidDrop );
		this._hasValidDrop = true;
	}

	private function markMoveHintByMove( validMove : ChessboardMove ) : void {
		var field : ChessboardField = this.changeFieldColor( validMove.toField.toString(), this._colors.fieldMoveHint );
		field.validMove = validMove;
		this._hasMoveHints = true;
	}

	private function removeAllValidDrop() : void {
		this.resetStyleForAllFields( this._colors.fieldValidDrop, "backgroundColor", true );
		this._hasValidDrop = false;
	}

	private function removeAllMoveHints() : void {
		this.resetStyleForAllFields( this._colors.fieldMoveHint, "backgroundColor" );
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

		position.lastMove = this.gameProxy.getCurrentGame().moves.getLastMove();

		return position;
	}

	// End Object Methods


	// Start Notification Delegates

	public override function listNotificationInterests() : Array {
		return [
			ApplicationFacade.COLOR_SETTINGS_CHANGED,
			ApplicationFacade.GAME_STARTED,
			ApplicationFacade.FIELD_HINT,
			ApplicationFacade.REMOVE_ALL_FIELD_HINTS,
			ApplicationFacade.LOCK_BOARD,
			ApplicationFacade.UNLOCK_BOARD,
			ApplicationFacade.PIECE_SETTINGS_CHANGED,
			ApplicationFacade.ENABLE_BOARD_INSPECT_PIECE_MODE,
			ApplicationFacade.DISABLE_BOARD_INSPECT_PIECE_MODE,
			ApplicationFacade.REMOVE_PIECE,
			ApplicationFacade.REMOVE_ALL_PIECES,
			ApplicationFacade.SET_PIECE,
			ApplicationFacade.MOVE
		];
	}

	public override function handleNotification( n : INotification ) : void {
		switch ( n.getName() ) {
			case ApplicationFacade.COLOR_SETTINGS_CHANGED:
				this.handleChangeColors( n.getBody() as ColorSettingsVO );
				break;
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
			case ApplicationFacade.PIECE_SETTINGS_CHANGED:
				this.handlePieceSettingsChanged( n.getBody() as PieceSettingsVO );
				break;
			case ApplicationFacade.ENABLE_BOARD_INSPECT_PIECE_MODE:
				this.handleEnableBoardInspectMode();
				break;
			case ApplicationFacade.DISABLE_BOARD_INSPECT_PIECE_MODE:
				this.handleDisableBoardInspectMode();
				break;
			case ApplicationFacade.REMOVE_PIECE:
				this.handleRemovePiece( n.getBody() as FieldNotation, n.getType() );
				break;
			case ApplicationFacade.REMOVE_ALL_PIECES:
				this.handleRemoveAllPieces();
				break;
			case ApplicationFacade.SET_PIECE:
				this.handleSetPiece( n.getBody() as PiecePositionVO );
				break;
			case ApplicationFacade.MOVE:
				this.handleMove( n.getBody() as ChessboardMove );
				break;
		}
	}

	// End Notification Delegates


	// Start Notification Handlers


	private function handleChangeColors( colors : ColorSettingsVO ) : void {
		this._colors = colors;

		// board gap
		this.chessboard.boardInner.setStyle( CssProperties.BACKGROUND_COLOR, colors.boardGapColor );
		CssUtil.overrideCssProperty( CssSelectors.BOARD_FIELD_ROW, CssProperties.BACKGROUND_COLOR, colors.boardGapColor );
		CssUtil.overrideCssProperty( CssSelectors.BOARD_BORDER_BOTTOM, CssProperties.COLOR, colors.boardGapColor );
		CssUtil.overrideCssProperty( CssSelectors.BOARD_BORDER_TOP, CssProperties.COLOR, colors.boardGapColor );

		// board border background
		CssUtil.overrideCssProperty( CssSelectors.BOARD_LEGEND_VERTICAL_ROW, CssProperties.BACKGROUND_COLOR, colors.boardBorderBackground );
		CssUtil.overrideCssProperty( CssSelectors.BOARD_LEGEND_VERTICAL, CssProperties.BACKGROUND_COLOR, colors.boardBorderBackground );
		CssUtil.overrideCssProperty( CssSelectors.BOARD_BORDER_TOP, CssProperties.BACKGROUND_COLOR, colors.boardBorderBackground );
		CssUtil.overrideCssProperty( CssSelectors.BOARD_BORDER_BOTTOM, CssProperties.BACKGROUND_COLOR, colors.boardBorderBackground );

		// piece
		CssUtil.overrideCssProperty( CssSelectors.BOARD_FIELD, CssProperties.COLOR, colors.pieceBlack );

		// board border font
		CssUtil.overrideCssProperty( CssSelectors.BOARD_LEGEND_CONTAINER, CssProperties.COLOR, colors.boardBorderFont );

		this.resetFieldColors();
	}

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

	private function handlePieceSettingsChanged( settings : PieceSettingsVO ) : void {
		// TODO: performance: condition to internal state
		this._pieceSettings = settings;
		this.refreshPieces();
	}

	private function handleEnableBoardInspectMode() : void {
		this._isBoardInspectMode = true;
	}

	private function handleDisableBoardInspectMode() : void {
		this._isBoardInspectMode = false;
	}

	private function handleRemovePiece( notation : FieldNotation, type : String ) : void {
		var p : IPiece = this.getPieceAt( notation );
		if ( this.removePieceByNotation( notation ) ) {
			sendNotification( ApplicationFacade.PIECE_REMOVED, p, type );
		}
	}

	private function handleRemoveAllPieces() : void {
		this.removeAllPieces();
	}

	private function handleSetPiece( pp : PiecePositionVO ) : void {
		this.setPiece( pp );
	}

	private function handleMove( m : ChessboardMove ) : void {
		var fromBox : Box = this.getField( m.fromField.toString() );
		var fromText : Text = fromBox.getChildAt( 0 ) as Text;
		var toBox : Box = this.getField( m.toField.toString() );
		toBox.addChild( fromText );
		this._game = m.game;
	}

	// End Notification Handlers


	// Start Event Handlers

	private function onMouseMove( e : MouseEvent ) : void {
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

		var ds : DragSource = new DragSource();
		ds.addData( t, "piece" );

		// a copy of text is necessary, otherwise the Text will loose ChessboardField as parent
		var icon : Text = new Text();
		icon.mouseChildren = false;
		icon.mouseEnabled = false;
		icon.text = t.text;
		icon.setStyle( CssProperties.COLOR, piece.isWhite ? this._colors.pieceWhite : this._colors.pieceBlack );
		icon.setStyle( CssProperties.FONT_FAMILY, this._pieceSettings.font.id );
		icon.setStyle( CssProperties.FONT_SIZE, this._pieceSettings.fontSize );
		var fs : Array = ChessboardUtil.getPieceFilters( piece.isWhite ? this._colors.pieceWhiteBorder : this._colors.pieceBlackBorder );
		icon.filters = fs;

		DragManager.doDrag( t, ds, e, icon, 0, 0, 1 );
	}

	private function onMouseDown( e : MouseEvent ) : void {
		if ( e.target is Text && ( e.target as Text ).parent is ChessboardField ) {
			var t : Text = e.target as Text;
			var p : IPiece = t.data as IPiece;

			if ( this._game.currentPlayer.isWhite != p.isWhite ) {
				return;
			}

			var position : ChessPosition = this.getPosition();
			var f : ChessboardField = t.parent as ChessboardField;
			var fvo : ChessboardFieldVO = f.data as ChessboardFieldVO;
			var piece : IPiece = position.getPieceAt( fvo.notation.toString() );
			var pp : PiecePositionVO = PiecePositionVO.create( piece, fvo.notation );

			this._validMoves = ChessboardUtil.getValidMoves( this._game, position, pp );

			this.showMoveHints( f, p );

			if ( p != null ) {
				if ( this._game.currentPlayer.isWhite != p.isWhite ) {
					return;
				}
				this.prepareDrag( e );
			}
		}
	}

	private function onDragEnter( e : DragEvent ) : void {
		if ( this._validMoves == null ) {
			return;
		}
		if ( e.dragSource.hasFormat( "piece" ) ) {
			if ( e.target is ChessboardField ) {
				var f : ChessboardField = e.target as ChessboardField;
				var notation : String = f.id;
				if ( this._validMoves.hasNotationToPosition( notation ) ) {
					log.debug( "onDragEnter: validMoves has notation to position {0}", notation.toString() );
					DragManager.acceptDragDrop( f );

					this.removeAllValidDrop();
					this.markValidDrop( notation );
				}
			}
		}

	}

	private function onDragComplete( e : DragEvent ) : void {
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

		m.fromField = fromNotation;
		m.toField = toNotation;
		m.piece = p;
		m.beatenPiece = this.getPieceAt( toNotation );
		// TODO: move this logic to MoveValidator or MoveCommand
		// m.isPawnDoubleJump = p is Pawn && 2 == ( Math.max( toNotation.row, fromNotation.row ) - Math.min( toNotation.row, fromNotation.row ) );

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

	private function get gameProxy() : GameProxy {
		return this.facade.retrieveProxy( GameProxy.NAME ) as GameProxy;
	}

	// End Getter / Setters

}
}