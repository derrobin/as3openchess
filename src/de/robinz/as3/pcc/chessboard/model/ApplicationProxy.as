package de.robinz.as3.pcc.chessboard.model
{
import de.robinz.as3.pcc.chessboard.library.ColorTheme;
import de.robinz.as3.pcc.chessboard.library.vo.BoardSettingsVO;
import de.robinz.as3.pcc.chessboard.library.vo.ColorSettingsVO;

import de.robinz.as3.pcc.chessboard.library.ColorTheme;

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
	private var _colorThemes : Dictionary;

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

	public function getColorTheme( colorThemeKey : String ) : ColorTheme {
		return  this._colorThemes[ colorThemeKey ] as ColorTheme;
	}

	private function addColorTheme( key : String, name : String, colors : ColorSettingsVO ) : void {
		this._colorThemes[ key ] = ColorTheme.create( key, name, colors );
	}

	private function initColors() : void {
		this._colorThemes = new Dictionary( true );

//		this._colorThemes[ ColorTheme.BLUE_WATER ]      = ColorTheme.create( "blue water",      ColorSettingsVO.create(  3355596,   3368601,    3368601,   16777215,   0x00CCFF,   0x0099FF,   3355443,    13158,  16777215,   16777215,   0,   0,  16777215 ) );
//		this._colorThemes[ ColorTheme.GREEN_MEN ]       = ColorTheme.create( "green men",       ColorSettingsVO.create(    26112,     26112,   10066329,   16777215,   16777113,   16777164,   3355443,    39168,  16777215,   16777215,   0,   0,  16777215 ) );
//		this._colorThemes[ ColorTheme.PINK_LADY ]       = ColorTheme.create( "pink lady",       ColorSettingsVO.create( 16737945,  10027059,   16751052,   16777215,   0xFFFF99,   0xFFFFCC,   3355443, 10027059,  16777215,   16764159,   0,   0,  13421772 ) );
//		this._colorThemes[ ColorTheme.WHITE_PURE ]      = ColorTheme.create( "white pure",      ColorSettingsVO.create( 16777215,  16777215,   13421772,   16777215,   0x666666,   10066329,   3355443, 16777215,         0,   16777215,   0,   0,  13421772 ) );
//		this._colorThemes[ ColorTheme.BLACK_ON_WHITE]   = ColorTheme.create( "black on white",  ColorSettingsVO.create( 16777215,  16777215,          0,   13421772,   0xFFFFFF,   10066329,   3355443,        0,  16777215,   16777215,   0,   0,  16777215 ) );
//		this._colorThemes[ ColorTheme.WHITE_ON_BLACK ]  = ColorTheme.create( "white on black",  ColorSettingsVO.create(        0,  16777215,   13421772,   16777215,    6710886,   10066329,   3355443, 16777215,         0,   16777215,   0,   0,  13421772 ) );


		this.addColorTheme( ColorTheme.BLUE_WATER,      "blue water",       ColorSettingsVO.create(  3355596,   3368601,    3368601,   16777215,   0x00CCFF,   0x0099FF,   3355443,    13158,  16777215,   16777215,   0,   0,  16777215 ) );
		this.addColorTheme( ColorTheme.GREEN_MEN,       "green men",        ColorSettingsVO.create(    26112,     26112,   10066329,   16777215,   16777113,   16777164,   3355443,    39168,  16777215,   16777215,   0,   0,  16777215 ) );
		this.addColorTheme( ColorTheme.PINK_LADY,       "pink lady",        ColorSettingsVO.create( 16737945,  10027059,   16751052,   16777215,   0xFFFF99,   0xFFFFCC,   3355443, 10027059,  16777215,   16764159,   0,   0,  13421772 ) );
		this.addColorTheme( ColorTheme.WHITE_PURE,      "white pure",       ColorSettingsVO.create( 16777215,  16777215,   13421772,   16777215,   0x666666,   10066329,   3355443, 16777215,         0,   16777215,   0,   0,  13421772 ) );
		this.addColorTheme( ColorTheme.BLACK_ON_WHITE,  "black on white",   ColorSettingsVO.create( 16777215,  16777215,          0,   13421772,   0xFFFFFF,   10066329,   3355443,        0,  16777215,   16777215,   0,   0,  16777215 ) );
		this.addColorTheme( ColorTheme.WHITE_ON_BLACK,  "white on black",   ColorSettingsVO.create(        0,  16777215,   13421772,   16777215,    6710886,   10066329,   3355443, 16777215,         0,   16777215,   0,   0,  13421772 ) );

		this._colors = this.getColorTheme( ColorTheme.BLUE_WATER ).colors;
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
	public function get colorThemes() : Dictionary {
		return this._colorThemes;
	}

	// End Getter / Setters
}
}