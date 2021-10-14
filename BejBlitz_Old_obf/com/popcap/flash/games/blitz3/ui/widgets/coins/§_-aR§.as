package com.popcap.flash.games.blitz3.ui.widgets.coins
{
   import com.popcap.flash.games.blitz3.§_-0Z§;
   import flash.display.DisplayObject;
   import flash.display.DisplayObjectContainer;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   
   public class §_-aR§
   {
      
      public static const §_-OE§:Number = 0.05;
       
      
      private var §_-Cg§:MovieClip;
      
      private var §_-0T§:Boolean = true;
      
      private var §_-Lp§:§_-0Z§;
      
      private var §_-Zk§:Boolean = false;
      
      private var §_-dj§:Number = 0.0;
      
      public var §_-XF§:Number = 0.05;
      
      public function §_-aR§(param1:§_-0Z§, param2:MovieClip)
      {
         super();
         this.§_-Lp§ = param1;
         this.§_-Cg§ = param2;
         this.§_-Lp§.§_-eG§(this.Update);
         this.§_-Cg§.tabEnabled = false;
         this.§_-Cg§.tabChildren = false;
         this.§_-Cg§.mouseChildren = false;
         this.§_-Cg§.buttonMode = true;
         this.§_-Cg§.useHandCursor = true;
         this.§_-Cg§.overClip.alpha = 0;
         this.§_-Cg§.addEventListener(MouseEvent.MOUSE_OVER,this.§_-Xu§);
         this.§_-Cg§.addEventListener(MouseEvent.MOUSE_OUT,this.§_-Ut§);
         this.§_-Cg§.addEventListener(MouseEvent.MOUSE_DOWN,this.§_-Lv§);
         this.§_-Cg§.addEventListener(MouseEvent.MOUSE_UP,this.§_-ES§);
      }
      
      private function §_-Lv§(param1:MouseEvent) : void
      {
         this.§_-Lp§.§_-Qi§.playSound(Blitz3Sounds.SOUND_BUTTON_PRESS);
      }
      
      public function IsEnabled() : Boolean
      {
         return this.§_-0T§;
      }
      
      private function §_-Sf§(param1:DisplayObject) : void
      {
         if(param1 is DisplayObjectContainer)
         {
            this.§_-2e§(param1 as DisplayObjectContainer);
         }
         param1.x = -(param1.width / 2);
         param1.y = -(param1.height / 2);
      }
      
      public function Update() : void
      {
         if(!this.§_-Zk§)
         {
            if(this.§_-dj§ > 0)
            {
               this.§_-dj§ -= this.§_-XF§;
               this.§_-dj§ = Math.max(this.§_-dj§,0);
            }
         }
         if(this.§_-Cg§.overClip != null)
         {
            this.§_-Cg§.overClip.alpha = this.§_-dj§;
         }
      }
      
      public function SetEnabled(param1:Boolean) : void
      {
         this.§_-0T§ = param1;
         this.§_-Cg§.mouseEnabled = this.§_-0T§;
         this.§_-Cg§.mouseChildren = this.§_-0T§;
      }
      
      private function §_-Xu§(param1:MouseEvent) : void
      {
         this.§_-Zk§ = true;
         this.§_-dj§ = 1;
      }
      
      private function §_-2e§(param1:DisplayObjectContainer) : void
      {
         var _loc4_:DisplayObject = null;
         var _loc2_:int = param1.numChildren;
         var _loc3_:int = 0;
         while(_loc3_ < _loc2_)
         {
            _loc4_ = param1.getChildAt(_loc3_);
            this.§_-Sf§(_loc4_);
            _loc3_++;
         }
      }
      
      private function §_-Ut§(param1:MouseEvent) : void
      {
         this.§_-Zk§ = false;
      }
      
      private function §_-ES§(param1:MouseEvent) : void
      {
         this.§_-Lp§.§_-Qi§.playSound(Blitz3Sounds.SOUND_BUTTON_RELEASE);
      }
   }
}
