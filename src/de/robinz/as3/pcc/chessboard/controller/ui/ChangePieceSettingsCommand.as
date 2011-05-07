package de.robinz.as3.pcc.chessboard.controller.ui
{
import de.robinz.as3.pcc.chessboard.controller.BaseCommand;
import de.robinz.as3.pcc.chessboard.library.FontManager;
import de.robinz.as3.pcc.chessboard.library.vo.PieceSettingsVO;
import de.robinz.as3.pcc.chessboard.model.FontProxy;
import de.robinz.as3.pcc.chessboard.view.ApplicationMediator;

import mx.styles.CSSStyleDeclaration;
import mx.styles.StyleManager;

import org.puremvc.as3.interfaces.INotification;
import org.puremvc.as3.patterns.command.SimpleCommand;

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

		this.overrideCssProperty( ".fieldWhite", "fontFamily", fontProxy.currentFont.id );
		this.overrideCssProperty( ".fieldWhite", "fontSize", fontProxy.currentFontSizeCssValue );
		this.overrideCssProperty( ".fieldBlack", "fontFamily", settings.font.id );
		this.overrideCssProperty( ".fieldBlack", "fontSize", fontProxy.currentFontSizeCssValue );
		this.overrideCssProperty( ".piece", "fontFamily", fontProxy.currentFont.id );
	}

	private function overrideCssProperty( selector : String, property : String, value : * ) : void {
		var css : CSSStyleDeclaration = StyleManager.getStyleDeclaration( selector );

		if ( css == null ) {
			trace( "overrideCssProperty: CSS-Selector does not exists!" );
			return;
		}

		css.setStyle( property, value );
	}

	// End Innerclass Methods


	// Start Getter / Setters

	private function get fontProxy() : FontProxy {
		return this.facade.retrieveProxy( FontProxy.NAME ) as FontProxy;
	}

	// End Getter / Setters
}
}