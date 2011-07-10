package de.robinz.as3.pcc.chessboard.model
{
import de.robinz.as3.pcc.chessboard.library.vo.BoardSettingsVO;
import de.robinz.as3.pcc.chessboard.library.vo.ColorSettingsVO;

import flash.utils.Dictionary;

/**
 * ApplicationProxy
 *
 * @author robin heinel
 */
public class ApplicationProxy extends BaseProxy
{
	public static const NAME : String = "ApplicationProxy";

	private var _openPanels : Dictionary;
	private var _openDialogs : Dictionary;

	private var _colors : ColorSettingsVO;
	private var _board : BoardSettingsVO;

	public function ApplicationProxy( data : Object = null ) {
		super( NAME, data );

		this._openDialogs = new Dictionary( true );
		this._openPanels = new Dictionary( true );

		this.initColors();
		this.initBoard();
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

	private function initColors() : void {
		this._colors = new ColorSettingsVO();
	}

	private function initBoard() : void {
		this._board = new BoardSettingsVO();
		this._board.fixedSize = true;
		this._board.size = 450;
		this._board.horizontalAlign = "left";
		this._board.verticalAlign = "top";
	}

	// End Innerclass Methods


	// Start Getter / Setters

	public function getOpenDialogs() : Dictionary {
		return this._openDialogs;
	}

	public function getOpenPanels() : Dictionary {
		return this._openPanels;
	}


	public function set board( value : BoardSettingsVO ) : void {
		this._board = value;
	}
	public function get board() : BoardSettingsVO {
		return this._board;
	}

	public function set colors( value : ColorSettingsVO ) : void {
		this._colors = value;
	}
	public function get colors() : ColorSettingsVO {
		return this._colors;
	}

	// End Getter / Setters
}
}