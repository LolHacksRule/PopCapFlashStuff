package com.popcap.flash.framework
{
   import com.popcap.flash.bejeweledblitz.Globals;
   import com.popcap.flash.bejeweledblitz.ServerURLResolver;
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
      
      protected var _state:IAppState = null;
      
      private var _dataCallback:Function = null;
      
      private var _dataXML:XML = null;
      
      private var _lastFrame:int = 0;
      
      private var _lastUpdate:int = 0;
      
      private var _updateBuffer:int = 0;
      
      private var _paused:Boolean = false;
      
      private var _commands:Dictionary;
      
      private var _commandBindings:Dictionary;
      
      public function BaseApp(param1:String)
      {
         this._commands = new Dictionary();
         this._commandBindings = new Dictionary();
         super(param1);
      }
      
      public function SetVersionDisplay(param1:String) : void
      {
         var _loc2_:ContextMenu = new ContextMenu();
         _loc2_.hideBuiltInItems();
         var _loc3_:ContextMenuItem = new ContextMenuItem(param1);
         _loc2_.customItems.push(_loc3_);
         contextMenu = _loc2_;
      }
      
      public function LoadData(param1:String, param2:String, param3:Function = null) : void
      {
         this._dataCallback = param3;
         var _loc4_:URLLoader = new URLLoader();
         var _loc5_:String = param1 + ServerURLResolver.resolveUrl(param2 + "data.xml");
         var _loc6_:URLRequest = new URLRequest(_loc5_);
         _loc4_.addEventListener(Event.COMPLETE,this.HandleDataSuccess,false,0,true);
         _loc4_.addEventListener(IOErrorEvent.IO_ERROR,this.HandleDataFailure,false,0,true);
         _loc4_.load(_loc6_);
      }
      
      public function Start(param1:IAppState) : void
      {
         this._state = param1;
         if(this._state == null)
         {
            return;
         }
         stage.addEventListener(KeyboardEvent.KEY_UP,this.HandleKeyUp,false,0,true);
         stage.addEventListener(KeyboardEvent.KEY_DOWN,this.HandleKeyDown,false,0,true);
         this._state.onEnter();
         this._lastFrame = getTimer();
         this._lastUpdate = getTimer();
         addEventListener(Event.ENTER_FRAME,this.HandleFrame,false,0,true);
      }
      
      public function Stop() : void
      {
         this._state = null;
         stage.removeEventListener(KeyboardEvent.KEY_UP,this.HandleKeyUp);
         stage.removeEventListener(KeyboardEvent.KEY_DOWN,this.HandleKeyDown);
         removeEventListener(Event.ENTER_FRAME,this.HandleFrame);
      }
      
      public function RegisterCommand(param1:String, param2:Function) : void
      {
         this._commands[param1] = param2;
      }
      
      public function BindCommand(param1:String, param2:String) : void
      {
         var _loc6_:String = null;
         var _loc7_:String = null;
         var _loc3_:int = KeyCode.GetCodeFromString(param2);
         if(_loc3_ > 0)
         {
            this._commandBindings[_loc3_ << 3] = param1;
            return;
         }
         var _loc4_:Array = param2.split("+");
         var _loc5_:* = 0;
         for each(_loc6_ in _loc4_)
         {
            if((_loc7_ = _loc6_.toUpperCase()) == "CONTROL")
            {
               _loc5_ |= CONTROL_FLAG;
            }
            else if(_loc7_ == "ALT")
            {
               _loc5_ |= ALT_FLAG;
            }
            else if(_loc7_ == "SHIFT")
            {
               _loc5_ |= SHIFT_FLAG;
            }
            else
            {
               _loc3_ = KeyCode.GetCodeFromString(_loc7_);
               if(_loc3_ == 0)
               {
                  return;
               }
            }
         }
         this._commandBindings[_loc3_ << 3 | _loc5_] = param1;
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
      
      protected function doFixedUpdate() : void
      {
         var _loc1_:int = 0;
         while(_loc1_ < this.updatesPerTick)
         {
            if(this._state != null)
            {
               this._state.update();
            }
            _loc1_++;
         }
      }
      
      protected function doVariableUpdate(param1:int) : void
      {
         var _loc2_:int = 0;
         while(_loc2_ < this.updatesPerTick)
         {
            if(this._state != null)
            {
               this._state.draw(param1);
            }
            _loc2_++;
         }
      }
      
      private function toggleQuality() : void
      {
         if(stage.quality == "LOW")
         {
            stage.quality = "MEDIUM";
         }
         else if(stage.quality == "MEDIUM")
         {
            stage.quality = "HIGH";
         }
         else if(stage.quality == "HIGH")
         {
            stage.quality = "LOW";
         }
      }
      
      private function StepUpdates(param1:Array = null) : void
      {
         this._paused = true;
         this.doFixedUpdate();
      }
      
      private function ResumeUpdates(param1:Array = null) : void
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
      
      private function HandleFrame(param1:Event) : void
      {
         var _loc2_:int = getTimer();
         var _loc3_:int = _loc2_ - this._lastFrame;
         this._lastFrame = _loc2_;
         if(!this._paused)
         {
            this._updateBuffer += _loc3_;
            while(this._updateBuffer >= MILLIS_PER_UPDATE)
            {
               this.doFixedUpdate();
               this._updateBuffer -= MILLIS_PER_UPDATE;
            }
         }
         this.doVariableUpdate(_loc3_);
      }
      
      private function HandleDataSuccess(param1:Event) : void
      {
         var _loc6_:XML = null;
         var _loc7_:String = null;
         var _loc8_:String = null;
         var _loc2_:URLLoader = param1.target as URLLoader;
         _loc2_.removeEventListener(Event.COMPLETE,this.HandleDataSuccess);
         _loc2_.removeEventListener(IOErrorEvent.IO_ERROR,this.HandleDataFailure);
         var _loc3_:XML = new XML(param1.target.data);
         this._dataXML = _loc3_;
         var _loc4_:int = _loc3_.commands.bind.length();
         var _loc5_:int = 0;
         while(_loc5_ < _loc4_)
         {
            _loc7_ = (_loc6_ = _loc3_.commands.bind[_loc5_]).toString();
            _loc8_ = _loc6_.@keyCombo;
            this.BindCommand(_loc7_,_loc8_);
            _loc5_++;
         }
         if(this._dataCallback != null)
         {
            this._dataCallback(true);
         }
      }
      
      private function HandleDataFailure(param1:IOErrorEvent) : void
      {
         var _loc2_:URLLoader = param1.target as URLLoader;
         _loc2_.removeEventListener(Event.COMPLETE,this.HandleDataSuccess);
         _loc2_.removeEventListener(IOErrorEvent.IO_ERROR,this.HandleDataFailure);
         if(this._dataCallback != null)
         {
            this._dataCallback(false);
         }
      }
      
      private function HandleKeyUp(param1:KeyboardEvent) : void
      {
      }
      
      private function HandleKeyDown(param1:KeyboardEvent) : void
      {
         var _loc4_:* = 0;
         var _loc5_:String = null;
         var _loc6_:Function = null;
         var _loc2_:XML = this.GetProperties();
         var _loc3_:Boolean = _loc2_ != null && _loc2_.commands.enabled == "true";
         if(_loc3_)
         {
            _loc4_ = param1.keyCode << 3;
            if(param1.ctrlKey)
            {
               _loc4_ |= CONTROL_FLAG;
            }
            if(param1.altKey)
            {
               _loc4_ |= ALT_FLAG;
            }
            if(param1.shiftKey)
            {
               _loc4_ |= SHIFT_FLAG;
            }
            _loc5_ = this._commandBindings[_loc4_];
            Globals.keyPress(String(param1.keyCode));
            if(_loc5_ != null)
            {
               if((_loc6_ = this._commands[_loc5_]) != null)
               {
                  _loc6_();
               }
            }
         }
      }
   }
}
