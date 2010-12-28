package de.robinz.as3.pcc.chessboard.controller
{
	import de.robinz.as3.pcc.chessboard.ApplicationFacade;

	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.command.SimpleCommand;

	/**
	 * Application initialization
	 *
	 * @author robin heinel
	 */
	public class InitCommand extends SimpleCommand
	{
		// Start SimpleCommand overrides

		public override function execute( note : INotification ) : void {
			sendNotification( ApplicationFacade.CHANGE_PIECE_SETTINGS );
			sendNotification( ApplicationFacade.NEW_GAME );
		}

		// End SimpleCommand overrides


		// Start Innerclass Methods

		// End Innerclass Methods


		// Start Getter / Setters

		// End Getter / Setters
	}
}