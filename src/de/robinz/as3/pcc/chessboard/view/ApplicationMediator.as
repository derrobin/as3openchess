package de.robinz.as3.pcc.chessboard.view
{
	import org.puremvc.as3.patterns.mediator.Mediator;

	/**
	 * Application startup
	 *
	 * @author Robin Heinel
	 *
	 */
	public class ApplicationMediator extends Mediator
	{
		public static const NAME : String = "ApplicationMediator";

		public function ApplicationMediator( viewComponent : chessboard )
		{
			super( NAME, viewComponent );
		}

	}
}