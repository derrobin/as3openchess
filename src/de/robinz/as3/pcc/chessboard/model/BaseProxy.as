package de.robinz.as3.pcc.chessboard.model {
import de.robinz.as3.pcc.chessboard.library.common.LoggerFactory;

import mx.logging.ILogger;

import org.puremvc.as3.interfaces.IProxy;
import org.puremvc.as3.patterns.proxy.Proxy;

/**
 * de.robinz.as3.pcc.chessboard.model
 *
 * @author robin heinel
 */
public class BaseProxy extends Proxy implements IProxy {
	protected var log : ILogger;

	public function BaseProxy( name : String, data : Object = null ) {
		super( name, data );

		this.log = LoggerFactory.getLogger( this.getProxyName() );
	}

	// Start proxy overrides

	public override function getProxyName() : String {
		throw new Error( "forbidden, u have to override!" );
	}

	// End proxy overrides

}
}