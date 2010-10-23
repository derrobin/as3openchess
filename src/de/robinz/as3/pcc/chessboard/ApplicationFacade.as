package de.robinz.as3.pcc.chessboard
{
	import de.robinz.as3.pcc.chessboard.controller.StartupCommand;
	import org.puremvc.as3.patterns.facade.Facade;

	/**
	 * Application startup
	 *
	 * @author Robin Heinel
	 *
	 */
	public class ApplicationFacade extends Facade
	{
		public static const STARTUP : String 	= "STARTUP";

		public static function getInstance() : ApplicationFacade {
			if ( ! instance ) {
				instance = new ApplicationFacade();
			}
			return instance as ApplicationFacade;
		}

		protected override function initializeController() : void {
			super.initializeController();
			registerCommand( STARTUP, StartupCommand );
		}

		public function startup( app : chessboard ) : void {
			sendNotification( STARTUP, app );
		}

	}
}