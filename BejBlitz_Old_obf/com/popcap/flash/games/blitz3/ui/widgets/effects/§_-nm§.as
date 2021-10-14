package com.popcap.flash.games.blitz3.ui.widgets.effects
{
   import com.popcap.flash.framework.resources.images.ImageInst;
   import com.popcap.flash.games.bej3.Gem;
   import com.popcap.flash.games.blitz3.§_-0Z§;
   import flash.display.Bitmap;
   import flash.display.BlendMode;
   import flash.geom.ColorTransform;
   
   public class §_-nm§ extends SpriteEffect
   {
       
      
      private var §_-RW§:int = 0;
      
      private var §_-kV§:Boolean = false;
      
      private var §_-Io§:Boolean = false;
      
      private var §_-MB§:ImageInst;
      
      private var §_-4G§:Bitmap;
      
      private var §_-pE§:int = 0;
      
      private var §_-BE§:ImageInst;
      
      private var §_-G6§:Vector.<GemShardParticle>;
      
      private var §_-Dn§:Gem;
      
      private var §_-Lp§:§_-0Z§;
      
      private var §_-el§:Boolean = false;
      
      public function §_-nm§(param1:§_-0Z§, param2:Gem)
      {
         super();
         this.§_-Lp§ = param1;
         x = param2.x * 40 + 20;
         y = param2.y * 40 + 20;
         this.§_-RW§ = param2.§_-Lo§;
         this.§_-Dn§ = param2;
         this.Init();
      }
      
      public function §_-Rs§(param1:Bitmap, param2:int) : void
      {
         var _loc3_:ColorTransform = param1.transform.colorTransform;
         switch(param2)
         {
            case Gem.§_-Y7§:
               _loc3_.redMultiplier = 2;
               _loc3_.greenMultiplier = 0;
               _loc3_.blueMultiplier = 0;
               break;
            case Gem.§_-md§:
               _loc3_.redMultiplier = 2;
               _loc3_.greenMultiplier = 1;
               _loc3_.blueMultiplier = 0;
               break;
            case Gem.§_-AH§:
               _loc3_.redMultiplier = 2;
               _loc3_.greenMultiplier = 2;
               _loc3_.blueMultiplier = 0;
               break;
            case Gem.§_-Zz§:
               _loc3_.redMultiplier = 0;
               _loc3_.greenMultiplier = 2;
               _loc3_.blueMultiplier = 0;
               break;
            case Gem.§ use§:
               _loc3_.redMultiplier = 0;
               _loc3_.greenMultiplier = 0;
               _loc3_.blueMultiplier = 2;
               break;
            case Gem.§_-70§:
               _loc3_.redMultiplier = 2;
               _loc3_.greenMultiplier = 0;
               _loc3_.blueMultiplier = 2;
               break;
            case Gem.§_-8M§:
               _loc3_.redMultiplier = 2;
               _loc3_.greenMultiplier = 2;
               _loc3_.blueMultiplier = 2;
               break;
            default:
               _loc3_.redMultiplier = 2;
               _loc3_.greenMultiplier = 2;
               _loc3_.blueMultiplier = 2;
         }
         param1.transform.colorTransform = _loc3_;
      }
      
      override public function Update() : void
      {
         var _loc1_:GemShardParticle = null;
         if(this.§_-kV§)
         {
            return;
         }
         this.§_-el§ = true;
         for each(_loc1_ in this.§_-G6§)
         {
            _loc1_.Update();
            this.§_-el§ = this.§_-el§ && _loc1_.IsDone();
         }
         this.§_-BE§.§_-hj§ = int(this.§_-pE§ / 100 * 15);
         this.§_-4G§.x = -(this.§_-BE§.width / 2);
         this.§_-4G§.y = -(this.§_-BE§.height / 2);
         if(this.§_-BE§.§_-hj§ >= this.§_-BE§.§_-O8§.§_-Jk§)
         {
            this.§_-Io§ = true;
         }
         else
         {
            this.§_-4G§.bitmapData = this.§_-BE§.§_-57§;
         }
         this.§_-4G§.smoothing = true;
         if(this.§_-Io§ && this.§_-el§)
         {
            this.§_-kV§ = true;
         }
         if(this.§_-pE§ == 0)
         {
            if(this.§_-RW§ != Gem.§_-Q3§)
            {
               this.§_-Lp§.§_-Qi§.playSound(Blitz3Sounds.SOUND_GEM_STAR_SHATTER);
            }
         }
         ++this.§_-pE§;
      }
      
      private function Init() : void
      {
         var _loc2_:GemShardParticle = null;
         this.§_-BE§ = this.§_-Lp§.§_-QZ§.§_-op§(Blitz3Images.IMAGE_GEM_EFFECT_EXPLODE);
         this.§_-MB§ = this.§_-Lp§.§_-QZ§.§_-op§(Blitz3Images.IMAGE_GEM_EFFECT_DISTORT);
         this.§_-4G§ = new Bitmap(this.§_-BE§.§_-57§);
         this.§_-4G§.alpha = 0.5;
         if(this.§_-Dn§.§_-Lo§ != Gem.§_-Q3§)
         {
            this.§_-BE§ = this.§_-MB§;
            this.§_-4G§.blendMode = BlendMode.ADD;
            this.§_-Rs§(this.§_-4G§,this.§_-Dn§.color);
         }
         else
         {
            this.§_-4G§.blendMode = BlendMode.ADD;
         }
         addChild(this.§_-4G§);
         this.§_-G6§ = new Vector.<GemShardParticle>();
         var _loc1_:int = 0;
         while(_loc1_ < 4)
         {
            _loc2_ = new GemShardParticle(this.§_-Lp§,this.§_-Dn§);
            this.§_-G6§.push(_loc2_);
            addChild(_loc2_);
            _loc1_++;
         }
      }
      
      override public function IsDone() : Boolean
      {
         return this.§_-kV§;
      }
   }
}
