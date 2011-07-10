package de.robinz.as3.pcc.chessboard.controller.ui
{
import de.robinz.as3.pcc.chessboard.ApplicationFacade;
import de.robinz.as3.pcc.chessboard.controller.BaseCommand;
import de.robinz.as3.pcc.chessboard.library.CssProperties;
import de.robinz.as3.pcc.chessboard.library.CssSelectors;
import de.robinz.as3.pcc.chessboard.library.CssUtil;
import de.robinz.as3.pcc.chessboard.library.FontManager;
import de.robinz.as3.pcc.chessboard.library.vo.PieceSettingsVO;
import de.robinz.as3.pcc.chessboard.model.FontProxy;

import de.robinz.as3.pcc.chessboard.view.views.game.PieceSettingsDialog;

import mx.styles.CSSStyleDeclaration;
import mx.styles.StyleManager;

import org.puremvc.as3.interfaces.INotification;

/**
 * ChangePieceSettingsCommand
 *
 * @author robin heinel
 */
public class ChangePieceSettingsCommand extends BaseCommand
{
	// Start SimpleCommand overrides

	public override function execute( n : INotification ) : void {
		super.execute( n );

		this.changePieceSettings( n.getBody() as PieceSettingsVO );
	}

	// End SimpleCommand overrides


	// Start Innerclass Methods

	private function changePieceSettings( sets : PieceSettingsVO ) : void {
		FontManager.getInstance().setFont( sets.font );

		fontProxy.currentFont = sets.font;
		fontProxy.currentFontSize = sets.fontSize;
		sets.font = fontProxy.currentFont;

		CssUtil.overrideCssProperty( CssProperties.PIECE_HOLDER, CssProperties.FONT_FAMILY, sets.font.id );
		CssUtil.overrideCssProperty( CssProperties.PIECE_HOLDER, CssProperties.FONT_SIZE, sets.fontSize );

		sendNotification( ApplicationFacade.PIECE_SETTINGS_CHANGED, sets );
	}

	// End Innerclass Methods


	// Start Getter / Setters

	private function get fontProxy() : FontProxy {
		return this.facade.retrieveProxy( FontProxy.NAME ) as FontProxy;
	}

	// End Getter / Setters
}
}