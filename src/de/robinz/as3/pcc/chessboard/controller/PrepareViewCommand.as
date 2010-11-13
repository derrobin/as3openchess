package de.robinz.as3.pcc.chessboard.controller
{
	import de.robinz.as3.pcc.chessboard.view.ChessboardMediator;
	import de.robinz.as3.pcc.chessboard.view.ApplicationMediator;

	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.command.SimpleCommand;

	/**
	 * Prepares the view for the application
	 *
	 * @author Robin Heinel
	 *
	 */
	public class PrepareViewCommand extends SimpleCommand
	{
		public override function execute( note : INotification ) : void {
			var app : mainapp = note.getBody() as mainapp;

			facade.registerMediator( new ApplicationMediator( app ) );
			facade.registerMediator( new ChessboardMediator( app.applicationView.chessboard ) );

		}

	}
}