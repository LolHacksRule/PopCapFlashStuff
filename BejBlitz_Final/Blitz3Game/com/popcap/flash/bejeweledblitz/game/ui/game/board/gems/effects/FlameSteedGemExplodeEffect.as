package com.popcap.flash.bejeweledblitz.game.ui.game.board.gems.effects
{
   import com.popcap.flash.bejeweledblitz.game.Blitz3App;
   import com.popcap.flash.bejeweledblitz.game.ui.game.board.gems.GemSprite;
   import com.popcap.flash.framework.misc.CurvedValPoint;
   import com.popcap.flash.framework.misc.CustomCurvedVal;
   import com.popcap.flash.framework.resources.images.ImageInst;
   import com.popcap.flash.games.blitz3game.resources.Blitz3GameImages;
   import com.popcap.flash.games.blitz3game.resources.Blitz3GameSounds;
   import flash.display.Bitmap;
   
   public class FlameSteedGemExplodeEffect extends SpriteEffect
   {
      
      public static const MAX_TIME:int = 30;
       
      
      private var m_App:Blitz3App;
      
      private var mExplosionImage:ImageInst;
      
      private var mScaleCurve:CustomCurvedVal;
      
      private var mAlphaCurve:CustomCurvedVal;
      
      private var mTimer:int = 0;
      
      private var mT1:Number = 0;
      
      private var mT2:Number = 0;
      
      private var mT3:Number = 0;
      
      private var mFlame1:Bitmap;
      
      private var mFlame2:Bitmap;
      
      private var mFlame3:Bitmap;
      
      private var mIsDead:Boolean = false;
      
      public function FlameSteedGemExplodeEffect(param1:Blitz3App, param2:GemSprite)
      {
         super();
         this.m_App = param1;
         x = param2.x;
         y = param2.y;
         this.mScaleCurve = new CustomCurvedVal();
         this.mScaleCurve.setInRange(0,1);
         this.mScaleCurve.setOutRange(0.33,1.2);
         this.mScaleCurve.setCurve(true,new CurvedValPoint(0,0.33,0),new CurvedValPoint(1,1.2,0));
         this.mAlphaCurve = new CustomCurvedVal();
         this.mAlphaCurve.setInRange(0,1);
         this.mAlphaCurve.setOutRange(0,1);
         this.mAlphaCurve.setCurve(true,new CurvedValPoint(0,1,0),new CurvedValPoint(1,0,0));
         this.init();
      }
      
      private function init() : void
      {
         this.mExplosionImage = this.m_App.ImageManager.getImageInst(Blitz3GameImages.IMAGE_GEM_FLAME_EFFECT_EXPLODE_STEED);
         this.mFlame1 = new Bitmap(this.mExplosionImage.pixels);
         this.mFlame2 = new Bitmap(this.mExplosionImage.pixels);
         this.mFlame3 = new Bitmap(this.mExplosionImage.pixels);
         addChild(this.mFlame1);
         addChild(this.mFlame2);
         addChild(this.mFlame3);
      }
      
      override public function Update() : void
      {
         if(this.mIsDead == true)
         {
            return;
         }
         this.mT1 = this.mTimer / MAX_TIME;
         this.mT2 = (this.mTimer - 10) / MAX_TIME;
         this.mT3 = (this.mTimer - 20) / MAX_TIME;
         if(this.mT3 >= 1)
         {
            this.mIsDead = true;
         }
         if(this.mTimer == 0)
         {
            this.m_App.SoundManager.playSound(Blitz3GameSounds.SOUND_BLAZING_STEED_EXPLODE);
         }
         ++this.mTimer;
      }
      
      override public function Draw() : void
      {
         if(this.mIsDead == true)
         {
            return;
         }
         this.DrawExplosion(this.mFlame1,this.mT1);
         this.DrawExplosion(this.mFlame2,this.mT2);
         this.DrawExplosion(this.mFlame3,this.mT3);
      }
      
      override public function IsDone() : Boolean
      {
         return this.mIsDead;
      }
      
      private function DrawExplosion(param1:Bitmap, param2:Number) : void
      {
         var _loc3_:Number = NaN;
         if(param2 < 0)
         {
            param1.visible = false;
            return;
         }
         param1.visible = true;
         _loc3_ = this.mScaleCurve.getOutValue(param2);
         param1.scaleX = _loc3_;
         param1.scaleY = _loc3_;
         param1.x = -(param1.width * 0.5);
         param1.y = -(param1.height * 0.5);
         param1.alpha = this.mAlphaCurve.getOutValue(param2);
      }
   }
}
