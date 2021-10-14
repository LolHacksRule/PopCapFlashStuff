package com.popcap.flash.games.blitz3.ui.widgets.effects
{
   import §_-Xk§.§_-Hd§;
   import §_-Xk§.§_-LE§;
   import com.popcap.flash.framework.resources.images.ImageInst;
   import com.popcap.flash.games.bej3.Gem;
   import com.popcap.flash.games.blitz3.§_-0Z§;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   
   public class §case§ extends SpriteEffect
   {
      
      public static const §_-BG§:int = 30;
       
      
      private var mT1:Number = 0;
      
      private var mT2:Number = 0;
      
      private var mT3:Number = 0;
      
      private var §_-Hl§:§_-Hd§;
      
      private var §_-6M§:ImageInst;
      
      private var §_-Gn§:int = 0;
      
      private var mFlame1:Sprite;
      
      private var mFlame2:Sprite;
      
      private var mFlame3:Sprite;
      
      private var mApp:§_-0Z§;
      
      private var §_-Os§:ImageInst;
      
      private var §_-ju§:Boolean = false;
      
      private var §_-c6§:§_-Hd§;
      
      public function §case§(param1:§_-0Z§, param2:Gem)
      {
         super();
         this.mApp = param1;
         x = param2.x * 40 + 20;
         y = param2.y * 40 + 20;
         this.§_-Hl§ = new §_-Hd§();
         this.§_-Hl§.§_-9O§(0,1);
         this.§_-Hl§.§_-0g§(0.33,1.2);
         this.§_-Hl§.§_-c3§(true,new §_-LE§(0,0.33),new §_-LE§(1,1.2));
         this.§_-c6§ = new §_-Hd§();
         this.§_-c6§.§_-9O§(0,1);
         this.§_-c6§.§_-0g§(0,1);
         this.§_-c6§.§_-c3§(true,new §_-LE§(0,1),new §_-LE§(1,0));
         this.§_-4f§();
      }
      
      override public function IsDone() : Boolean
      {
         return this.§_-ju§;
      }
      
      override public function Draw(param1:Boolean) : void
      {
         if(param1)
         {
            return;
         }
         if(this.§_-ju§ == true)
         {
            return;
         }
         this.native(this.mFlame1,this.mT1);
         this.native(this.mFlame2,this.mT2);
         this.native(this.mFlame3,this.mT3);
      }
      
      private function §_-4f§() : void
      {
         this.§_-6M§ = this.mApp.§_-QZ§.§_-op§(Blitz3Images.IMAGE_GEM_FLAME_EFFECT_EXPLODE);
         this.§_-Os§ = this.mApp.§_-QZ§.§_-op§(Blitz3Images.IMAGE_GEM_EFFECT_DISTORT);
         this.§_-Os§.§_-1r§.scale(3,3);
         var _loc1_:Bitmap = new Bitmap(this.§_-6M§.§_-57§);
         var _loc2_:Bitmap = new Bitmap(this.§_-6M§.§_-57§);
         var _loc3_:Bitmap = new Bitmap(this.§_-6M§.§_-57§);
         _loc1_.x = -(_loc1_.width / 2);
         _loc1_.y = -(_loc1_.height / 2);
         _loc2_.x = -(_loc2_.width / 2);
         _loc2_.y = -(_loc2_.height / 2);
         _loc3_.x = -(_loc3_.width / 2);
         _loc3_.y = -(_loc3_.height / 2);
         this.mFlame1 = new Sprite();
         this.mFlame2 = new Sprite();
         this.mFlame3 = new Sprite();
         this.mFlame1.addChild(_loc1_);
         this.mFlame2.addChild(_loc2_);
         this.mFlame3.addChild(_loc3_);
         addChild(this.mFlame1);
         addChild(this.mFlame2);
         addChild(this.mFlame3);
      }
      
      private function native(param1:Sprite, param2:Number) : void
      {
         if(param2 < 0)
         {
            param1.visible = false;
            return;
         }
         param1.visible = true;
         var _loc3_:Number = this.§_-Hl§.getOutValue(param2);
         var _loc4_:Number = (1 - _loc3_) * (this.§_-6M§.width / 2);
         param1.scaleX = _loc3_;
         param1.scaleY = _loc3_;
         param1.alpha = this.§_-c6§.getOutValue(param2);
      }
      
      override public function Update() : void
      {
         if(this.§_-ju§ == true)
         {
            return;
         }
         this.mT1 = (this.§_-Gn§ - 0) / §_-BG§;
         this.mT2 = (this.§_-Gn§ - 10) / §_-BG§;
         this.mT3 = (this.§_-Gn§ - 20) / §_-BG§;
         if(this.mT3 >= 1)
         {
            this.§_-ju§ = true;
         }
         if(this.§_-Gn§ == 0)
         {
            this.mApp.§_-Qi§.playSound(Blitz3Sounds.SOUND_GEM_FLAME_EXPLODE);
         }
         ++this.§_-Gn§;
      }
   }
}
