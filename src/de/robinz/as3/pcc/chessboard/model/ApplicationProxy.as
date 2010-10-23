package de.robinz.as3.pcc.chessboard.model
{
	import org.puremvc.as3.patterns.proxy.Proxy;

	/**
	 * Application startup
	 *
	 * @author Robin Heinel

	 */
	public class ApplicationProxy extends Proxy
	{
		public static const NAME : String = "ApplicationProxy";

		public function ApplicationProxy( data : Object = null ) {
			super( NAME, data );
		}

		public override function getProxyName() : String {
			return NAME;
		}
	}
}