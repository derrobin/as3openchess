package de.robinz.as3.pcc.chessboard.controller
{
	import de.robinz.as3.pcc.chessboard.view.ApplicationMediator;
	import de.robinz.as3.pcc.chessboard.view.ChessboardMediator;
	import de.robinz.as3.pcc.chessboard.view.MenubarMediator;
	import de.robinz.as3.pcc.chessboard.view.MoveHistoryMediator;
	import de.robinz.as3.pcc.chessboard.view.PieceSettingsMediator;
	import de.robinz.as3.pcc.chessboard.view.TakenPiecesMediator;

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

		public override function execute( note : INotification ) : void {
			var app : mainapp = note.getBody() as mainapp;

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