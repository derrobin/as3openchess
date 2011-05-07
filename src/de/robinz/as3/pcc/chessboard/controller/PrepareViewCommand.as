package de.robinz.as3.pcc.chessboard.controller
{
import de.robinz.as3.pcc.chessboard.view.ApplicationMediator;
import de.robinz.as3.pcc.chessboard.view.ChessboardMediator;
import de.robinz.as3.pcc.chessboard.view.MenubarMediator;

import org.puremvc.as3.interfaces.INotification;
import org.puremvc.as3.patterns.command.SimpleCommand;

/**
 * Prepares the view for the application
 *
 * @author robin heinel
 */
public class PrepareViewCommand extends SimpleCommand
{
	// Start SimpleCommand overrides

	public override function execute( n : INotification ) : void {
		var app : mainapp = n.getBody() as mainapp;

		facade.registerMediator( new ApplicationMediator( app ) );
		facade.registerMediator( new ChessboardMediator( app.applicationView.chessboard ) );
		facade.registerMediator( new MenubarMediator( app.applicationView.chessboardMenubar ) );
	}

	// End SimpleCommand overrides


	// Start Innerclass Methods

	// End Innerclass Methods


	// Start Getter / Setters

	// End Getter / Setters
}
}