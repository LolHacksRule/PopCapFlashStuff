package com.popcap.flash.games.blitz3.ui.widgets.game.board
{
   import com.popcap.flash.framework.misc.CurvedValPoint;
   import com.popcap.flash.framework.misc.CustomCurvedVal;
   import com.popcap.flash.games.blitz3.Blitz3App;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   
   public class BroadcastWidget extends Sprite
   {
      
      public static const ANIM_TIME:int = 175;
       
      
      private var mApp:Blitz3App;
      
      private var mAnimSprite:Sprite;
      
      private var mGoBitmap:Bitmap;
      
      private var mGoSprite:Sprite;
      
      private var mTimeUpBitmap:Bitmap;
      
      private var mTimeUpSprite:Sprite;
      
      private var mNoMoreMovesBitmap:Bitmap;
      
      private var mNoMoreMovesSprite:Sprite;
      
      private var mLevelCompleteBitmap:Bitmap;
      
      private var mLevelCompleteSprite:Sprite;
      
      private var mNewLevelSprite:Sprite;
      
      private var mTimer:int = 0;
      
      private var mAnimCurve:CustomCurvedVal;
      
      public function BroadcastWidget(app:Blitz3App)
      {
         super();
         this.mApp = app;
      }
      
      public function Init() : void
      {
         this.mAnimCurve = new CustomCurvedVal();
         this.mAnimCurve.setInRange(0,1);
         this.mAnimCurve.setOutRange(0,1);
         this.mAnimCurve.setCurve(true,new CurvedValPoint(0,0,0),new CurvedValPoint(35 / ANIM_TIME,1,0),new CurvedValPoint(135 / ANIM_TIME,1,0),new CurvedValPoint(1,0,0));
         this.mTimer = 0;
         this.mGoSprite = new Sprite();
         this.mGoBitmap = new Bitmap(this.mApp.imageManager.getBitmapData(Blitz3Images.IMAGE_TEXT_GO));
         this.mGoBitmap.x = -(this.mGoBitmap.width / 2);
         this.mGoBitmap.y = -(this.mGoBitmap.height / 2);
         this.mGoSprite.addChild(this.mGoBitmap);
         addChild(this.mGoSprite);
         this.mTimeUpSprite = new Sprite();
         this.mNoMoreMovesSprite = new Sprite();
         this.mNoMoreMovesBitmap = new Bitmap(this.mApp.imageManager.getBitmapData(Blitz3Images.IMAGE_TEXT_NO_MORE_MOVES));
         this.mNoMoreMovesBitmap.x = -(this.mNoMoreMovesBitmap.width / 2);
         this.mNoMoreMovesBitmap.y = -(this.mNoMoreMovesBitmap.height / 2);
         this.mNoMoreMovesSprite.addChild(this.mNoMoreMovesBitmap);
         this.mNoMoreMovesSprite.visible = false;
         addChild(this.mNoMoreMovesSprite);
         this.mLevelCompleteSprite = new Sprite();
         this.mLevelCompleteBitmap = new Bitmap(this.mApp.imageManager.getBitmapData(Blitz3Images.IMAGE_TEXT_LEVEL_COMPLETE));
         this.mLevelCompleteBitmap.x = -(this.mLevelCompleteBitmap.width / 2);
         this.mLevelCompleteBitmap.y = -(this.mLevelCompleteBitmap.height / 2);
         this.mLevelCompleteSprite.addChild(this.mLevelCompleteBitmap);
         this.mLevelCompleteSprite.visible = false;
         addChild(this.mLevelCompleteSprite);
      }
      
      public function Reset() : void
      {
         this.mGoSprite.visible = false;
         this.mTimeUpSprite.visible = false;
         this.mNoMoreMovesSprite.visible = false;
         this.mLevelCompleteSprite.visible = false;
         if(this.mNewLevelSprite != null)
         {
            this.mNewLevelSprite.visible = false;
         }
      }
      
      public function Update() : void
      {
         var time:Number = NaN;
         var value:Number = NaN;
         if(this.mApp.logic.timerLogic.IsPaused())
         {
            return;
         }
         if(this.mTimer > 0)
         {
            --this.mTimer;
            time = (ANIM_TIME - this.mTimer) / ANIM_TIME;
            value = this.mAnimCurve.getOutValue(time);
            this.mAnimSprite.scaleX = value;
            this.mAnimSprite.scaleY = value;
            this.mAnimSprite.alpha = value;
            if(this.mTimer == 0)
            {
               this.mGoSprite.visible = false;
               this.mTimeUpSprite.visible = false;
               this.mNoMoreMovesSprite.visible = false;
               this.mLevelCompleteSprite.visible = false;
               if(this.mNewLevelSprite != null)
               {
                  this.mNewLevelSprite.visible = false;
               }
            }
         }
      }
      
      public function Draw() : void
      {
      }
      
      public function PlayGo() : void
      {
         this.mAnimSprite = this.mGoSprite;
         this.mAnimSprite.visible = true;
         this.mTimer = ANIM_TIME;
      }
      
      public function PlayTimeUp() : void
      {
         this.mAnimSprite = this.mTimeUpSprite;
         this.mAnimSprite.visible = true;
         this.mTimer = ANIM_TIME;
      }
      
      public function PlayNoMoreMoves() : void
      {
         this.mAnimSprite = this.mNoMoreMovesSprite;
         this.mAnimSprite.visible = true;
         this.mTimer = ANIM_TIME;
      }
      
      public function PlayLevelComplete() : void
      {
         this.mAnimSprite = this.mLevelCompleteSprite;
         this.mAnimSprite.visible = true;
         this.mTimer = ANIM_TIME;
      }
      
      public function PlayStartNewLevel(level:int) : void
      {
         var bitmap1:Bitmap = null;
         var bitmap2:Bitmap = null;
         var imageName:String = null;
         var imageName2:String = null;
         var firstDigit:String = null;
         var secondDigit:String = null;
         this.mNewLevelSprite = new Sprite();
         var levelBitmap:Bitmap = new Bitmap(this.mApp.imageManager.getBitmapData(Blitz3Images.IMAGE_TEXT_LEVEL));
         var stringSprite:Sprite = new Sprite();
         stringSprite.addChild(levelBitmap);
         if(level < 10)
         {
            imageName = "IMAGE_TEXT_" + level.toString();
            bitmap1 = new Bitmap(this.mApp.imageManager.getBitmapData(imageName));
            bitmap1.x = 160;
            stringSprite.addChild(bitmap1);
         }
         else
         {
            firstDigit = String(int(level / 10));
            secondDigit = String(int(level % 10));
            imageName = "IMAGE_TEXT_" + firstDigit;
            bitmap1 = new Bitmap(this.mApp.imageManager.getBitmapData(imageName));
            bitmap1.x = 160;
            stringSprite.addChild(bitmap1);
            imageName2 = "IMAGE_TEXT_" + secondDigit;
            bitmap2 = new Bitmap(this.mApp.imageManager.getBitmapData(imageName2));
            bitmap2.x = bitmap1.x + bitmap1.width - 15;
            stringSprite.addChild(bitmap2);
         }
         stringSprite.x = -stringSprite.width / 2;
         stringSprite.y = -stringSprite.height / 2;
         this.mNewLevelSprite.addChild(stringSprite);
         this.mAnimSprite = this.mNewLevelSprite;
         this.mAnimSprite.visible = true;
         this.mTimer = ANIM_TIME;
         addChild(this.mNewLevelSprite);
      }
   }
}
