package com.popcap.flash.games.blitz3.ui.widgets.effects
{
   import com.popcap.flash.framework.resources.images.ImageInst;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.BlendMode;
   import flash.display.Sprite;
   
   public class LightningBoltPiece extends Sprite
   {
       
      
      public var §_-pQ§:Bitmap;
      
      public var §_-hM§:Bitmap;
      
      private var §_-4-§:int = 0;
      
      private var §_-gd§:ImageInst;
      
      public function LightningBoltPiece(param1:ImageInst)
      {
         super();
         this.§_-gd§ = param1;
         blendMode = BlendMode.ADD;
         this.§_-pQ§ = new Bitmap();
         this.§_-pQ§.blendMode = BlendMode.ADD;
         this.§_-pQ§.bitmapData = param1.§_-O8§.§_-2s§[0];
         this.§_-pQ§.smoothing = true;
         this.§_-hM§ = new Bitmap();
         this.§_-hM§.blendMode = BlendMode.ADD;
         this.§_-hM§.bitmapData = param1.§_-O8§.§_-2s§[0];
         this.§_-hM§.smoothing = true;
         addChild(this.§_-pQ§);
         addChild(this.§_-hM§);
      }
      
      public function Change() : void
      {
         var _loc1_:int = this.§_-4-§;
         while(_loc1_ == this.§_-4-§)
         {
            _loc1_ = int(Math.random() * this.§_-gd§.§_-O8§.§_-Jk§);
         }
         this.§_-4-§ = _loc1_;
         var _loc2_:BitmapData = this.§_-gd§.§_-O8§.§_-2s§[_loc1_];
         this.§_-pQ§.bitmapData = _loc2_;
         this.§_-pQ§.smoothing = true;
         this.§_-hM§.bitmapData = _loc2_;
         this.§_-hM§.smoothing = true;
      }
   }
}
