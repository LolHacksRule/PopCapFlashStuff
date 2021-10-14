package com.popcap.flash.games.blitz3.ui.widgets.effects
{
   import com.popcap.flash.framework.resources.images.ImageInst;
   import com.popcap.flash.framework.resources.images.§_-e§;
   import com.popcap.flash.games.bej3.Gem;
   import com.popcap.flash.games.blitz3.§_-0Z§;
   import flash.display.Bitmap;
   import flash.display.BlendMode;
   import flash.geom.ColorTransform;
   
   public class GemShardParticle extends SpriteEffect
   {
      
      public static const §_-U8§:int = 150;
      
      public static const §_-XC§:Number = 0.01;
       
      
      private var §_-Sw§:Bitmap;
      
      private var §_-Bi§:Number = 0;
      
      private var §_-WM§:Number = 0;
      
      private var §_-e-§:ImageInst;
      
      private var §_-Gn§:int = 0;
      
      private var §_-fd§:Bitmap;
      
      private var §_-4z§:Boolean = false;
      
      private var §_-bK§:Number = 0;
      
      private var §_-ZN§:Gem;
      
      private var §_-Vu§:Number = 0;
      
      private var §_-T7§:ImageInst;
      
      private var §_-X7§:Number = 0;
      
      private var §_-de§:Number = 0;
      
      public function GemShardParticle(param1:§_-0Z§, param2:Gem)
      {
         super();
         this.§_-ZN§ = param2;
         var _loc3_:Number = 0;
         var _loc4_:Number = 0;
         var _loc5_:Number = 0.5;
         x = Math.random() * 40 - 20;
         y = Math.random() * 40 - 20;
         var _loc6_:Number = x;
         var _loc7_:Number = y;
         var _loc8_:Gem;
         if((_loc8_ = param1.logic.board.§_-gH§(param2.§_-QS§)) != null && _loc8_.type == Gem.§_-Q3§)
         {
            _loc3_ = _loc8_.x * 40 + 20;
            _loc4_ = _loc8_.y * 40 + 20;
            _loc5_ = 2;
            this.§_-bK§ = §_-XC§;
            _loc6_ = x + (this.§_-ZN§.x * 40 + 20);
            _loc7_ = y + (this.§_-ZN§.y * 40 + 20);
         }
         this.§_-e-§ = param1.§_-QZ§.§_-op§(Blitz3Images.IMAGE_GEM_SHARDS);
         this.§_-T7§ = param1.§_-QZ§.§_-op§(Blitz3Images.IMAGE_GEM_SHARDS_OUTLINE);
         var _loc9_:Number = Math.atan2(_loc7_ - _loc4_,_loc6_ - _loc3_);
         this.§_-Bi§ = Math.cos(_loc9_) * _loc5_;
         this.§_-WM§ = Math.sin(_loc9_) * _loc5_;
         this.§_-de§ = Math.random() * 25 + 25;
         this.§_-Sw§ = new Bitmap();
         this.§_-fd§ = new Bitmap();
         this.§_-fd§.blendMode = BlendMode.ADD;
         this.§_-Rs§(param2.color);
         addChild(this.§_-Sw§);
         addChild(this.§_-fd§);
      }
      
      public function §_-Rs§(param1:int) : void
      {
         var _loc2_:int = 0;
         switch(param1)
         {
            case Gem.§_-Y7§:
               _loc2_ = 16711680;
               break;
            case Gem.§_-md§:
               _loc2_ = 16744448;
               break;
            case Gem.§_-AH§:
               _loc2_ = 16776960;
               break;
            case Gem.§_-Zz§:
               _loc2_ = 65280;
               break;
            case Gem.§ use§:
               _loc2_ = 255;
               break;
            case Gem.§_-70§:
               _loc2_ = 16711935;
               break;
            case Gem.§_-8M§:
               _loc2_ = 8421504;
               break;
            case Gem.§_-aK§:
            default:
               _loc2_ = 2105376;
         }
         var _loc3_:ColorTransform = this.§_-Sw§.transform.colorTransform;
         §_-e§.§_-eY§(_loc3_,_loc2_);
         this.§_-Sw§.transform.colorTransform = _loc3_;
      }
      
      override public function Update() : void
      {
         var _loc5_:ColorTransform = null;
         if(this.§_-4z§)
         {
            return;
         }
         this.§_-WM§ += this.§_-bK§;
         x += this.§_-Bi§;
         y += this.§_-WM§;
         this.§_-e-§.x = x;
         this.§_-e-§.y = y;
         this.§_-T7§.x = x;
         this.§_-T7§.y = y;
         ++this.§_-Gn§;
         var _loc1_:Number = this.§_-Gn§ / 100 * 16;
         var _loc2_:int = int(_loc1_) % this.§_-e-§.§_-O8§.§_-Jk§;
         this.§_-e-§.§_-hj§ = _loc2_;
         this.§_-T7§.§_-hj§ = _loc2_;
         var _loc3_:Number = 1 - this.§_-Gn§ / §_-U8§;
         var _loc4_:Number = Math.sin(this.§_-Gn§ / this.§_-de§ * Math.PI) + 1;
         (_loc5_ = this.§_-Sw§.transform.colorTransform).alphaMultiplier = _loc3_;
         this.§_-Sw§.transform.colorTransform = _loc5_;
         (_loc5_ = this.§_-fd§.transform.colorTransform).alphaMultiplier = _loc3_ * _loc4_;
         this.§_-fd§.transform.colorTransform = _loc5_;
         this.§_-Sw§.bitmapData = this.§_-e-§.§_-57§;
         this.§_-Sw§.x = -(this.§_-e-§.width / 2);
         this.§_-Sw§.y = -(this.§_-e-§.height / 2);
         this.§_-Sw§.smoothing = true;
         this.§_-fd§.bitmapData = this.§_-T7§.§_-57§;
         this.§_-fd§.x = -(this.§_-T7§.width / 2);
         this.§_-fd§.y = -(this.§_-T7§.height / 2);
         this.§_-fd§.smoothing = true;
         if(this.§_-Gn§ >= §_-U8§)
         {
            this.§_-4z§ = true;
         }
      }
      
      override public function IsDone() : Boolean
      {
         return this.§_-4z§;
      }
   }
}
