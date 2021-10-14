package com.popcap.flash.games.blitz3.ui.widgets.effects
{
   import com.popcap.flash.framework.resources.images.ImageInst;
   import com.popcap.flash.games.bej3.Gem;
   import com.popcap.flash.games.blitz3.§_-0Z§;
   import flash.display.Bitmap;
   
   public class §return§ extends SpriteEffect
   {
      
      public static const §_-BG§:int = 150;
       
      
      private var §_-6-§:Bitmap;
      
      private var §_-O0§:Number = 0;
      
      private var §_-3q§:Number = 0;
      
      private var §_-mr§:ImageInst;
      
      private var §_-nh§:Bitmap;
      
      private var §_-Xg§:Boolean = false;
      
      private var §_-Gn§:int = 0;
      
      private var §_-C1§:ImageInst;
      
      private var §_-VL§:Bitmap;
      
      private var §_-J4§:Bitmap;
      
      private var §_-R7§:Bitmap;
      
      private var §_-IB§:Gem;
      
      private var mApp:§_-0Z§;
      
      private var §_-4z§:Boolean = false;
      
      public function §return§(param1:§_-0Z§, param2:Gem)
      {
         super();
         this.mApp = param1;
         this.§_-IB§ = param2;
         this.§_-4f§();
      }
      
      private function §_-4f§() : void
      {
         this.§_-mr§ = this.mApp.§_-QZ§.§_-op§(Blitz3Images.IMAGE_GEM_HINT_ARROWS);
         this.§_-C1§ = this.mApp.§_-QZ§.§_-op§(Blitz3Images.§_-nx§);
         this.§_-6-§ = new Bitmap();
         addChild(this.§_-6-§);
         this.§_-nh§ = new Bitmap(this.§_-mr§.§_-O8§.§_-2s§[0]);
         this.§_-J4§ = new Bitmap(this.§_-mr§.§_-O8§.§_-2s§[1]);
         this.§_-VL§ = new Bitmap(this.§_-mr§.§_-O8§.§_-2s§[2]);
         this.§_-R7§ = new Bitmap(this.§_-mr§.§_-O8§.§_-2s§[3]);
         addChild(this.§_-nh§);
         addChild(this.§_-J4§);
         addChild(this.§_-VL§);
         addChild(this.§_-R7§);
      }
      
      override public function IsDone() : Boolean
      {
         return this.§_-4z§;
      }
      
      override public function Update() : void
      {
         if(!this.§_-IB§.canMatch() && this.§_-IB§.type != Gem.§_-l0§)
         {
            this.§_-4z§ = true;
         }
         if(this.§_-4z§)
         {
            return;
         }
         x = this.§_-IB§.x * 40 + 20;
         y = this.§_-IB§.y * 40 + 20;
         this.§_-C1§.§_-hj§ = int(this.§_-Gn§ / 100 * 15);
         this.§_-6-§.x = -(this.§_-C1§.width / 2);
         this.§_-6-§.y = -(this.§_-C1§.height / 2);
         if(this.§_-C1§.§_-hj§ >= this.§_-C1§.§_-O8§.§_-Jk§)
         {
            this.§_-6-§.visible = false;
         }
         else
         {
            this.§_-6-§.bitmapData = this.§_-C1§.§_-57§;
         }
         if(this.§_-Gn§ == §_-BG§)
         {
            this.§_-4z§ = true;
         }
         ++this.§_-Gn§;
      }
      
      override public function Draw(param1:Boolean) : void
      {
         if(param1)
         {
            return;
         }
         if(this.§_-4z§)
         {
            return;
         }
         var _loc2_:Number = 4 * (this.§_-Gn§ / 100) * Math.PI;
         var _loc3_:Number = 4 * Math.sin(_loc2_);
         var _loc4_:Number = this.§_-mr§.width / 2;
         var _loc5_:Number = this.§_-mr§.height / 2;
         this.§_-nh§.x = -_loc4_;
         this.§_-nh§.y = 20 - _loc5_ + _loc3_;
         this.§_-J4§.x = -20 - _loc4_ - _loc3_;
         this.§_-J4§.y = -_loc5_;
         this.§_-VL§.x = -_loc4_;
         this.§_-VL§.y = -20 - _loc5_ - _loc3_;
         this.§_-R7§.x = 20 - _loc4_ + _loc3_;
         this.§_-R7§.y = -_loc5_;
      }
   }
}
