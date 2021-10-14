package com.jambool.display
{
   import flash.display.Sprite;
   import flash.events.TimerEvent;
   import flash.utils.Timer;
   
   public class §_-Ur§ extends Sprite
   {
      
      private static var §_-5v§:String = "tickColor";
       
      
      public var §_-KW§:Boolean = true;
      
      private var §_-Rk§:Number = 0;
      
      private var §_-Ll§:int = 1000;
      
      private var §_-Mi§:Boolean = true;
      
      private var §_-Zw§:Number = 30;
      
      private var §_-UC§:Boolean;
      
      private var fadeTimer:Timer;
      
      private var §_-hf§:Number = 3;
      
      public var fadeSpeed:int = 600;
      
      private var _numTicks:int = 12;
      
      public function §_-Ur§()
      {
         super();
         §_-D8§();
         §_-kj§();
      }
      
      public function get size() : Number
      {
         return §_-Zw§;
      }
      
      public function stop() : void
      {
         if(fadeTimer != null && fadeTimer.running)
         {
            §_-UC§ = false;
            fadeTimer.stop();
         }
      }
      
      public function set size(param1:Number) : void
      {
         if(param1 != §_-Zw§)
         {
            §_-Zw§ = param1;
            §_-D8§();
         }
      }
      
      public function set tickColor(param1:Number) : void
      {
         if(param1 != §_-Rk§)
         {
            §_-Rk§ = param1;
            §_-D8§();
         }
      }
      
      public function get tickColor() : Number
      {
         return §_-Rk§;
      }
      
      public function set speed(param1:int) : void
      {
         if(param1 != §_-Ll§)
         {
            §_-Ll§ = param1;
            if(fadeTimer != null)
            {
               fadeTimer.stop();
               fadeTimer.delay = param1 / _numTicks;
               fadeTimer.start();
            }
         }
      }
      
      private function §_-kj§() : void
      {
         if(§_-KW§)
         {
            play();
         }
      }
      
      public function set §_-5t§(param1:int) : void
      {
         if(param1 != §_-hf§)
         {
            §_-hf§ = param1;
            §_-D8§();
         }
      }
      
      public function get speed() : int
      {
         return §_-Ll§;
      }
      
      public function get §_-mJ§() : Boolean
      {
         return §_-UC§;
      }
      
      public function set §_-dc§(param1:int) : void
      {
         if(param1 != _numTicks)
         {
            _numTicks = param1;
            §_-D8§();
         }
      }
      
      public function get §_-dc§() : int
      {
         return _numTicks;
      }
      
      public function get §_-5t§() : int
      {
         return §_-hf§;
      }
      
      public function play() : void
      {
         if(!§_-UC§)
         {
            fadeTimer = new Timer(speed / _numTicks,0);
            fadeTimer.addEventListener(TimerEvent.TIMER,function(param1:TimerEvent):void
            {
               var _loc3_:§_-6l§ = null;
               var _loc2_:int = int(fadeTimer.currentCount % _numTicks);
               if(numChildren > _loc2_)
               {
                  _loc3_ = getChildAt(_loc2_) as §_-6l§;
                  _loc3_.§_-Ku§(fadeSpeed != 1 ? Number(fadeSpeed) : Number(speed * 6 / 10));
               }
            });
            fadeTimer.start();
            §_-UC§ = true;
         }
      }
      
      protected function §_-D8§() : void
      {
         var _loc8_:Number = NaN;
         var _loc9_:Number = NaN;
         var _loc10_:Number = NaN;
         var _loc11_:Number = NaN;
         var _loc12_:§_-6l§ = null;
         var _loc1_:Boolean = §_-UC§;
         stop();
         var _loc2_:int = numChildren - 1;
         while(_loc2_ >= 0)
         {
            removeChildAt(_loc2_);
            _loc2_--;
         }
         var _loc3_:Number = size / 2;
         var _loc4_:Number = 2 * Math.PI / _numTicks;
         var _loc5_:Number = §_-hf§ != -1 ? Number(§_-hf§) : Number(size / 10);
         var _loc6_:Number = 0;
         var _loc7_:int = 0;
         while(_loc7_ < _numTicks)
         {
            _loc8_ = _loc3_ + Math.sin(_loc6_) * ((_numTicks + 2) * _loc5_ / 2 / Math.PI);
            _loc9_ = _loc3_ - Math.cos(_loc6_) * ((_numTicks + 2) * _loc5_ / 2 / Math.PI);
            _loc10_ = _loc3_ + Math.sin(_loc6_) * (_loc3_ - _loc5_);
            _loc11_ = _loc3_ - Math.cos(_loc6_) * (_loc3_ - _loc5_);
            (_loc12_ = new §_-6l§(_loc8_,_loc9_,_loc10_,_loc11_,_loc5_,tickColor)).alpha = 0.1;
            this.addChild(_loc12_);
            _loc6_ += _loc4_;
            _loc7_++;
         }
         if(_loc1_)
         {
            play();
         }
      }
   }
}
