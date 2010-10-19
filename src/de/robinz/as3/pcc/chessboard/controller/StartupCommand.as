package de.robinz.as3.pcc.chessboard.controller
{
	import org.puremvc.as3.patterns.command.MacroCommand;

	/**
	 * Application startup
	 *
	 * @author Robin Heinel
	 *
	 */
	public class StartupCommand extends MacroCommand
	{
		override protected function initializeMacroCommand():void
		{
			addSubCommand( PrepareModelCommand );
			addSubCommand( PrepareViewCommand );
			addSubCommand( InitCommand );
		}
	}
}