package com.popcap.flash.games.blitz3.ui.widgets.game
{
   import caurina.transitions.Tweener;
   import com.popcap.flash.framework.misc.CurvedValPoint;
   import com.popcap.flash.framework.misc.CustomCurvedVal;
   import com.popcap.flash.framework.resources.images.ImageManager;
   import com.popcap.flash.games.blitz3.Blitz3App;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.BlendMode;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import mx.core.BitmapAsset;
   
   public class BackgroundWidget extends Sprite
   {
      
      [Embed(source="/../resources/images/bckgrnd_1.jpg")]
      private static const IMAGE_BG_X1:Class = BackgroundWidget_IMAGE_BG_X1;
      
      public static const NUM_BACKGROUNDS:int = 8;
      
      public static const ANIM_TIME:int = 50;
       
      
      private var mApp:Blitz3App;
      
      private var mIsInited:Boolean = false;
      
      private var mIndex:int = 0;
      
      private var mCurrentBackground:int = 1;
      
      private var mBackgroundImages:Vector.<BitmapData>;
      
      private var mBitmap:Bitmap;
      
      private var mFlash:Bitmap;
      
      private var mTimer:int = 0;
      
      private var mFlashCurve:CustomCurvedVal;
      
      private var mTopClip:MovieClip;
      
      private var mBottomClip:MovieClip;
      
      public function BackgroundWidget(app:Blitz3App)
      {
         super();
         this.mApp = app;
      }
      
      public function Init() : void
      {
         var imgMan:ImageManager = this.mApp.imageManager;
         this.mBackgroundImages = new Vector.<BitmapData>(NUM_BACKGROUNDS,true);
         this.mBackgroundImages[0] = (new IMAGE_BG_X1() as BitmapAsset).bitmapData;
         this.mFlash = new Bitmap(this.mBackgroundImages[0]);
         this.mFlash.blendMode = BlendMode.ADD;
         this.mFlash.alpha = 0;
         this.mFlashCurve = new CustomCurvedVal();
         this.mFlashCurve.setInRange(0,1);
         this.mFlashCurve.setOutRange(0,1);
         this.mFlashCurve.setCurve(true,new CurvedValPoint(0,0,0),new CurvedValPoint(0.1,1,0),new CurvedValPoint(0.334,0,0),new CurvedValPoint(0.43,0.5,0),new CurvedValPoint(0.666,0,0),new CurvedValPoint(0.766,0.25,0),new CurvedValPoint(1,0,0));
         this.mIsInited = true;
      }
      
      public function Reset() : void
      {
         this.mIndex = 0;
      }
      
      public function Update() : void
      {
      }
      
      public function Draw() : void
      {
         if(this.mTimer == 0)
         {
            return;
         }
         var progress:Number = 1 - this.mTimer / ANIM_TIME;
         var alpha:Number = 2 * this.mFlashCurve.getOutValue(progress);
         this.mFlash.alpha = alpha;
      }
      
      public function setBackgrounds(topClip:MovieClip, bottomClip:MovieClip) : void
      {
         this.mTopClip = topClip;
         this.mTopClip.gotoAndStop(1);
         this.mTopClip.alpha = 1;
         this.mBottomClip = bottomClip;
         this.mBottomClip.gotoAndStop(2);
         this.mBottomClip.alpha = 0;
         addChild(this.mBottomClip);
         addChild(this.mTopClip);
      }
      
      public function flipBackgrounds() : void
      {
         ++this.mCurrentBackground;
         if(this.mCurrentBackground > this.mTopClip.totalFrames)
         {
            this.mCurrentBackground = 1;
         }
         var oldBackground:int = this.mCurrentBackground - 1;
         if(oldBackground <= 0)
         {
            oldBackground = this.mTopClip.totalFrames;
         }
         this.mTopClip.gotoAndStop(this.mCurrentBackground);
         this.mBottomClip.gotoAndStop(oldBackground);
         this.mTopClip.alpha = 0;
         this.mBottomClip.alpha = 1;
         Tweener.addTween(this.mTopClip,{
            "alpha":1,
            "time":2,
            "transition":"easeOutQuad"
         });
         Tweener.addTween(this.mBottomClip,{
            "alpha":0,
            "time":2,
            "transition":"easeOutQuad"
         });
      }
      
      public function swapClips() : void
      {
         trace("Swapping clips: " + this.mCurrentBackground);
         this.mTopClip.gotoAndStop(this.mCurrentBackground);
         this.mBottomClip.gotoAndStop(this.mCurrentBackground + 1);
         this.mTopClip.alpha = 1;
         this.mBottomClip.alpha = 0;
         trace("top clip frame: " + this.mTopClip.currentFrame);
         trace("bottom clip frame: " + this.mBottomClip.currentFrame);
      }
      
      public function traceComplete() : void
      {
         trace("Bottom clip is complete");
      }
      
      public function resetBackgrounds() : void
      {
         this.mCurrentBackground = 1;
         this.mTopClip.gotoAndStop(1);
         this.mBottomClip.gotoAndStop(2);
         this.mBottomClip.alpha = 0;
      }
   }
}
