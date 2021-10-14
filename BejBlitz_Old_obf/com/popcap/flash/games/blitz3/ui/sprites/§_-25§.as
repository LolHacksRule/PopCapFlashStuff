package com.popcap.flash.games.blitz3.ui.sprites
{
   import com.popcap.flash.games.blitz3.§_-0Z§;
   import flash.display.DisplayObject;
   import flash.display.DisplayObjectContainer;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.filters.ColorMatrixFilter;
   
   public class §_-25§ extends Sprite
   {
      
      private static var §_-dz§:Array = new Array(new ColorMatrixFilter([0.3,0.59,0.11,0,0,0.3,0.59,0.11,0,0,0.3,0.59,0.11,0,0,0,0,0,1,0]));
      
      public static const §_-ht§:Number = 2.5 / 100;
      
      private static var §_-T4§:Array = new Array();
      
      public static const §_-OE§:Number = 0.05;
       
      
      public var §_-XF§:Number = 0.05;
      
      private var §_-0T§:Boolean = true;
      
      private var §_-Bl§:Sprite;
      
      private var §_-Zk§:Boolean = false;
      
      public var §_-5H§:Sprite;
      
      private var §_-7X§:Boolean = false;
      
      public var §_-G0§:Sprite;
      
      private var §_-P1§:int = 0;
      
      private var §_-j4§:Number = 0.025;
      
      public var background:Sprite;
      
      private var §_-Lp§:§_-0Z§;
      
      private var §_-dj§:Number = 0.0;
      
      public function §_-25§(param1:§_-0Z§)
      {
         super();
         tabEnabled = false;
         tabChildren = false;
         this.§_-Lp§ = param1;
         mouseChildren = false;
         buttonMode = true;
         useHandCursor = true;
         this.background = new Sprite();
         this.§_-G0§ = new Sprite();
         this.§_-5H§ = new Sprite();
         this.§_-5H§.alpha = 0;
         this.§_-Bl§ = new Sprite();
         this.§_-Bl§.addChild(this.background);
         this.§_-Bl§.addChild(this.§_-G0§);
         this.§_-Bl§.addChild(this.§_-5H§);
         addChild(this.§_-Bl§);
         this.SetEnabled(true);
         addEventListener(MouseEvent.MOUSE_OVER,this.§_-Xu§);
         addEventListener(MouseEvent.MOUSE_OUT,this.§_-Ut§);
         addEventListener(MouseEvent.MOUSE_DOWN,this.§_-Lv§);
         addEventListener(MouseEvent.MOUSE_UP,this.§_-ES§);
         param1.§_-eG§(this.Update);
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
      
      private function §_-Lv§(param1:MouseEvent) : void
      {
         this.§_-Lp§.§_-Qi§.playSound(Blitz3Sounds.SOUND_BUTTON_PRESS);
      }
      
      private function §_-ES§(param1:MouseEvent) : void
      {
         this.§_-Lp§.§_-Qi§.playSound(Blitz3Sounds.SOUND_BUTTON_RELEASE);
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
      
      private function §_-Ut§(param1:MouseEvent) : void
      {
         this.§_-Zk§ = false;
      }
      
      public function IsEnabled() : Boolean
      {
         return this.§_-0T§;
      }
      
      public function SetEnabled(param1:Boolean) : void
      {
         this.§_-0T§ = param1;
         mouseEnabled = this.§_-0T§;
         mouseChildren = this.§_-0T§;
         if(this.background)
         {
            this.background.filters = !!this.§_-0T§ ? §_-T4§ : §_-dz§;
         }
         if(this.§_-5H§)
         {
            this.§_-5H§.filters = !!this.§_-0T§ ? §_-T4§ : §_-dz§;
         }
         if(this.§_-G0§)
         {
            this.§_-G0§.filters = !!this.§_-0T§ ? §_-T4§ : §_-dz§;
         }
      }
      
      public function §_-D7§() : void
      {
         this.§_-7X§ = false;
      }
      
      protected function Update() : void
      {
         if(!this.§_-0T§)
         {
            return;
         }
         if(this.§_-7X§)
         {
            --this.§_-P1§;
            this.§_-dj§ += this.§_-j4§;
            if(this.§_-dj§ >= 1 || this.§_-dj§ <= 0)
            {
               this.§_-j4§ *= -1;
            }
            if(this.§_-P1§ <= 0)
            {
               this.§_-D7§();
            }
         }
         else if(!this.§_-Zk§)
         {
            if(this.§_-dj§ > 0)
            {
               this.§_-dj§ -= this.§_-XF§;
               this.§_-dj§ = Math.max(this.§_-dj§,0);
            }
         }
         if(this.§_-5H§ != null)
         {
            this.§_-5H§.alpha = this.§_-dj§;
         }
      }
      
      public function §_-dN§() : Boolean
      {
         return this.§_-7X§;
      }
      
      private function §_-Xu§(param1:MouseEvent) : void
      {
         this.§_-Zk§ = true;
         this.§_-dj§ = 1;
      }
      
      public function §_-ge§() : void
      {
         if(this.background is DisplayObjectContainer)
         {
            this.§_-2e§(this.background as DisplayObjectContainer);
         }
         if(this.§_-G0§ is DisplayObjectContainer)
         {
            this.§_-2e§(this.§_-G0§ as DisplayObjectContainer);
         }
         if(this.§_-5H§ is DisplayObjectContainer)
         {
            this.§_-2e§(this.§_-5H§ as DisplayObjectContainer);
         }
      }
      
      public function §_-gs§(param1:int, param2:Number = 0.025) : void
      {
         this.§_-7X§ = true;
         this.§_-P1§ = param1;
         this.§_-j4§ = param2;
      }
   }
}
