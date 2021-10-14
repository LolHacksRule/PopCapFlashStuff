package com.popcap.flash.games.blitz3.ui.widgets.effects
{
   import com.popcap.flash.framework.misc.CurvedValPoint;
   import com.popcap.flash.framework.misc.CustomCurvedVal;
   import com.popcap.flash.framework.resources.images.ImageInst;
   import com.popcap.flash.games.bej3.Gem;
   import com.popcap.flash.games.blitz3.Blitz3App;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   
   public class FlameGemExplodeEffect extends SpriteEffect
   {
      
      public static const MAX_TIME:int = 30;
       
      
      private var mApp:Blitz3App;
      
      private var mExplosionImage:ImageInst;
      
      private var mDistortImage:ImageInst;
      
      private var mScaleCurve:CustomCurvedVal;
      
      private var mAlphaCurve:CustomCurvedVal;
      
      private var mTimer:int = 0;
      
      private var mT1:Number = 0;
      
      private var mT2:Number = 0;
      
      private var mT3:Number = 0;
      
      private var mFlame1:Sprite;
      
      private var mFlame2:Sprite;
      
      private var mFlame3:Sprite;
      
      private var mIsDead:Boolean = false;
      
      public function FlameGemExplodeEffect(app:Blitz3App, locus:Gem)
      {
         super();
         this.mApp = app;
         x = locus.x * 40 + 20;
         y = locus.y * 40 + 20;
         this.mScaleCurve = new CustomCurvedVal();
         this.mScaleCurve.setInRange(0,1);
         this.mScaleCurve.setOutRange(0.33,1.2);
         this.mScaleCurve.setCurve(true,new CurvedValPoint(0,0.33),new CurvedValPoint(1,1.2));
         this.mAlphaCurve = new CustomCurvedVal();
         this.mAlphaCurve.setInRange(0,1);
         this.mAlphaCurve.setOutRange(0,1);
         this.mAlphaCurve.setCurve(true,new CurvedValPoint(0,1),new CurvedValPoint(1,0));
         this.init();
      }
      
      private function init() : void
      {
         var bitmap2:Bitmap = null;
         var bitmap3:Bitmap = null;
         this.mExplosionImage = this.mApp.imageManager.getImageInst(Blitz3Images.IMAGE_GEM_FLAME_EFFECT_EXPLODE);
         this.mDistortImage = this.mApp.imageManager.getImageInst(Blitz3Images.IMAGE_GEM_EFFECT_DISTORT);
         this.mDistortImage.mMatrix.scale(3,3);
         var bitmap1:Bitmap = new Bitmap(this.mExplosionImage.pixels);
         bitmap2 = new Bitmap(this.mExplosionImage.pixels);
         bitmap3 = new Bitmap(this.mExplosionImage.pixels);
         bitmap1.x = -(bitmap1.width / 2);
         bitmap1.y = -(bitmap1.height / 2);
         bitmap2.x = -(bitmap2.width / 2);
         bitmap2.y = -(bitmap2.height / 2);
         bitmap3.x = -(bitmap3.width / 2);
         bitmap3.y = -(bitmap3.height / 2);
         this.mFlame1 = new Sprite();
         this.mFlame2 = new Sprite();
         this.mFlame3 = new Sprite();
         this.mFlame1.addChild(bitmap1);
         this.mFlame2.addChild(bitmap2);
         this.mFlame3.addChild(bitmap3);
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
         this.mT1 = (this.mTimer - 0) / MAX_TIME;
         this.mT2 = (this.mTimer - 10) / MAX_TIME;
         this.mT3 = (this.mTimer - 20) / MAX_TIME;
         if(this.mT3 >= 1)
         {
            this.mIsDead = true;
         }
         if(this.mTimer == 0)
         {
            this.mApp.soundManager.playSound(Blitz3Sounds.SOUND_GEM_FLAME_EXPLODE);
         }
         ++this.mTimer;
      }
      
      override public function Draw(postFX:Boolean) : void
      {
         if(postFX)
         {
            return;
         }
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
      
      private function DrawExplosion(flame:Sprite, time:Number) : void
      {
         if(time < 0)
         {
            flame.visible = false;
            return;
         }
         flame.visible = true;
         var scale:Number = this.mScaleCurve.getOutValue(time);
         var offset:Number = (1 - scale) * (this.mExplosionImage.width / 2);
         flame.scaleX = scale;
         flame.scaleY = scale;
         flame.alpha = this.mAlphaCurve.getOutValue(time);
      }
   }
}
