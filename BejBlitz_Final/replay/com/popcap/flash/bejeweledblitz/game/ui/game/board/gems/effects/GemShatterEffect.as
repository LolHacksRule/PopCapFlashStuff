package com.popcap.flash.bejeweledblitz.game.ui.game.board.gems.effects
{
   import com.popcap.flash.bejeweledblitz.game.Blitz3App;
   import com.popcap.flash.bejeweledblitz.logic.Gem;
   import com.popcap.flash.framework.resources.images.ImageInst;
   import com.popcap.flash.games.blitz3game.resources.Blitz3GameImages;
   import com.popcap.flash.games.blitz3game.resources.Blitz3GameSounds;
   import flash.display.Bitmap;
   import flash.display.BlendMode;
   import flash.geom.ColorTransform;
   
   public class GemShatterEffect extends SpriteEffect
   {
       
      
      private var m_App:Blitz3App;
      
      private var m_ShatterType:int = 0;
      
      private var m_Locus:Gem;
      
      private var m_ExplodeAnim:ImageInst;
      
      private var m_DistortAnim:ImageInst;
      
      private var m_ExplodeBitmap:Bitmap;
      
      private var m_Timer:int = 0;
      
      private var m_IsShatterDone:Boolean = false;
      
      private var m_IsExplodeDone:Boolean = false;
      
      private var m_IsDone:Boolean = false;
      
      private var m_ShardParticles:Vector.<GemShardParticle>;
      
      public function GemShatterEffect(app:Blitz3App, locus:Gem)
      {
         super();
         this.m_App = app;
         x = locus.x * 40 + 20;
         y = locus.y * 40 + 20;
         this.m_ShatterType = locus.mShatterType;
         this.m_Locus = locus;
         this.Init();
         cacheAsBitmap = true;
      }
      
      public function SetColor(bitmap:Bitmap, color:int) : void
      {
         var cTrans:ColorTransform = bitmap.transform.colorTransform;
         switch(color)
         {
            case Gem.COLOR_RED:
               cTrans.redMultiplier = 2;
               cTrans.greenMultiplier = 0;
               cTrans.blueMultiplier = 0;
               break;
            case Gem.COLOR_ORANGE:
               cTrans.redMultiplier = 2;
               cTrans.greenMultiplier = 1;
               cTrans.blueMultiplier = 0;
               break;
            case Gem.COLOR_YELLOW:
               cTrans.redMultiplier = 2;
               cTrans.greenMultiplier = 2;
               cTrans.blueMultiplier = 0;
               break;
            case Gem.COLOR_GREEN:
               cTrans.redMultiplier = 0;
               cTrans.greenMultiplier = 2;
               cTrans.blueMultiplier = 0;
               break;
            case Gem.COLOR_BLUE:
               cTrans.redMultiplier = 0;
               cTrans.greenMultiplier = 0;
               cTrans.blueMultiplier = 2;
               break;
            case Gem.COLOR_PURPLE:
               cTrans.redMultiplier = 2;
               cTrans.greenMultiplier = 0;
               cTrans.blueMultiplier = 2;
               break;
            case Gem.COLOR_WHITE:
               cTrans.redMultiplier = 2;
               cTrans.greenMultiplier = 2;
               cTrans.blueMultiplier = 2;
               break;
            default:
               cTrans.redMultiplier = 2;
               cTrans.greenMultiplier = 2;
               cTrans.blueMultiplier = 2;
         }
         bitmap.transform.colorTransform = cTrans;
      }
      
      override public function IsDone() : Boolean
      {
         return this.m_IsDone;
      }
      
      override public function Update() : void
      {
         var p:GemShardParticle = null;
         if(this.m_IsDone)
         {
            return;
         }
         this.m_IsShatterDone = true;
         for each(p in this.m_ShardParticles)
         {
            p.Update();
            this.m_IsShatterDone = this.m_IsShatterDone && p.IsDone();
         }
         this.m_ExplodeAnim.mFrame = int(this.m_Timer * 0.01 * 15);
         this.m_ExplodeBitmap.x = -(this.m_ExplodeAnim.width * 0.5);
         this.m_ExplodeBitmap.y = -(this.m_ExplodeAnim.height * 0.5);
         if(this.m_ExplodeAnim.mFrame >= this.m_ExplodeAnim.mSource.mNumFrames)
         {
            this.m_IsExplodeDone = true;
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
               this.m_App.SoundManager.playSound(Blitz3GameSounds.SOUND_GEM_STAR_SHATTER);
            }
         }
         ++this.m_Timer;
      }
      
      private function Init() : void
      {
         var particle:GemShardParticle = null;
         this.m_ExplodeAnim = this.m_App.ImageManager.getImageInst(Blitz3GameImages.IMAGE_GEM_EFFECT_EXPLODE);
         this.m_DistortAnim = this.m_App.ImageManager.getImageInst(Blitz3GameImages.IMAGE_GEM_EFFECT_DISTORT);
         this.m_ExplodeBitmap = new Bitmap(this.m_ExplodeAnim.pixels);
         this.m_ExplodeBitmap.alpha = 0.5;
         if(this.m_Locus.mShatterType != Gem.TYPE_FLAME)
         {
            this.m_ExplodeAnim = this.m_DistortAnim;
            this.m_ExplodeBitmap.blendMode = BlendMode.ADD;
            this.SetColor(this.m_ExplodeBitmap,this.m_Locus.color);
         }
         else
         {
            this.m_ExplodeBitmap.blendMode = BlendMode.ADD;
         }
         addChild(this.m_ExplodeBitmap);
         this.m_ShardParticles = new Vector.<GemShardParticle>();
         for(var i:int = 0; i < 4; i++)
         {
            particle = new GemShardParticle(this.m_App,this.m_Locus);
            this.m_ShardParticles.push(particle);
            addChild(particle);
         }
      }
   }
}
