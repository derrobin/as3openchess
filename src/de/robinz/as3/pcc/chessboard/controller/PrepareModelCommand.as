package de.robinz.as3.pcc.chessboard.controller
{
	import de.robinz.as3.pcc.chessboard.model.ApplicationProxy;
	import de.robinz.as3.pcc.chessboard.model.FontProxy;
	import de.robinz.as3.pcc.chessboard.model.GameProxy;
	import de.robinz.as3.pcc.chessboard.model.SaveGameProxy;

	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.command.SimpleCommand;

	/**
	 * Prepares the model of the application
	 *
	 * @author robin heinel
	 */
	public class PrepareModelCommand extends SimpleCommand
	{
		// Start SimpleCommand overrides

		public override function execute( notification : INotification ) : void {
			facade.registerProxy( new ApplicationProxy() );
			facade.registerProxy( new GameProxy() );
			facade.registerProxy( new FontProxy() );
			facade.registerProxy( new SaveGameProxy() );
		}

		// End SimpleCommand overrides


		// Start Innerclass Methods

		// End Innerclass Methods


		// Start Getter / Setters

		// End Getter / Setters
	}
}