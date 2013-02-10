// Common Functions

/* Gibt URL des aktuellen Dokumentes zurueck.
*/

function getLocation() {
	return document.location.href;
}

function urlParam( name )
{
	name = name.replace(/[\[]/,"\\\[").replace(/[\]]/,"\\\]");
	var regexS = "[\\?&]"+name+"=([^&#]*)";
	var regex = new RegExp( regexS );
	var results = regex.exec( getLocation() );
	if( results == null )
		return "";
	else
		return results[1];
}

function maxWindow() {
	if (isWindowTooSmall())
	{
		var msg = "An error occurred. The resolution of your browser window is to low.\n" +
			"This application needs a minimum size of 1024x768px.\n\n" +
			"Es ist ein Fehler aufgetreten. Die Größe ihres Browserfensters ist zu gering.\n" +
			"Diese Anwendung benötigt eine Mindestgröße von 1024x768px.";

		alert(msg);

		window.moveTo(0,0);
		if (document.all)
		{
			top.window.resizeTo(screen.availWidth,screen.availHeight);
		}
		else
		{
			if (document.layers || document.getElementById)
			{
				if (top.window.outerHeight < screen.availHeight || top.window.outerWidth < screen.availWidth)
				{
					top.window.outerHeight = screen.availHeight;
					top.window.outerWidth = screen.availWidth;
				}
			}
		}
	}
}

function isWindowTooSmall() {
	var viewportwidth = 0;
	var viewportheight = 0;

	if (typeof(window.innerWidth) == 'number')
	{
		viewportwidth = window.innerWidth,
		viewportheight = window.innerHeight
	}
	else if (document.documentElement && (document.documentElement.clientWidth || document.documentElement.clientHeight))
	{
				viewportwidth = document.documentElement.clientWidth,
				viewportheight = document.documentElement.clientHeight
	}
	else if (document.body && (document.body.clientWidth || document.body.clientHeight))
	{
		viewportwidth = document.body.clientWidth,
		viewportheight = document.body.clientHeight
	}

	if (viewportwidth < 860 || viewportheight < 560)
		return true;

	return false;
}

