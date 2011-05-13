package de.robinz.as3.pcc.chessboard.controller
{
import de.robinz.as3.pcc.chessboard.library.common.LoggerFactory;

import de.robinz.as3.pcc.chessboard.library.common.ReflectionUtil;

import de.robinz.as3.pcc.chessboard.model.ApplicationProxy;

import de.robinz.as3.pcc.chessboard.model.GameProxy;
import de.robinz.as3.pcc.chessboard.view.ApplicationMediator;

import de.robinz.as3.pcc.chessboard.view.ChessboardMediator;

import flash.utils.getQualifiedClassName;

import mx.logging.ILogger;
import mx.logging.Log;

import org.puremvc.as3.interfaces.INotification;
import org.puremvc.as3.interfaces.INotifier;
import org.puremvc.as3.patterns.command.SimpleCommand;
import org.puremvc.as3.patterns.observer.Notification;

/**
 * BaseCommand
 *
 * @author robin heinel
 */
public class BaseCommand extends SimpleCommand implements INotifier
{
	protected var log : ILogger = LoggerFactory.getLogger( this, true );

	// Start SimpleCommand overrides

	public override function execute( n : INotification ) : void {
		log.info( "executing.. " );
	}

	// End SimpleCommand overrides


	public override function sendNotification( notificationName : String, body : Object = null, type : String = null ) : void {
		log.info( "sending notification.." );
		var n : Notification = new Notification( notificationName );
		n.setBody( body );
		n.setType( type )
		logNotification( n );

		super.sendNotification( notificationName, body, type );
	}

	private function logNotification( n : INotification ) : void {
		log.debug( "notification-name: " + n.getName() );

		if ( n.getType() != null ) {
			log.debug( "notification-type: " + n.getType() );
		}
		if ( n.getBody() != null ) {
			log.debug( "body-type: " + getQualifiedClassName( n.getBody() ) );
		}
	}

	// Start Getter / Setters

	protected function get appProxy() : ApplicationProxy {
		return this.facade.retrieveProxy( ApplicationProxy.NAME ) as ApplicationProxy;
	}
	protected function get appMediator() : ApplicationMediator {
		return this.facade.retrieveMediator( ApplicationMediator.NAME ) as ApplicationMediator;
	}
	protected function get gameProxy() : GameProxy {
		return this.facade.retrieveProxy( GameProxy.NAME ) as GameProxy;
	}
	protected function get boardMediator() : ChessboardMediator {
		return this.facade.retrieveMediator( ChessboardMediator.NAME ) as ChessboardMediator;
	}
	// End Getter / Setters

}
}