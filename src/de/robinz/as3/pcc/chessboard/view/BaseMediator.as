package de.robinz.as3.pcc.chessboard.view
{
import de.robinz.as3.pcc.chessboard.ApplicationFacade;
import de.robinz.as3.pcc.chessboard.library.common.LoggerFactory;
import de.robinz.as3.pcc.chessboard.library.common.ReflectionUtil;
import de.robinz.as3.pcc.chessboard.library.vo.PanelVO;
import de.robinz.as3.pcc.chessboard.library.vo.PanelVOCollection;
import de.robinz.as3.pcc.chessboard.tests.ApplicationTest;
import de.robinz.as3.pcc.chessboard.view.views.ApplicationView;
import de.robinz.as3.pcc.chessboard.view.views.Chessboard;

import flash.events.Event;

import flash.events.MouseEvent;

import flash.utils.getQualifiedClassName;

import flexunit.framework.TestSuite;

import mx.containers.Panel;
import mx.core.Container;

import mx.logging.ILogger;

import mx.logging.Log;

import org.puremvc.as3.interfaces.INotification;
import org.puremvc.as3.patterns.mediator.Mediator;

/**
 * ApplicationMediator
 *
 * @author robin heinel
 */
public class BaseMediator extends Mediator
{
	protected var log : ILogger;

	public function BaseMediator( name : String, view : Object ) {
		super( name, view );

		this.log = Log.getLogger( name );
	}

	// Start Innerclass Methods

	// End Innerclass Methods


	// Start Notification Delegates

	public override function listNotificationInterests() : Array {
		log.warn(  "{0} has no impl of listNotificationInterests!", getQualifiedClassName( this ) );
		return [
		];
	}

	public override function handleNotification( n : INotification ) : void {
		log.warn(  "{0} has no impl if handleNotification!", getQualifiedClassName( this ) );
		switch( n.getName() ) {
		}
	}

	// End Notification Delegates


	// Start Notification Handlers

	// End Notification Handlers


	// Start Event Handlers

	// End Event Handlers


	// Start Getter / Setters

	// End Getter / Setters
}
}