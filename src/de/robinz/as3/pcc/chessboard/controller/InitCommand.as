package de.robinz.as3.pcc.chessboard.controller
{
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.command.SimpleCommand;

	/**
	 * Application initialization
	 *
	 * @author Robin Heinel
	 *
	 */
	public class InitCommand extends SimpleCommand
	{
		public override function execute( note : INotification ) : void {
		}

	}
}