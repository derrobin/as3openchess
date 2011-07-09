package de.robinz.as3.pcc.chessboard.controller.ui
{
import de.robinz.as3.pcc.chessboard.ApplicationFacade;
import de.robinz.as3.pcc.chessboard.controller.BaseCommand;
import de.robinz.as3.pcc.chessboard.library.CssSelectors;
import de.robinz.as3.pcc.chessboard.library.FontManager;
import de.robinz.as3.pcc.chessboard.library.vo.ColorSettingsVO;
import de.robinz.as3.pcc.chessboard.library.vo.PieceSettingsVO;
import de.robinz.as3.pcc.chessboard.model.FontProxy;

import de.robinz.as3.pcc.chessboard.view.MenuBarMediator;

import mx.styles.CSSStyleDeclaration;
import mx.styles.StyleManager;

import org.puremvc.as3.interfaces.INotification;

/**
 * ChangeColorSettingsCommand
 *
 * @author robin heinel
 */
public class ChangeColorSettingsCommand extends BaseCommand
{
	// Start SimpleCommand overrides

	public override function execute( n : INotification ) : void {
		super.execute( n );

		if ( n.getBody() is ColorSettingsVO ) {
			this.changeColorSettings( n.getBody() as ColorSettingsVO );
		}
		if ( n.getBody() == null ) {
			this.changeColorSettings( this.appProxy.colors );
		}
	}

	// End SimpleCommand overrides


	// Start Innerclass Methods

	private function changeColorSettings( colors : ColorSettingsVO ) : void {
		this.appProxy.colors = colors;
		sendNotification( ApplicationFacade.COLOR_SETTINGS_CHANGED, colors );
	}

	// End Innerclass Methods


	// Start Getter / Setters

	private function get fontProxy() : FontProxy {
		return this.facade.retrieveProxy( FontProxy.NAME ) as FontProxy;
	}

	private function get menuBarMediator() : MenuBarMediator {
		return this.facade.retrieveMediator( MenuBarMediator.NAME ) as MenuBarMediator;
	}

	// End Getter / Setters
}
}