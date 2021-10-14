package com.popcap.flash.framework
{
   import com.popcap.flash.framework.impl.BaseAppService;
   import com.popcap.flash.framework.impl.§_-IW§;
   import com.popcap.flash.framework.input.keyboard.§_-6b§;
   import flash.display.Sprite;
   import flash.display.Stage;
   import flash.events.Event;
   import flash.events.IOErrorEvent;
   import flash.events.KeyboardEvent;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import flash.net.URLLoader;
   import flash.net.URLRequest;
   import flash.ui.ContextMenu;
   import flash.ui.ContextMenuItem;
   import flash.utils.Dictionary;
   import flash.utils.getTimer;
   
   public class §_-oL§ extends Sprite implements §_-VB§
   {
      
      private static const §_-nb§:int = 4;
      
      private static const §_-jN§:int = 2;
      
      public static const §_-KE§:int = 10;
      
      private static const §_-3r§:int = 1;
       
      
      private var §_-Ju§:Number = 1000.0;
      
      private var §_-0m§:IAppState = null;
      
      private var §_-lr§:Array;
      
      public var §_-jA§:int = 1;
      
      private var §_-VN§:Dictionary;
      
      private var §_-Jf§:Point;
      
      private var §_-AR§:Boolean = false;
      
      private var §_-As§:XML = null;
      
      private var §_-Kh§:int = 0;
      
      private var §_-Vg§:Point;
      
      private var §_-n6§:Dictionary;
      
      private var §_-1R§:Vector.<IAppPlugin>;
      
      private var §_-mQ§:int = 0;
      
      private var §_-ZZ§:Dictionary;
      
      private var §_-pI§:Boolean = false;
      
      private var §_-Hb§:Function = null;
      
      public function §_-oL§()
      {
         this.§_-Vg§ = new Point();
         this.§_-Jf§ = new Point();
         this.§_-ZZ§ = new Dictionary();
         this.§_-VN§ = new Dictionary();
         this.§_-lr§ = [];
         super();
      }
      
      private function §_-pc§(param1:Event) : void
      {
         var _loc2_:int = getTimer();
         var _loc3_:int = _loc2_ - this.§_-mQ§;
         this.§_-mQ§ = _loc2_;
         if(!this.§_-AR§)
         {
            this.§_-Kh§ += _loc3_;
            while(this.§_-Kh§ >= §_-KE§)
            {
               this.§_-DO§();
               this.§_-Kh§ -= §_-KE§;
            }
         }
         this.§_-PX§(_loc3_);
      }
      
      private function §_-Lv§(param1:MouseEvent) : void
      {
         this.§_-Vg§.x = param1.stageX;
         this.§_-Vg§.y = param1.stageY;
         this.§_-pI§ = true;
         this.§_-Jf§.x = param1.stageX;
         this.§_-Jf§.y = param1.stageY;
         if(this.§_-0m§ != null)
         {
            this.§_-0m§.§_-W-§(param1.stageX,param1.stageY);
         }
      }
      
      public function §_-kP§(param1:String, param2:Function) : void
      {
         this.§_-ZZ§[param1] = param2;
      }
      
      public function §_-7S§() : XML
      {
         return this.§_-As§;
      }
      
      private function IncUpdatesPerTick() : void
      {
         ++this.§_-jA§;
         if(this.§_-jA§ > 4)
         {
            this.§_-jA§ = 4;
         }
      }
      
      private function §_-R§(param1:Event) : void
      {
         var _loc7_:XML = null;
         var _loc8_:§_-IW§ = null;
         var _loc9_:XML = null;
         var _loc10_:String = null;
         var _loc11_:String = null;
         var _loc2_:URLLoader = param1.target as URLLoader;
         _loc2_.removeEventListener(Event.COMPLETE,this.§_-R§);
         var _loc3_:XML = new XML(param1.target.data);
         this.§_-As§ = _loc3_;
         var _loc4_:int = _loc3_.plugins.plugin.length();
         var _loc5_:int = 0;
         while(_loc5_ < _loc4_)
         {
            _loc7_ = _loc3_.plugins.plugin[_loc5_];
            _loc8_ = new §_-IW§(this,_loc7_);
            _loc5_++;
         }
         var _loc6_:int = _loc3_.commands.bind.length();
         _loc5_ = 0;
         while(_loc5_ < _loc6_)
         {
            _loc10_ = (_loc9_ = _loc3_.commands.bind[_loc5_]).toString();
            _loc11_ = _loc9_.@keyCombo;
            this.§_-7y§(_loc10_,_loc11_);
            _loc5_++;
         }
         if(this.§_-Hb§ != null)
         {
            this.§_-Hb§(true);
         }
      }
      
      public function §_-Eq§(param1:§_-IW§, param2:Vector.<String>, param3:Object, param4:XML) : IAppService
      {
         var _loc6_:String = null;
         var _loc7_:Vector.<BaseAppService> = null;
         var _loc5_:BaseAppService = new BaseAppService(param3,param4,param1);
         for each(_loc6_ in param2)
         {
            if((_loc7_ = this.§_-n6§[_loc6_]) == null)
            {
               _loc7_ = new Vector.<BaseAppService>();
               this.§_-n6§[_loc6_] = _loc7_;
            }
            _loc7_.push(_loc5_);
         }
         return _loc5_;
      }
      
      private function §_-Cm§(param1:IOErrorEvent) : void
      {
         var _loc2_:URLLoader = param1.target as URLLoader;
         _loc2_.removeEventListener(Event.COMPLETE,this.§_-R§);
         if(this.§_-Hb§ != null)
         {
            this.§_-Hb§(false);
         }
      }
      
      public function Stop() : void
      {
         this.§_-0m§ = null;
         stage.removeEventListener(MouseEvent.MOUSE_UP,this.§_-ES§);
         stage.removeEventListener(MouseEvent.MOUSE_DOWN,this.§_-Lv§);
         stage.removeEventListener(MouseEvent.MOUSE_MOVE,this.§_-Oz§);
         stage.removeEventListener(KeyboardEvent.KEY_UP,this.§_-UN§);
         stage.removeEventListener(KeyboardEvent.KEY_DOWN,this.§_-hq§);
         stage.removeEventListener(Event.ENTER_FRAME,this.§_-pc§);
      }
      
      public function §_-UL§(param1:String) : void
      {
         var _loc2_:ContextMenu = new ContextMenu();
         _loc2_.hideBuiltInItems();
         var _loc3_:ContextMenuItem = new ContextMenuItem(param1);
         _loc2_.customItems.push(_loc3_);
         contextMenu = _loc2_;
      }
      
      private function DecUpdatesPerTick() : void
      {
         --this.§_-jA§;
         if(this.§_-jA§ < 1)
         {
            this.§_-jA§ = 1;
         }
      }
      
      public function §_-7y§(param1:String, param2:String) : void
      {
         var _loc6_:String = null;
         var _loc7_:String = null;
         var _loc3_:int = §_-6b§.§_-5m§(param2);
         if(_loc3_ > 0)
         {
            this.§_-VN§[_loc3_ << 3] = param1;
            return;
         }
         var _loc4_:Array = param2.split("+");
         var _loc5_:* = 0;
         for each(_loc6_ in _loc4_)
         {
            if((_loc7_ = _loc6_.toUpperCase()) == "CONTROL")
            {
               _loc5_ |= §_-3r§;
            }
            else if(_loc7_ == "ALT")
            {
               _loc5_ |= §_-jN§;
            }
            else if(_loc7_ == "SHIFT")
            {
               _loc5_ |= §_-nb§;
            }
            else
            {
               _loc3_ = §_-6b§.§_-5m§(_loc7_);
               if(_loc3_ == 0)
               {
                  return;
               }
            }
         }
         this.§_-VN§[_loc3_ << 3 | _loc5_] = param1;
      }
      
      private function §_-ES§(param1:MouseEvent) : void
      {
         this.§_-pI§ = false;
         if(this.§_-0m§ != null)
         {
            this.§_-0m§.§_-3Z§(param1.stageX,param1.stageY);
         }
      }
      
      private function §_-hq§(param1:KeyboardEvent) : void
      {
         var _loc4_:* = 0;
         var _loc5_:String = null;
         var _loc6_:Function = null;
         var _loc2_:XML = this.§_-7S§();
         var _loc3_:Boolean = _loc2_ != null && §_-IX§.§_-Gl§(_loc2_.commands.enabled);
         if(_loc3_)
         {
            _loc4_ = param1.keyCode << 3;
            if(param1.ctrlKey)
            {
               _loc4_ |= §_-3r§;
            }
            if(param1.altKey)
            {
               _loc4_ |= §_-jN§;
            }
            if(param1.shiftKey)
            {
               _loc4_ |= §_-nb§;
            }
            if((_loc5_ = this.§_-VN§[_loc4_]) != null)
            {
               if((_loc6_ = this.§_-ZZ§[_loc5_]) != null)
               {
                  _loc6_();
               }
            }
         }
         if(this.§_-0m§ != null)
         {
            this.§_-0m§.§_-5Q§(param1.keyCode);
         }
      }
      
      private function ResumeUpdates(param1:Array = null) : void
      {
         this.§_-AR§ = false;
      }
      
      private function StepUpdates(param1:Array = null) : void
      {
         this.§_-AR§ = true;
         this.§_-DO§();
      }
      
      private function §_-Oz§(param1:MouseEvent) : void
      {
         this.§_-Vg§.x = param1.stageX;
         this.§_-Vg§.y = param1.stageY;
         if(this.§_-0m§ != null)
         {
            this.§_-0m§.§_-Yz§(param1.stageX,param1.stageY);
         }
      }
      
      public function §_-MX§() : Stage
      {
         return stage;
      }
      
      public function §_-AN§(param1:IAppState) : void
      {
         this.§_-0m§ = param1;
         if(this.§_-0m§ == null)
         {
            return;
         }
         stage.addEventListener(MouseEvent.MOUSE_UP,this.§_-ES§);
         stage.addEventListener(MouseEvent.MOUSE_DOWN,this.§_-Lv§);
         stage.addEventListener(MouseEvent.MOUSE_MOVE,this.§_-Oz§);
         stage.addEventListener(KeyboardEvent.KEY_UP,this.§_-UN§);
         stage.addEventListener(KeyboardEvent.KEY_DOWN,this.§_-hq§);
         this.§_-0m§.§_-7H§();
         this.§_-mQ§ = getTimer();
         stage.addEventListener(Event.ENTER_FRAME,this.§_-pc§);
      }
      
      private function §_-DO§() : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:Function = null;
         var _loc1_:int = 0;
         while(_loc1_ < this.§_-jA§)
         {
            if(this.§_-0m§ != null)
            {
               this.§_-0m§.update();
            }
            _loc2_ = this.§_-lr§.length;
            _loc3_ = 0;
            while(_loc3_ < _loc2_)
            {
               (_loc4_ = this.§_-lr§[_loc3_])();
               _loc3_++;
            }
            _loc1_++;
         }
      }
      
      public function §_-Tq§(param1:String) : Vector.<IAppService>
      {
         var _loc2_:Vector.<IAppService> = this.§_-n6§[param1];
         if(_loc2_ == null)
         {
            _loc2_ = new Vector.<BaseAppService>();
            this.§_-n6§[param1] = _loc2_;
         }
         return _loc2_;
      }
      
      public function §_-5I§(param1:String, param2:Function = null) : void
      {
         this.§_-n6§ = new Dictionary(false);
         this.§_-1R§ = new Vector.<IAppPlugin>();
         this.§_-Hb§ = param2;
         this.§_-kP§("StepUpdates",this.StepUpdates);
         this.§_-kP§("ResumeUpdates",this.ResumeUpdates);
         this.§_-kP§("IncUpdatesPerTick",this.IncUpdatesPerTick);
         this.§_-kP§("DecUpdatesPerTick",this.DecUpdatesPerTick);
         var _loc3_:URLLoader = new URLLoader();
         var _loc4_:URLRequest = new URLRequest(param1 + "data.xml");
         _loc3_.addEventListener(Event.COMPLETE,this.§_-R§);
         _loc3_.addEventListener(IOErrorEvent.IO_ERROR,this.§_-Cm§);
         _loc3_.load(_loc4_);
      }
      
      public function §_-eG§(param1:Function) : void
      {
         this.§_-lr§.push(param1);
      }
      
      public function get §_-cE§() : Number
      {
         return this.§_-Ju§;
      }
      
      public function §_-PL§() : Vector.<IAppPlugin>
      {
         return this.§_-1R§;
      }
      
      private function §_-PX§(param1:int) : void
      {
         var _loc2_:int = 0;
         while(_loc2_ < this.§_-jA§)
         {
            if(this.§_-0m§ != null)
            {
               this.§_-0m§.draw(param1);
            }
            _loc2_++;
         }
      }
      
      private function §_-UN§(param1:KeyboardEvent) : void
      {
         if(this.§_-0m§ != null)
         {
            this.§_-0m§.§_-2R§(param1.keyCode);
         }
      }
      
      public function isPaused() : Boolean
      {
         return this.§_-AR§;
      }
   }
}
