package de.robinz.as3.pcc.chessboard.model
{
import flash.utils.Dictionary;

import org.puremvc.as3.patterns.proxy.Proxy;

/**
 * ApplicationProxy
 *
 * @author robin heinel
 */
public class ApplicationProxy extends Proxy
{
	public static const NAME : String = "ApplicationProxy";

	private var _openPanels : Dictionary;
	private var _openDialogs : Dictionary;

	public function ApplicationProxy( data : Object = null ) {
		super( NAME, data );
		this._openDialogs = new Dictionary( true );
		this._openPanels = new Dictionary( true );
	}


	// Start proxy overrides

	public override function getProxyName() : String {
		return NAME;
	}

	// End proxy overrides


	// Start Proxy Interface

	public function isPanelOpen( mediatorName : String ) : Boolean {
		if ( this._openPanels[ mediatorName ] == null ) {
			return false;
		}
		return this._openPanels[ mediatorName ] as Boolean;
	}

	public function openPanel( mediatorName : String ) : void {
		this._openPanels[ mediatorName ] = true;
	}

	public function closePanel( mediatorName : String ) : void {
		this._openPanels[ mediatorName ] = false;
	}

	public function isDialogOpen( mediatorName : String ) : Boolean {
		if ( this._openDialogs[ mediatorName ] == null ) {
			return false;
		}
		return this._openDialogs[ mediatorName ] as Boolean;
	}

	public function openDialog( mediatorName : String ) : void {
		this._openDialogs[ mediatorName ] = true;
	}

	public function closeDialog( mediatorName : String ) : void {
		this._openDialogs[ mediatorName ] = false;
	}

	// End Proxy Interface


	// Start Innerclass Methods

	// End Innerclass Methods


	// Start Getter / Setters

	// End Getter / Setters
}
}