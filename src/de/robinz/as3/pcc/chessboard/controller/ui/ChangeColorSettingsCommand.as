package de.robinz.as3.pcc.chessboard.controller.ui
{
import de.robinz.as3.pcc.chessboard.ApplicationFacade;
import de.robinz.as3.pcc.chessboard.controller.BaseCommand;
import de.robinz.as3.pcc.chessboard.library.vo.ColorSettingsVO;

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
		this.changeColorSettings( n.getBody() as ColorSettingsVO );
	}

	// End SimpleCommand overrides


	// Start Innerclass Methods

	private function changeColorSettings( colors : ColorSettingsVO ) : void {
		this.appProxy.colors = colors;
		sendNotification( ApplicationFacade.COLOR_SETTINGS_CHANGED, colors );
	}

	// End Innerclass Methods


	// Start Getter / Setters

	// End Getter / Setters
}
}