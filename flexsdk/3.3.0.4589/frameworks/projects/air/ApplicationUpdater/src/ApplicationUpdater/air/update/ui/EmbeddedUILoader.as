/*
ADOBE SYSTEMS INCORPORATED
Copyright 2008 Adobe Systems Incorporated. All Rights Reserved.
 
NOTICE:   Adobe permits you to modify and distribute this file only in accordance with
the terms of Adobe AIR SDK license agreement.  You may have received this file from a
source other than Adobe.  Nonetheless, you may modify or distribute this file only in 
accordance with such agreement.
*/

package air.update.ui
{
	import air.update.logging.Logger;
	
	import flash.desktop.NativeApplication;
	import flash.display.Loader;
	import flash.display.NativeWindow;
	import flash.display.NativeWindowInitOptions;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.system.ApplicationDomain;
	import flash.system.Capabilities;
	import flash.system.LoaderContext;
	import flash.utils.ByteArray;
	//
	
	[Event(name="complete", type="flash.events.Event")]
	[Event(name="ioError", type="flash.events.IOErrorEvent")]
	
	[ExcludeClass]
	public class EmbeddedUILoader extends EventDispatcher
	{
		private static var logger:Logger = Logger.getLogger("air.update.ui.EmbeddedUILoader");
		
		[Embed(source="/assets/ApplicationUpdaterDialogs.swf", mimeType="application/octet-stream")]
		private var DialogBytes:Class;		
		
		private var uiPath:String;
		private var loader:Loader;
		private var appUpdater:UpdaterUI;
		private var applicationDialogs:Object;
		private var uiWindow:NativeWindow;
		private var _initialized:Boolean;
		private var isExiting:Boolean;
		
		public function EmbeddedUILoader()
		{
			watchOpenedWindows();
			// add listener to Exiting to handle Cmd-Q on MacOSX
			// add biggest priority in order to close the window before a CLOSING event gets sent because
			// of the recommended way of handling the exiting event http://livedocs.adobe.com/flex/3/html/app_launch_1.html#1036875
			NativeApplication.nativeApplication.addEventListener(Event.EXITING, onExiting, false, int.MAX_VALUE);
		}
		
		public function set applicationUpdater(value:UpdaterUI):void
		{
			appUpdater = value;
		}
		
		public function load():void {
			if (loader != null) return;
			loader = new Loader();
			// dispatched when UI swf (not the application) is loaded
			loader.contentLoaderInfo.addEventListener(Event.INIT, onUILoadInit);
			loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, onUILoadError);
			//
			var dlgBytes:ByteArray = (new DialogBytes() as ByteArray);
			if (dlgBytes.length == 0) {
				dispatchEvent(new IOErrorEvent(IOErrorEvent.IO_ERROR));
				return;
			}
			var ctx:LoaderContext = new LoaderContext(false,ApplicationDomain.currentDomain);
			ctx.allowLoadBytesCodeExecution = true;
			showWindow();
			loader.loadBytes(dlgBytes, ctx);
		}
		
		private function watchOpenedWindows():void
		{
			logger.fine("Check opened windows");
			for (var i:uint = 0; i < NativeApplication.nativeApplication.openedWindows.length; i++)
			{
				var win:NativeWindow = NativeApplication.nativeApplication.openedWindows[i];
				logger.fine("Opened window [" + i + "] " + (win.title ? win.title : "-- no title --"));
				if (win == uiWindow) continue;
				win.removeEventListener(Event.CLOSE, onWindowClose);
				//@TODO: Check if a closed window in openedWindows ??
				if (!win.closed) 
				{
					win.addEventListener(Event.CLOSE, onWindowClose);
				}
			}
		}
		
		private function removeCloseListeners():void 
		{
			for (var i:uint = 0; i < NativeApplication.nativeApplication.openedWindows.length; i++) 
			{
				var win:NativeWindow = NativeApplication.nativeApplication.openedWindows[i];
				win.removeEventListener(Event.CLOSE, onWindowClose);
			}
		}
		
		private function onWindowClose(e:Event):void
		{
			if (uiWindow != null && !uiWindow.closed && NativeApplication.nativeApplication.openedWindows.length == 1)
			{
				logger.fine("UpdateUI is last window standing. Action: Close & Exit");
				onExiting(e);
			} else {
				watchOpenedWindows();
			}
		}
		
		private function onExiting(event:Event):void
		{
			logger.fine("Exiting: " + uiWindow);	
			isExiting = true;
			if (uiWindow != null && !uiWindow.closed) 
			{
				if (this.appUpdater.currentState != "PENDING_INSTALLING") this.appUpdater.cancelUpdate();				
				uiWindow.close();
				uiWindow = null;
				//NativeApplication.nativeApplication.exit();
			}
		}
		
		public function unload():void
		{
			logger.fine("unload " + uiWindow);
			appUpdater.cancelUpdate();
			applicationDialogs.setApplicationUpdater(null);
			if (uiWindow != null && !uiWindow.closed) 
			{
				uiWindow.close();
				uiWindow = null;
				//NativeApplication.nativeApplication.exit();
			}			
		}
		
		private function onUILoadError(event:Event):void
		{
			logger.severe("SWF Loading complete");
			dispatchEvent(event);
		}
		
		private function onUILoadInit(event:Event):void
		{
			logger.fine("SWF Loading complete. Waiting for ApplicationComplete");
			// using the string name directly to avoid dependency on Flex framework
			// dispatched when the application UI is loaded
			loader.content.addEventListener("applicationComplete", onUIApplicationComplete);
		}

		private function onUIApplicationComplete(event:Event):void
		{
			logger.fine("Application loading complete.");
			applicationDialogs = (event.target as Object).application;
			applicationDialogs.setApplicationUpdater(appUpdater);
			_initialized = true;
			dispatchEvent(new Event(Event.COMPLETE));
		}
		
		public function get initialized():Boolean
		{
			return _initialized;
		}
		
		public function showWindow():void
		{
			if (uiWindow != null) {
				logger.fine("window already created");
				return;
			}
			isExiting = false;
			logger.fine("Creating UI window");
			var screenX:Number = Capabilities.screenResolutionX;
			var screenY:Number = Capabilities.screenResolutionY;
			// create window (hidden)
			var options:NativeWindowInitOptions = new NativeWindowInitOptions();
			options.resizable = false;  
			options.maximizable = false;
			uiWindow = new NativeWindow(options);
			uiWindow.addEventListener(Event.CLOSING, function (evt:Event):void {
				
				logger.fine("Closing UI window." + (isExiting ? " Exiting" : " Not exiting, just hide"));
				// if not exiting, do not actually close the window
				if (!isExiting)
				{
					evt.preventDefault();
				} else {
					uiWindow = null;	
				}
				// cancel anyway if the window was about to be closed
				// except when in PENDING_INSTALLING state
				if (appUpdater.currentState != "PENDING_INSTALLING") appUpdater.cancelUpdate();			
			});
			//uiWindow.alwaysInFront = true;
			uiWindow.visible = false;
			//uiWindow.x = (screenX - uiWindow.width) / 2;
			//uiWindow.y = (screenY - uiWindow.height) / 2;
			uiWindow.width = 1024;
			uiWindow.height = 800;
			uiWindow.x = (screenX - 530) / 2;
			uiWindow.y = (screenY - 230) / 2;
			uiWindow.stage.align = StageAlign.TOP_LEFT;
			uiWindow.stage.scaleMode = StageScaleMode.NO_SCALE;
			//
			uiWindow.stage.addChild(loader);
		}
		
		public function hideWindow():void
		{
			logger.fine("Hide window");
			if (uiWindow != null) 
			{
				uiWindow.visible = false;
			}	
		}
		
		public function setLocaleChain(locale:Array):void
		{
			if (applicationDialogs != null) {
				applicationDialogs.setLocaleChain(locale);
			}
		}

		public function getLocaleChain():Array
		{
			if (applicationDialogs == null) {
				return [];
			}
			return applicationDialogs.getLocaleChain();
		}

		public function addResources(lang:String, res:Object):void
		{
			if (applicationDialogs != null) {
				applicationDialogs.addResources(lang, res);
			}
		}
		
		/** TEST-ONLY for generating UI screens */
		/*
		public function get _applicationDialogs():Object{
			return applicationDialogs;
		}
		*/
		
	}
}