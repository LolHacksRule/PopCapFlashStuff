package com.popcap.flash.framework
{
   import com.popcap.flash.framework.impl.BaseAppPlugin;
   import com.popcap.flash.framework.impl.BaseAppService;
   import com.popcap.flash.framework.input.keyboard.KeyCode;
   import flash.display.Sprite;
   import flash.display.Stage;
   import flash.events.Event;
   import flash.events.IOErrorEvent;
   import flash.events.KeyboardEvent;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import flash.net.URLLoader;
   import flash.net.URLRequest;
   import flash.text.TextField;
   import flash.text.TextFormat;
   import flash.utils.Dictionary;
   import flash.utils.getTimer;
   
   public class BaseApp extends Sprite implements IApp
   {
      
      private static const SHIFT_FLAG:int = 4;
      
      private static const ALT_FLAG:int = 2;
      
      public static const MILLIS_PER_UPDATE:int = 10;
      
      private static const CONTROL_FLAG:int = 1;
       
      
      private var mMouseDownPos:Point;
      
      private var mPaused:Boolean = false;
      
      private var mLastTime:int = 0;
      
      private var mCommands:Dictionary;
      
      private var mState:IAppState = null;
      
      private var mInitialized:Boolean = false;
      
      private var mFPS:Number = 1000.0;
      
      private var mCommandBindings:Dictionary;
      
      private var mIsError:Boolean = false;
      
      private var mDataXML:XML = null;
      
      private var mServicesMap:Dictionary;
      
      private var mPlugins:Vector.<IAppPlugin>;
      
      private var mUpdateBuffer:int = 0;
      
      private var mMouseDown:Boolean = false;
      
      private var mMousePos:Point;
      
      public function BaseApp()
      {
         this.mMousePos = new Point();
         this.mMouseDownPos = new Point();
         this.mCommands = new Dictionary();
         this.mCommandBindings = new Dictionary();
         super();
      }
      
      private function start() : void
      {
         if(this.mIsError)
         {
            return;
         }
         stage.addEventListener(MouseEvent.MOUSE_UP,this.handleMouseUp);
         stage.addEventListener(MouseEvent.MOUSE_DOWN,this.handleMouseDown);
         stage.addEventListener(MouseEvent.MOUSE_MOVE,this.handleMouseMove);
         stage.addEventListener(KeyboardEvent.KEY_UP,this.handleKeyUp);
         stage.addEventListener(KeyboardEvent.KEY_DOWN,this.handleKeyDown);
         this.mState.onEnter();
         this.mLastTime = getTimer();
         stage.addEventListener(Event.ENTER_FRAME,this.handleFrame);
      }
      
      public function GetProperties() : XML
      {
         return this.mDataXML;
      }
      
      public function RegisterCommand(param1:String, param2:Function) : void
      {
         this.mCommands[param1] = param2;
      }
      
      private function stop() : void
      {
         stage.removeEventListener(MouseEvent.MOUSE_UP,this.handleMouseUp);
         stage.removeEventListener(MouseEvent.MOUSE_DOWN,this.handleMouseDown);
         stage.removeEventListener(MouseEvent.MOUSE_MOVE,this.handleMouseMove);
         stage.removeEventListener(KeyboardEvent.KEY_UP,this.handleKeyUp);
         stage.removeEventListener(KeyboardEvent.KEY_DOWN,this.handleKeyDown);
         stage.removeEventListener(Event.ENTER_FRAME,this.handleFrame);
      }
      
      public function registerService(param1:BaseAppPlugin, param2:Vector.<String>, param3:Object, param4:XML) : IAppService
      {
         var _loc6_:String = null;
         var _loc7_:Vector.<BaseAppService> = null;
         var _loc5_:BaseAppService = new BaseAppService(param3,param4,param1);
         for each(_loc6_ in param2)
         {
            if((_loc7_ = this.mServicesMap[_loc6_]) == null)
            {
               _loc7_ = new Vector.<BaseAppService>();
               this.mServicesMap[_loc6_] = _loc7_;
            }
            _loc7_.push(_loc5_);
         }
         return _loc5_;
      }
      
      public function init(param1:IAppState) : void
      {
         if(this.mInitialized)
         {
            return;
         }
         this.RegisterCommand("StepUpdates",this.StepUpdates);
         this.RegisterCommand("ResumeUpdates",this.ResumeUpdates);
         this.mInitialized = true;
         this.mState = param1;
         if(this.mState == null)
         {
            this.error("No initial state specified.");
            return;
         }
         this.mServicesMap = new Dictionary(false);
         this.mPlugins = new Vector.<IAppPlugin>();
         removeEventListener(Event.ADDED_TO_STAGE,this.init);
         this.loadData();
      }
      
      private function handleKeyUp(param1:KeyboardEvent) : void
      {
         this.mState.onKeyUp(param1.keyCode);
      }
      
      private function handleMouseDown(param1:MouseEvent) : void
      {
         this.mMousePos.x = param1.stageX;
         this.mMousePos.y = param1.stageY;
         this.mMouseDown = true;
         this.mMouseDownPos.x = param1.stageX;
         this.mMouseDownPos.y = param1.stageY;
         this.mState.onMouseDown(param1.stageX,param1.stageY);
      }
      
      public function error(param1:String) : void
      {
         var _loc2_:TextField = new TextField();
         _loc2_.width = stage.stageWidth;
         _loc2_.height = stage.stageHeight;
         _loc2_.appendText("Oh no!  An error has occured.\n");
         _loc2_.appendText("Please copy and paste this into a report!\n\n");
         _loc2_.appendText("Error: " + param1);
         _loc2_.textColor = 4294967295;
         _loc2_.multiline = true;
         _loc2_.wordWrap = true;
         _loc2_.background = true;
         _loc2_.backgroundColor = 4278190250;
         var _loc3_:TextFormat = new TextFormat("_typewriter",14,null,true,false,false);
         _loc2_.setTextFormat(_loc3_);
         stage.addChild(_loc2_);
         this.mIsError = true;
         this.stop();
      }
      
      private function handleFrame(param1:Event) : void
      {
         var _loc2_:int = getTimer();
         var _loc3_:int = _loc2_ - this.mLastTime;
         this.mLastTime = _loc2_;
         if(!this.mPaused)
         {
            this.mUpdateBuffer += _loc3_;
            while(this.mUpdateBuffer >= MILLIS_PER_UPDATE)
            {
               this.doFixedUpdate();
               this.mUpdateBuffer -= MILLIS_PER_UPDATE;
            }
         }
         this.doVariableUpdate(_loc3_);
      }
      
      public function BindCommand(param1:String, param2:String, param3:Array) : void
      {
         var _loc7_:String = null;
         var _loc8_:String = null;
         var _loc4_:int;
         if((_loc4_ = KeyCode.GetCodeFromString(param2)) > 0)
         {
            this.mCommandBindings[_loc4_ << 3] = param1;
            return;
         }
         var _loc5_:Array = param2.split("+");
         var _loc6_:* = 0;
         for each(_loc7_ in _loc5_)
         {
            if((_loc8_ = _loc7_.toUpperCase()) == "CONTROL")
            {
               _loc6_ |= CONTROL_FLAG;
            }
            else if(_loc8_ == "ALT")
            {
               _loc6_ |= ALT_FLAG;
            }
            else if(_loc8_ == "SHIFT")
            {
               _loc6_ |= SHIFT_FLAG;
            }
            else if((_loc4_ = KeyCode.GetCodeFromString(_loc8_)) == 0)
            {
               return;
            }
         }
         this.mCommandBindings[_loc4_ << 3 | _loc6_] = param1;
      }
      
      private function loadData() : void
      {
         var _loc1_:URLLoader = new URLLoader();
         var _loc2_:URLRequest = new URLRequest("data.xml");
         _loc1_.addEventListener(Event.COMPLETE,this.handleDataSuccess);
         _loc1_.addEventListener(IOErrorEvent.IO_ERROR,this.handleDataFailure);
         _loc1_.load(_loc2_);
      }
      
      private function handleDataSuccess(param1:Event) : void
      {
         var _loc7_:XML = null;
         var _loc8_:BaseAppPlugin = null;
         var _loc9_:XML = null;
         var _loc10_:String = null;
         var _loc11_:String = null;
         var _loc2_:URLLoader = param1.target as URLLoader;
         _loc2_.removeEventListener(Event.COMPLETE,this.handleDataSuccess);
         var _loc3_:XML = new XML(param1.target.data);
         this.mDataXML = _loc3_;
         var _loc4_:int = _loc3_.plugins.plugin.length();
         var _loc5_:int = 0;
         while(_loc5_ < _loc4_)
         {
            _loc7_ = _loc3_.plugins.plugin[_loc5_];
            _loc8_ = new BaseAppPlugin(this,_loc7_);
            _loc5_++;
         }
         var _loc6_:int = _loc3_.commands.bind.length();
         _loc5_ = 0;
         while(_loc5_ < _loc6_)
         {
            _loc10_ = (_loc9_ = _loc3_.commands.bind[_loc5_]).toString();
            _loc11_ = _loc9_.@keyCombo;
            this.BindCommand(_loc10_,_loc11_,[]);
            _loc5_++;
         }
         this.start();
      }
      
      private function handleDataFailure(param1:IOErrorEvent) : void
      {
         this.error("\'data.xml\' could not be found.");
      }
      
      private function ResumeUpdates(param1:Array = null) : void
      {
         this.mPaused = false;
      }
      
      private function StepUpdates(param1:Array = null) : void
      {
         this.mPaused = true;
         this.doFixedUpdate();
      }
      
      public function registerResourceLoader(param1:String, param2:Function) : void
      {
      }
      
      public function getStage() : Stage
      {
         return stage;
      }
      
      private function doVariableUpdate(param1:int) : void
      {
         this.mState.draw(param1);
      }
      
      private function doFixedUpdate() : void
      {
         this.mState.update();
      }
      
      public function getServices(param1:String) : Vector.<IAppService>
      {
         var _loc2_:Vector.<IAppService> = this.mServicesMap[param1];
         if(_loc2_ == null)
         {
            _loc2_ = new Vector.<BaseAppService>();
            this.mServicesMap[param1] = _loc2_;
         }
         return _loc2_;
      }
      
      private function handleMouseMove(param1:MouseEvent) : void
      {
         this.mMousePos.x = param1.stageX;
         this.mMousePos.y = param1.stageY;
         this.mState.onMouseMove(param1.stageX,param1.stageY);
      }
      
      private function handleMouseUp(param1:MouseEvent) : void
      {
         this.mMouseDown = false;
         this.mState.onMouseUp(param1.stageX,param1.stageY);
      }
      
      private function handleKeyDown(param1:KeyboardEvent) : void
      {
         var _loc4_:* = 0;
         var _loc5_:String = null;
         var _loc6_:Function = null;
         var _loc2_:XML = this.GetProperties();
         var _loc3_:Boolean = AppUtils.asBoolean(_loc2_.commands.enabled);
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
            if((_loc5_ = this.mCommandBindings[_loc4_]) != null)
            {
               if((_loc6_ = this.mCommands[_loc5_]) != null)
               {
                  _loc6_();
               }
            }
         }
         this.mState.onKeyDown(param1.keyCode);
      }
      
      public function get fps() : Number
      {
         return this.mFPS;
      }
      
      public function getPlugins() : Vector.<IAppPlugin>
      {
         return this.mPlugins;
      }
      
      public function isPaused() : Boolean
      {
         return this.mPaused;
      }
   }
}
