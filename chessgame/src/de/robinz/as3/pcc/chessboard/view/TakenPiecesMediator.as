package de.robinz.as3.pcc.chessboard.view
{
import de.robinz.as3.pcc.chessboard.ApplicationFacade;
import de.robinz.as3.pcc.chessboard.library.CssProperties;
import de.robinz.as3.pcc.chessboard.library.pieces.IPiece;
import de.robinz.as3.pcc.chessboard.library.vo.ColorSettingsVO;
import de.robinz.as3.pcc.chessboard.library.vo.PieceSettingsVO;
import de.robinz.as3.pcc.chessboard.view.views.game.TakenPiecesDialog;
import de.robinz.as3.pcc.chessboard.view.views.takenPieces.TakenPiece;

import flash.display.DisplayObject;

import mx.containers.TitleWindow;
import mx.core.Container;
import mx.events.CloseEvent;

import org.puremvc.as3.interfaces.INotification;

/**
 * UI Control for Info Panel - Taken Pieces
 *
 * @author robin heinel
 */
public class TakenPiecesMediator extends DialogBaseMediator
{
    public static const NAME : String = "TakenPiecesMediator";

    public function TakenPiecesMediator( stage : DisplayObject ) {
        super( NAME, stage );
    }

    // Start Innerclass Methods

    private function appear() : TakenPiecesDialog {
        var view : TitleWindow = this.createDialog( "Taken Pieces", 256, 350, TakenPiecesDialog, this.stage, false );
        view.x = 14;
        view.y = 460;

        view.addEventListener( CloseEvent.CLOSE, onPopupClose );

        this._dialog = view;
        return view as TakenPiecesDialog;
    }

    private function reset() : void {
        this.popup.whitePieces.removeAllChildren();
        this.popup.blackPieces.removeAllChildren();
    }

    private function addPiece( p : IPiece, addWrapper : Boolean = true ) : void {
        var tp : TakenPiece = new TakenPiece();
        tp.initialize();
        tp.piece.text = p.fontKey;
        tp.data = p;

        var targetContainer : Container;

        if ( p.isWhite ) {
            targetContainer = this.popup.whitePieces;
        } else {
            targetContainer = this.popup.blackPieces;
        }

        targetContainer.addChild( tp );

        // TODO: optional: sort piece queue ( mb use of out-commented method insertPiece() )
    }

    private function removePiece( p : IPiece ) : void {
        var wrapper : TakenPiece = this.getPieceWrapperFor( p );
        if ( wrapper == null ) {
            return;
        }
        wrapper.parent.removeChild( wrapper );
    }

    private function getPieceWrapperFor( piece : IPiece ) : TakenPiece {
        var tp : TakenPiece;
        var p : IPiece;
        var wrappers : Array = this.getPieceWrappers();
        for each( tp in wrappers ) {
            p = tp.data as IPiece;
            if ( ! p.equals( piece ) ) {
                continue;
            }

            return tp;
        }

        return null;
    }

    private function getPieceWrappers() : Array {
        return new Array().concat(
            this.popup.whitePieces.getChildren(),
            this.popup.blackPieces.getChildren()
        );
    }

    private function refreshPieces() : void {
        var piece : IPiece;
        var tp : TakenPiece;
        var wrappers : Array = this.getPieceWrappers();

        var i : int = 0;
        while ( wrappers.length > i ) {
            tp = wrappers[ i ] as TakenPiece;
            piece = tp.data as IPiece;

            // Remove Piece View from Viewstack
            tp.parent.removeChild( tp );

            // Add as new piece to viewstack with the right fontkey
            this.addPiece( piece );

            i++;
        };
    }

    /*
    private function insertPiece( c : Container, p : Piece ) : void {
        var childs = c.getChildren();
        var child : TakenPiece;
        var piece : IPiece;
        for each( child in childs ) {
            piece = child.data as IPiece;
            if ( piece.getSortIndex() == p.getSortIndex() ) {
                c.addChild();
            }
        }

        c.addChildAt( c, p.getSortIndex() );
    }
    */

    // End Innerclass Methods


    // Start Notification Delegates

    public override function listNotificationInterests() : Array {
        return [
            ApplicationFacade.APPEAR_TAKEN_PIECES_PANEL,
            ApplicationFacade.DISAPPEAR_TAKEN_PIECES_PANEL,
            ApplicationFacade.RESTORE_PIECE,
            ApplicationFacade.CHANGE_PIECE_SETTINGS,
            ApplicationFacade.CHANGE_COLOR_SETTINGS,
            ApplicationFacade.NEW_GAME,
            ApplicationFacade.PIECE_REMOVED
        ];
    }

    public override function handleNotification( n : INotification ) : void {
        switch( n.getName() ) {
            case ApplicationFacade.APPEAR_TAKEN_PIECES_PANEL:
                this.appear();
            break;
            case ApplicationFacade.DISAPPEAR_TAKEN_PIECES_PANEL:
                this.disappear();
            break;
            case ApplicationFacade.RESTORE_PIECE:
                this.handleRestorePiece( n.getBody() as IPiece );
            break;
            case ApplicationFacade.CHANGE_PIECE_SETTINGS:
                this.handleChangePieceSettings( n.getBody() as PieceSettingsVO );
            break;
            case ApplicationFacade.CHANGE_COLOR_SETTINGS:
                this.handleChangeColorSettings( n.getBody() as ColorSettingsVO );
            break;
            case ApplicationFacade.NEW_GAME:
                this.handleNewGame();
            break;
            case ApplicationFacade.PIECE_REMOVED:
                if ( n.getType() == null ) {
                    this.handlePieceRemoved( n.getBody() as IPiece );
                }
            break;
        }
    }

    // End Notification Delegates


    // Start Notification Handlers

    private function handleRestorePiece( piece : IPiece ) : void {
        this.removePiece( piece );
    }

    private function handleChangeColorSettings( settings : ColorSettingsVO ) : void {
        this.popup.setStyle( CssProperties.BORDER_COLOR, settings.menuBarBackground );
    }

    private function handleChangePieceSettings( settings : PieceSettingsVO ) : void {
        // TODO: performance: make condition to internal state
        this.popup.blackPieces.setStyle( CssProperties.FONT_FAMILY, settings.font.id );
        this.popup.whitePieces.setStyle( CssProperties.FONT_FAMILY, settings.font.id );
        this.popup.whitePieces.setStyle( CssProperties.FONT_SIZE, 25 );
        this.popup.blackPieces.setStyle( CssProperties.FONT_SIZE, 25 );

        this.refreshPieces();
    }

    private function handleNewGame() : void {
        this.reset();
    }

    private function handlePieceRemoved( piece : IPiece ) : void {
        this.addPiece( piece );
    }

    // End Notification Handlers


    // Start Event Handlers

    protected function onPopupClose( e : CloseEvent ) : void {
        sendNotification( ApplicationFacade.DISAPPEAR_TAKEN_PIECES_PANEL );
        this.disappear();
    }

    // End Event Handlers


    // Start Getter / Setters

    protected function get popup() : TakenPiecesDialog {
        return this._dialog as TakenPiecesDialog;
    }

    // End Getter / Setters
}
}