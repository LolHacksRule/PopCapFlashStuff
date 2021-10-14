package com.popcap.flash.bejeweledblitz.game.ui.game.board.gems.effects
{
   import com.popcap.flash.bejeweledblitz.SoundPlayer;
   import com.popcap.flash.bejeweledblitz.game.Blitz3App;
   import com.popcap.flash.bejeweledblitz.game.ui.raregems.dynamicgem.DynamicRareGemSound;
   import com.popcap.flash.bejeweledblitz.logic.Gem;
   import com.popcap.flash.bejeweledblitz.logic.raregems.RGLogic;
   import com.popcap.flash.framework.resources.images.ImageInst;
   import com.popcap.flash.games.blitz3game.resources.Blitz3GameImages;
   import com.popcap.flash.games.blitz3game.resources.Blitz3GameSounds;
   import flash.display.Bitmap;
   import flash.geom.ColorTransform;
   
   public class GemShatterEffect extends SpriteEffect
   {
       
      
      private var m_App:Blitz3App;
      
      private var m_ShatterType:int = 0;
      
      private var m_Locus:Gem;
      
      private var m_ExplodeAnim:ImageInst;
      
      private var m_ExplodeBitmap:Bitmap;
      
      private var m_Timer:int = 0;
      
      private var m_IsShatterDone:Boolean = false;
      
      private var m_IsExplodeDone:Boolean = false;
      
      private var m_IsDone:Boolean = false;
      
      private var m_ShardParticles:Vector.<GemShardParticle>;
      
      public function GemShatterEffect(param1:Blitz3App, param2:Gem)
      {
         super();
         this.m_App = param1;
         x = param2.x * 40 + 20;
         y = param2.y * 40 + 20;
         this.m_ShatterType = param2.shatterType;
         this.m_Locus = param2;
         this.Init();
         cacheAsBitmap = true;
      }
      
      public function SetColor(param1:Bitmap, param2:int) : void
      {
         var _loc3_:ColorTransform = param1.transform.colorTransform;
         switch(param2)
         {
            case Gem.COLOR_RED:
               _loc3_.redMultiplier = 2;
               _loc3_.greenMultiplier = 0;
               _loc3_.blueMultiplier = 0;
               break;
            case Gem.COLOR_ORANGE:
               _loc3_.redMultiplier = 2;
               _loc3_.greenMultiplier = 1;
               _loc3_.blueMultiplier = 0;
               break;
            case Gem.COLOR_YELLOW:
               _loc3_.redMultiplier = 2;
               _loc3_.greenMultiplier = 2;
               _loc3_.blueMultiplier = 0;
               break;
            case Gem.COLOR_GREEN:
               _loc3_.redMultiplier = 0;
               _loc3_.greenMultiplier = 2;
               _loc3_.blueMultiplier = 0;
               break;
            case Gem.COLOR_BLUE:
               _loc3_.redMultiplier = 0;
               _loc3_.greenMultiplier = 0;
               _loc3_.blueMultiplier = 2;
               break;
            case Gem.COLOR_PURPLE:
               _loc3_.redMultiplier = 2;
               _loc3_.greenMultiplier = 0;
               _loc3_.blueMultiplier = 2;
               break;
            case Gem.COLOR_WHITE:
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
      
      override public function IsDone() : Boolean
      {
         return this.m_IsDone;
      }
      
      override public function Update() : void
      {
         var _loc1_:GemShardParticle = null;
         var _loc2_:RGLogic = null;
         if(this.m_IsDone)
         {
            return;
         }
         this.m_IsShatterDone = true;
         if(!this.m_App.isLQMode)
         {
            for each(_loc1_ in this.m_ShardParticles)
            {
               _loc1_.Update();
               this.m_IsShatterDone = this.m_IsShatterDone && _loc1_.IsDone();
            }
         }
         this.m_ExplodeAnim.mFrame = int(this.m_Timer * 0.01 * 15);
         this.m_ExplodeBitmap.x = -(this.m_ExplodeAnim.width * 0.5);
         this.m_ExplodeBitmap.y = -(this.m_ExplodeAnim.height * 0.5);
         if(this.m_ExplodeAnim.mFrame >= this.m_ExplodeAnim.mSource.mNumFrames)
         {
            this.m_IsExplodeDone = true;
            this.m_ExplodeBitmap.visible = false;
         }
         else
         {
            this.m_ExplodeBitmap.bitmapData = this.m_ExplodeAnim.pixels;
         }
         if(this.m_IsExplodeDone && this.m_IsShatterDone)
         {
            this.m_IsDone = true;
         }
         if(this.m_Timer == 0)
         {
            if(this.m_ShatterType != Gem.TYPE_FLAME)
            {
               _loc2_ = this.m_App.logic.rareGemsLogic.currentRareGem;
               if(_loc2_ != null && SoundPlayer.isPlaying(_loc2_.getStringID() + "DynamicSound" + DynamicRareGemSound.EXPLOSION_ID))
               {
                  this.m_App.SoundManager.playSound(Blitz3GameSounds.SOUND_GEM_STAR_SHATTER,1,Blitz3App.REDUCED_EXPLOSION_VOLUME);
               }
               else
               {
                  this.m_App.SoundManager.playSound(Blitz3GameSounds.SOUND_GEM_STAR_SHATTER);
               }
            }
         }
         ++this.m_Timer;
      }
      
      private function Init() : void
      {
         var _loc1_:int = 0;
         var _loc2_:GemShardParticle = null;
         this.m_ExplodeAnim = this.m_App.ImageManager.getImageInst(Blitz3GameImages.IMAGE_GEM_EFFECT_DISTORT);
         this.m_ExplodeBitmap = new Bitmap(this.m_ExplodeAnim.pixels);
         if(this.m_Locus.shatterType != Gem.TYPE_FLAME)
         {
            this.SetColor(this.m_ExplodeBitmap,this.m_Locus.color);
         }
         addChild(this.m_ExplodeBitmap);
         if(!this.m_App.isLQMode)
         {
            this.m_ShardParticles = new Vector.<GemShardParticle>();
            _loc1_ = 0;
            while(_loc1_ < 4)
            {
               _loc2_ = new GemShardParticle(this.m_App,this.m_Locus);
               this.m_ShardParticles.push(_loc2_);
               addChild(_loc2_);
               _loc1_++;
            }
         }
      }
   }
}
