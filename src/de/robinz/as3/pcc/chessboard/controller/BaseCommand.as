package de.robinz.as3.pcc.chessboard.controller
{
import de.robinz.as3.pcc.chessboard.library.common.LoggerFactory;

import de.robinz.as3.pcc.chessboard.library.common.ReflectionUtil;

import de.robinz.as3.pcc.chessboard.model.ApplicationProxy;

import de.robinz.as3.pcc.chessboard.view.ApplicationMediator;

import flash.utils.getQualifiedClassName;

import mx.logging.ILogger;
import mx.logging.Log;

import org.puremvc.as3.interfaces.INotification;
import org.puremvc.as3.patterns.command.SimpleCommand;

/**
 * BaseCommand
 *
 * @author robin heinel
 */
public class BaseCommand extends SimpleCommand
{
	protected var log : ILogger = LoggerFactory.getLogger( this );

	// Start SimpleCommand overrides

	public override function execute( n : INotification ) : void {
		log.info( "executing.. " );
		log.debug( "notification-name: " + n.getName() );

		if ( n.getType() != null ) {
			log.debug( "notification-type: " + n.getType() );
		}
		if ( n.getBody() != null ) {
			log.debug( "body-type: " + getQualifiedClassName( n.getBody() ) );
		}

	}

	// End SimpleCommand overrides

	// Start Getter / Setters

	protected function get appProxy() : ApplicationProxy {
		return this.facade.retrieveProxy( ApplicationProxy.NAME ) as ApplicationProxy;
	}
	protected function get appMediator() : ApplicationMediator {
		return this.facade.retrieveMediator( ApplicationMediator.NAME ) as ApplicationMediator;
	}

	// End Getter / Setters

}
}