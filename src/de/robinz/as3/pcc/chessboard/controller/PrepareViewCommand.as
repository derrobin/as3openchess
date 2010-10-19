package de.robinz.as3.pcc.chessboard.controller
{
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
		override public function execute(note:INotification):void
		{
			var app:chessboard = note.getBody() as chessboard;
			facade.registerMediator( new ApplicationMediator( app ) );
		}

	}
}