package com.popcap.flash.games.blitz3.ui.sprites
{
   import com.popcap.flash.framework.resources.images.ImageInst;
   import com.popcap.flash.framework.resources.images.§_-SF§;
   import com.popcap.flash.framework.resources.images.§_-c-§;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   
   public class CoinSprite extends Sprite
   {
      
      private static const §_-oO§:Class = §_-kv§;
      
      private static const §_-aO§:Class = §_-MO§;
      
      private static const §_-Z7§:§_-SF§ = new §_-SF§(§_-aO§,null,1,1);
      
      private static const §_-bj§:§_-SF§ = new §_-SF§(§_-oO§,null,1,14);
       
      
      public var §_-7c§:Boolean = false;
      
      private var §_-4c§:ImageInst;
      
      private var §_-HA§:Bitmap;
      
      private var §_-gd§:ImageInst;
      
      private var §_-Gn§:int = 0;
      
      private var §break§:Bitmap;
      
      public function CoinSprite()
      {
         super();
         this.§_-gd§ = this.§_-Zl§();
         this.§_-4c§ = this.§_-Cc§();
         this.§break§ = new Bitmap(this.§_-gd§.§_-57§);
         this.§_-HA§ = new Bitmap(this.§_-4c§.§_-57§);
         this.§break§.x = -(this.§break§.width / 2);
         this.§break§.y = -(this.§break§.height / 2);
         this.§_-HA§.x = -(this.§_-HA§.width / 2);
         this.§_-HA§.y = -(this.§_-HA§.height / 2);
         addChild(this.§_-HA§);
      }
      
      public function Update() : void
      {
         if(!this.§_-7c§)
         {
            return;
         }
         if(this.§_-HA§.parent != null)
         {
            removeChild(this.§_-HA§);
            addChild(this.§break§);
         }
         var _loc1_:int = this.§_-gd§.§_-O8§.§_-Jk§;
         var _loc3_:Number = this.§_-Gn§ * 0.01;
         var _loc4_:int = _loc3_ * 24 % _loc1_;
         this.§_-gd§.§_-hj§ = _loc4_;
         this.§break§.bitmapData = this.§_-gd§.§_-57§;
         ++this.§_-Gn§;
      }
      
      public function Reset() : void
      {
         if(parent != null)
         {
            parent.removeChild(this);
         }
         this.§_-7c§ = false;
         if(this.§break§.parent != null)
         {
            this.§break§.parent.removeChild(this.§break§);
         }
         addChild(this.§_-HA§);
      }
      
      private function §_-Cc§() : ImageInst
      {
         var _loc1_:§_-c-§ = §_-Z7§.§_-C§();
         var _loc2_:ImageInst = new ImageInst();
         _loc2_.§_-O8§ = _loc1_;
         return _loc2_;
      }
      
      private function §_-Zl§() : ImageInst
      {
         var _loc1_:§_-c-§ = §_-bj§.§_-C§();
         var _loc2_:ImageInst = new ImageInst();
         _loc2_.§_-O8§ = _loc1_;
         return _loc2_;
      }
   }
}
