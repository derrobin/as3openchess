////////////////////////////////////////////////////////////////////////////////
//
//  Copyright (C) 2003-2006 Adobe Macromedia Software LLC and its licensors.
//  All Rights Reserved. The following is Source Code and is subject to all
//  restrictions on such code as contained in the End User License Agreement
//  accompanying this product.
//
////////////////////////////////////////////////////////////////////////////////

package mx.events
{

/**
 *  The InvalidateRequestData class defines constants for the values 
 *  of the <code>data</code> property of a SWFBridgeRequest object when
 *  used with the <code>SWFBridgeRequest.INVALIDATE_REQUEST</code> request.
 */
public final class InvalidateRequestData
{
	include "../core/Version.as";

	//--------------------------------------------------------------------------
	//
	//  Class constants
	//
	//--------------------------------------------------------------------------

    //----------------------------------
    //  INVALIDATE request bits
    //----------------------------------

    /**
     *  Bit to indicate the request handler should invalidate
     *  their properties.
     */
    public static const PROPERTIES:uint = 0x0002;
    
    /**
     *  Bit to indicate the request handler should invalidate
     *  their size.
     */
    public static const SIZE:uint = 0x0004;

    /**
     *  Bit to indicate the request handler should invalidate
     *  their display list.
     */
    public static const DISPLAY_LIST:uint = 0x0001;
}

}
