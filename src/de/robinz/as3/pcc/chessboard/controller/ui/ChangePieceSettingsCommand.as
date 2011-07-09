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

		if ( n.getBody() is PieceSettingsVO ) {
			this.changePieceSettings( n.getBody() as PieceSettingsVO );
		}
		if ( n.getBody() == null ) {
			this.changePieceSettings( this.fontProxy.getPieceSettings() );
		}
	}

	// End SimpleCommand overrides


	// Start Innerclass Methods

	private function changePieceSettings( settings : PieceSettingsVO ) : void {
		FontManager.getInstance().setFont( settings.font );

		fontProxy.currentFont = settings.font;
		fontProxy.currentFontSize = settings.fontSize;

		settings.fontSizeCssValue = fontProxy.currentFontSizeCssValue;
		settings.font = fontProxy.currentFont;

		CssUtil.overrideCssProperty( "pieceHolder", CssProperties.FONT_FAMILY, settings.font.id );
		CssUtil.overrideCssProperty( "pieceHolder", CssProperties.FONT_SIZE, settings.fontSizeCssValue );
		//CssUtil.overrideCssProperty( CssSelectors.FIELD_PIECE_WHITE, CssProperties.FONT_FAMILY, settings.font.id );
		//CssUtil.overrideCssProperty( CssSelectors.FIELD_PIECE_BLACK, CssProperties.FONT_FAMILY, settings.font.id );

		sendNotification( ApplicationFacade.PIECE_SETTINGS_CHANGED, settings );
	}

	// End Innerclass Methods


	// Start Getter / Setters

	private function get fontProxy() : FontProxy {
		return this.facade.retrieveProxy( FontProxy.NAME ) as FontProxy;
	}

	// End Getter / Setters
}
}