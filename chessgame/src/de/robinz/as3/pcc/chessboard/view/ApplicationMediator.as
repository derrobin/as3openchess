package de.robinz.as3.pcc.chessboard.view
{
import de.robinz.as3.pcc.chessboard.ApplicationFacade;
import de.robinz.as3.pcc.chessboard.library.CssProperties;
import de.robinz.as3.pcc.chessboard.library.vo.BoardSettingsVO;
import de.robinz.as3.pcc.chessboard.library.vo.ColorSettingsVO;
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

    public function ApplicationMediator( m : mainapp ) {
        super( NAME, m );
    }


    // Start Innerclass Methods

    // End Innerclass Methods


    // Start Notification Delegates

    public override function listNotificationInterests() : Array {
        return [
            ApplicationFacade.BOARD_SETTINGS_CHANGED,
            ApplicationFacade.COLOR_SETTINGS_CHANGED,
        ];
    }

    public override function handleNotification( n : INotification ) : void {
        switch( n.getName() ) {
            case ApplicationFacade.BOARD_SETTINGS_CHANGED:
                    this.handleChangeBoard( n.getBody() as BoardSettingsVO );
            break;
            case ApplicationFacade.COLOR_SETTINGS_CHANGED:
                this.handleColorChanged( n.getBody() as ColorSettingsVO );
            break;
        }
    }

    // End Notification Delegates


    // Start Notification Handlers

    // TODO: Move to ChessboardMediator
    private function handleChangeBoard( sets : BoardSettingsVO ) : void {
        if ( ! sets.fixedSize ) {
            this.view.chessboard.board.percentHeight = this.view.chessboard.board.percentWidth = 100;
        } else {
            this.view.chessboard.board.height = this.view.chessboard.board.width = sets.size;
            this.view.chessboard.setStyle( CssProperties.VERTICAL_ALIGN, sets.verticalAlign );
            this.view.chessboard.setStyle( CssProperties.HORIZONTAL_ALIGN, sets.horizontalAlign );
        }
    }

    private function handleColorChanged( sets : ColorSettingsVO ) : void {
        view.setStyle( CssProperties.BACKGROUND_COLOR, sets.mainBackground );
        this.view.chessboard.board.setStyle( CssProperties.BACKGROUND_COLOR, sets.mainBackground );
        this.view.chessboardMenubar.setStyle( CssProperties.BACKGROUND_COLOR, sets.menuBarBackground );
    }

    // End Notification Handlers


    // Start Event Handlers

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