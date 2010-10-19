package de.robinz.as3.pcc.chessboard.controller
{
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.command.SimpleCommand;

	/**
	 * Prepares the model of the application
	 *
	 * @author Robin Heinel
	 *
	 */
	public class PrepareModelCommand extends SimpleCommand
	{
		override public function execute(notification:INotification):void
		{
		}
	}
}