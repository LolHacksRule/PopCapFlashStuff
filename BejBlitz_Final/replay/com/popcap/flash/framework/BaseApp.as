package com.popcap.flash.framework
{
   import com.popcap.flash.framework.keyboard.KeyCode;
   import flash.display.Stage;
   import flash.events.Event;
   import flash.events.IOErrorEvent;
   import flash.events.KeyboardEvent;
   import flash.net.URLLoader;
   import flash.net.URLRequest;
   import flash.ui.ContextMenu;
   import flash.ui.ContextMenuItem;
   import flash.utils.Dictionary;
   import flash.utils.getTimer;
   
   public class BaseApp extends App implements IApp
   {
      
      public static const MILLIS_PER_UPDATE:int = 10;
      
      private static const CONTROL_FLAG:int = 1;
      
      private static const ALT_FLAG:int = 2;
      
      private static const SHIFT_FLAG:int = 4;
       
      
      public var updatesPerTick:int = 1;
      
      private var _dataCallback:Function = null;
      
      private var _dataXML:XML = null;
      
      private var _lastFrame:int = 0;
      
      private var _lastUpdate:int = 0;
      
      private var _updateBuffer:int = 0;
      
      private var _paused:Boolean = false;
      
      private var _state:IAppState = null;
      
      private var _commands:Dictionary;
      
      private var _commandBindings:Dictionary;
      
      public function BaseApp(versionName:String)
      {
         this._commands = new Dictionary();
         this._commandBindings = new Dictionary();
         super(versionName);
      }
      
      public function SetVersionDisplay(versionString:String) : void
      {
         var menu:ContextMenu = new ContextMenu();
         menu.hideBuiltInItems();
         var versionItem:ContextMenuItem = new ContextMenuItem(versionString);
         menu.customItems.push(versionItem);
         contextMenu = menu;
      }
      
      public function LoadData(pathPrefix:String, callback:Function = null) : void
      {
         this._dataCallback = callback;
         this.RegisterCommand("StepUpdates",this.StepUpdates);
         this.RegisterCommand("ResumeUpdates",this.ResumeUpdates);
         this.RegisterCommand("IncUpdatesPerTick",this.IncUpdatesPerTick);
         this.RegisterCommand("DecUpdatesPerTick",this.DecUpdatesPerTick);
         var loader:URLLoader = new URLLoader();
         var dataURL:URLRequest = new URLRequest(pathPrefix + "data.xml");
         loader.addEventListener(Event.COMPLETE,this.HandleDataSuccess);
         loader.addEventListener(IOErrorEvent.IO_ERROR,this.HandleDataFailure);
         loader.load(dataURL);
      }
      
      public function Start(state:IAppState) : void
      {
         this._state = state;
         if(this._state == null)
         {
            return;
         }
         stage.addEventListener(KeyboardEvent.KEY_UP,this.HandleKeyUp);
         stage.addEventListener(KeyboardEvent.KEY_DOWN,this.HandleKeyDown);
         this._state.onEnter();
         this._lastFrame = getTimer();
         this._lastUpdate = getTimer();
         addEventListener(Event.ENTER_FRAME,this.HandleFrame);
      }
      
      public function Stop() : void
      {
         this._state = null;
         stage.removeEventListener(KeyboardEvent.KEY_UP,this.HandleKeyUp);
         stage.removeEventListener(KeyboardEvent.KEY_DOWN,this.HandleKeyDown);
         removeEventListener(Event.ENTER_FRAME,this.HandleFrame);
      }
      
      public function RegisterCommand(command:String, callback:Function) : void
      {
         this._commands[command] = callback;
      }
      
      public function BindCommand(command:String, keyCombo:String) : void
      {
         var piece:String = null;
         var matcher:String = null;
         var code:int = KeyCode.GetCodeFromString(keyCombo);
         if(code > 0)
         {
            this._commandBindings[code << 3] = command;
            return;
         }
         var pieces:Array = keyCombo.split("+");
         var modifiers:int = 0;
         for each(piece in pieces)
         {
            matcher = piece.toUpperCase();
            if(matcher == "CONTROL")
            {
               modifiers |= CONTROL_FLAG;
            }
            else if(matcher == "ALT")
            {
               modifiers |= ALT_FLAG;
            }
            else if(matcher == "SHIFT")
            {
               modifiers |= SHIFT_FLAG;
            }
            else
            {
               code = KeyCode.GetCodeFromString(matcher);
               if(code == 0)
               {
                  return;
               }
            }
         }
         this._commandBindings[code << 3 | modifiers] = command;
      }
      
      public function GetProperties() : XML
      {
         return this._dataXML;
      }
      
      public function isPaused() : Boolean
      {
         return this._paused;
      }
      
      public function getStage() : Stage
      {
         return stage;
      }
      
      private function doFixedUpdate() : void
      {
         for(var j:int = 0; j < this.updatesPerTick; j++)
         {
            if(this._state != null)
            {
               this._state.update();
            }
         }
      }
      
      private function doVariableUpdate(elapsed:int) : void
      {
         for(var i:int = 0; i < this.updatesPerTick; i++)
         {
            if(this._state != null)
            {
               this._state.draw(elapsed);
            }
         }
      }
      
      private function StepUpdates(args:Array = null) : void
      {
         this._paused = true;
         this.doFixedUpdate();
      }
      
      private function ResumeUpdates(args:Array = null) : void
      {
         this._paused = false;
      }
      
      private function IncUpdatesPerTick() : void
      {
         ++this.updatesPerTick;
         if(this.updatesPerTick > 4)
         {
            this.updatesPerTick = 4;
         }
      }
      
      private function DecUpdatesPerTick() : void
      {
         --this.updatesPerTick;
         if(this.updatesPerTick < 1)
         {
            this.updatesPerTick = 1;
         }
      }
      
      private function HandleFrame(e:Event) : void
      {
         var thisTime:int = getTimer();
         var elapsed:int = thisTime - this._lastFrame;
         this._lastFrame = thisTime;
         if(!this._paused)
         {
            this._updateBuffer += elapsed;
            while(this._updateBuffer >= MILLIS_PER_UPDATE)
            {
               this.doFixedUpdate();
               this._updateBuffer -= MILLIS_PER_UPDATE;
            }
         }
         this.doVariableUpdate(elapsed);
      }
      
      private function HandleDataSuccess(e:Event) : void
      {
         var bind:XML = null;
         var command:String = null;
         var keyCombo:String = null;
         var loader:URLLoader = e.target as URLLoader;
         loader.removeEventListener(Event.COMPLETE,this.HandleDataSuccess);
         var xml:XML = new XML(e.target.data);
         this._dataXML = xml;
         var numBindings:int = xml.commands.bind.length();
         for(var i:int = 0; i < numBindings; i++)
         {
            bind = xml.commands.bind[i];
            command = bind.toString();
            keyCombo = bind.@keyCombo;
            this.BindCommand(command,keyCombo);
         }
         if(this._dataCallback != null)
         {
            this._dataCallback(true);
         }
      }
      
      private function HandleDataFailure(e:IOErrorEvent) : void
      {
         var loader:URLLoader = e.target as URLLoader;
         loader.removeEventListener(Event.COMPLETE,this.HandleDataSuccess);
         if(this._dataCallback != null)
         {
            this._dataCallback(false);
         }
      }
      
      private function HandleKeyUp(e:KeyboardEvent) : void
      {
         if(this._state != null)
         {
            this._state.onKeyUp(e.keyCode);
         }
      }
      
      private function HandleKeyDown(e:KeyboardEvent) : void
      {
         var code:int = 0;
         var key:String = null;
         var command:Function = null;
         var props:XML = this.GetProperties();
         var commandsEnabled:Boolean = props != null && props.commands.enabled == "true";
         if(commandsEnabled)
         {
            code = e.keyCode << 3;
            if(e.ctrlKey)
            {
               code |= CONTROL_FLAG;
            }
            if(e.altKey)
            {
               code |= ALT_FLAG;
            }
            if(e.shiftKey)
            {
               code |= SHIFT_FLAG;
            }
            key = this._commandBindings[code];
            if(key != null)
            {
               command = this._commands[key];
               if(command != null)
               {
                  command();
               }
            }
         }
         if(this._state != null)
         {
            this._state.onKeyDown(e.keyCode);
         }
      }
   }
}
