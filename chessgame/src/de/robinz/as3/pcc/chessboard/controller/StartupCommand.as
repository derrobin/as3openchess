package de.robinz.as3.pcc.chessboard.controller
{
import org.puremvc.as3.patterns.command.MacroCommand;

/**
 * Application startup
 *
 * @author robin heinel
 */
public class StartupCommand extends MacroCommand
{
	// Start MacroCommand overrides

	protected override function initializeMacroCommand() : void {
		addSubCommand( PrepareModelCommand );
		addSubCommand( PrepareViewCommand );
		addSubCommand( InitCommand );
	}

	// End MacroCommand overrides


	// Start Innerclass Methods

	// End Innerclass Methods


	// Start Getter / Setters

	// End Getter / Setters
}
}