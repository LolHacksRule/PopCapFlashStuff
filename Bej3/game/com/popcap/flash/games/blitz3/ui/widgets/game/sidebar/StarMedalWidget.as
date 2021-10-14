package com.popcap.flash.games.blitz3.ui.widgets.game.sidebar
{
   import com.popcap.flash.framework.resources.images.ImageManager;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.Sprite;
   import flash.filters.GlowFilter;
   import flash.geom.Rectangle;
   import flash.text.TextField;
   import flash.text.TextFormat;
   import flash.text.TextFormatAlign;
   
   public class StarMedalWidget extends Sprite
   {
       
      
      private var mApp:Blitz3Game;
      
      private var mIsInited:Boolean = false;
      
      private var mTimer:int;
      
      private var mNextThreshold:int;
      
      private var mMedalBitmap:Bitmap;
      
      private var mRaysBitmap:Bitmap;
      
      private var mMedalSprite:Sprite;
      
      private var mRaysSprite:Sprite;
      
      private var mMedalText:TextField;
      
      private var mNewMedalText:TextField;
      
      private var mTextMask:Sprite;
      
      private var mIsStarted:Boolean;
      
      public function StarMedalWidget(app:Blitz3Game)
      {
         super();
         this.mApp = app;
      }
      
      public function Init() : void
      {
         this.mNextThreshold = this.mApp.starMedalTable.GetNextThreshold(0);
         var imgMan:ImageManager = this.mApp.imageManager;
         this.mRaysSprite = new Sprite();
         this.mRaysSprite.scaleX = 1;
         this.mRaysSprite.scaleY = 1;
         this.mMedalSprite = new Sprite();
         this.mMedalBitmap = new Bitmap();
         this.mMedalBitmap.bitmapData = this.mApp.starMedalTable.GetMedal(25000);
         this.mMedalBitmap.x = -this.mMedalBitmap.width * 0.5;
         this.mMedalBitmap.y = -this.mMedalBitmap.height * 0.5;
         var rect:Rectangle = this.mRaysSprite.getRect(this);
         this.mMedalSprite.x = rect.width * 0.5;
         this.mMedalSprite.y = rect.height * 0.5;
         this.mMedalSprite.addChild(this.mMedalBitmap);
         var aFormat:TextFormat = new TextFormat();
         aFormat.font = Blitz3Fonts.BLITZ_STANDARD;
         aFormat.size = 14;
         aFormat.align = TextFormatAlign.CENTER;
         var aGlow:GlowFilter = new GlowFilter(0,1,2,2,200);
         this.mMedalText = new TextField();
         this.mMedalText.embedFonts = true;
         this.mMedalText.textColor = 16777215;
         this.mMedalText.defaultTextFormat = aFormat;
         this.mMedalText.filters = [aGlow];
         this.mMedalText.width = 0;
         this.mMedalText.height = 0;
         this.mMedalText.y = 70;
         this.mMedalText.alpha = 1;
         this.mMedalText.selectable = false;
         this.mNewMedalText = new TextField();
         this.mNewMedalText.embedFonts = true;
         this.mNewMedalText.textColor = 16777215;
         this.mNewMedalText.defaultTextFormat = aFormat;
         this.mNewMedalText.filters = [aGlow];
         this.mNewMedalText.width = 0;
         this.mNewMedalText.height = 0;
         this.mNewMedalText.y = 20;
         this.mNewMedalText.selectable = false;
         this.mTextMask = new Sprite();
         this.mTextMask.graphics.beginFill(0);
         this.mTextMask.graphics.drawRect(0,0,90,60);
         this.mTextMask.graphics.endFill();
         this.mIsInited = true;
      }
      
      public function Reset() : void
      {
         visible = false;
         this.mIsStarted = false;
         this.mNextThreshold = this.mApp.starMedalTable.GetNextThreshold(0);
      }
      
      public function Update() : void
      {
         var newMedal:Boolean = false;
         if(this.mApp.logic.timerLogic.IsPaused())
         {
            return;
         }
         var score:int = this.mApp.logic.scoreKeeper.score;
         if(score >= this.mNextThreshold && this.mNextThreshold > 0)
         {
            newMedal = score > this.mApp.currentHighScore;
            this.ShowMedal(score,newMedal);
            this.mNextThreshold = this.mApp.starMedalTable.GetNextThreshold(score);
            alpha = 1;
            visible = true;
         }
         if(!visible)
         {
            return;
         }
         ++this.mTimer;
         var animSpeed:int = 4;
         if(this.mTimer <= 4 * animSpeed && this.mTimer >= 0)
         {
            this.mMedalSprite.scaleX = this.Animate(1,4 * animSpeed,this.mTimer,2,1);
            this.mMedalSprite.scaleY = this.Animate(1,4 * animSpeed,this.mTimer,0.1,1);
         }
         else if(this.mTimer <= 8 * animSpeed && this.mTimer > 4 * animSpeed)
         {
            this.mMedalSprite.scaleX = this.Animate(4 * animSpeed + 1,8 * animSpeed,this.mTimer,1,0.8);
            this.mMedalSprite.scaleY = this.Animate(4 * animSpeed + 1,8 * animSpeed,this.mTimer,1,1.35);
         }
         else if(this.mTimer <= 12 * animSpeed && this.mTimer > 8 * animSpeed)
         {
            this.mMedalSprite.scaleX = this.Animate(8 * animSpeed + 1,12 * animSpeed,this.mTimer,0.8,1);
            this.mMedalSprite.scaleY = this.Animate(8 * animSpeed + 1,12 * animSpeed,this.mTimer,1.35,1);
         }
         else
         {
            this.mMedalSprite.scaleX = 1;
            this.mMedalSprite.scaleY = 1;
         }
         if(this.mTimer <= 48)
         {
            this.mMedalText.alpha = this.Animate(1,48,this.mTimer,0,1);
         }
         else
         {
            this.mMedalText.alpha = 1;
         }
         if(this.mTimer <= 12 * animSpeed && this.mTimer > 4 * animSpeed)
         {
            this.mRaysSprite.scaleX = this.Animate(4 * animSpeed + 1,12 * animSpeed,this.mTimer,0,1.25);
            this.mRaysSprite.scaleY = this.Animate(4 * animSpeed + 1,12 * animSpeed,this.mTimer,0,1.25);
         }
         if(this.mTimer <= 48 * animSpeed && this.mTimer > 4 * animSpeed)
         {
            this.mNewMedalText.x = this.Animate(4 * animSpeed + 1,48 * animSpeed,this.mTimer,100,-110);
         }
         if(this.mTimer >= 300 && this.mTimer < 500)
         {
            alpha = this.Animate(300,499,this.mTimer,1,0);
            if(alpha <= 0)
            {
               visible = false;
            }
         }
         if(this.mTimer >= 500)
         {
         }
      }
      
      public function Draw() : void
      {
      }
      
      public function ShowMedal(score:int, newMedal:Boolean) : void
      {
         var tmpStr:String = null;
         this.mTimer = 0;
         var bd:BitmapData = this.mApp.starMedalTable.GetMedal(score);
         this.mMedalBitmap.bitmapData = bd;
         this.mMedalBitmap.smoothing = true;
         this.mNewMedalText.htmlText = newMedal == true ? this.mApp.locManager.GetLocString("UI_NEW_MEDAL") : "";
         this.mNewMedalText.width = this.mNewMedalText.textWidth + 5;
         this.mNewMedalText.height = this.mNewMedalText.textHeight;
         var next:int = this.mApp.starMedalTable.GetNextThreshold(score);
         if(next < score)
         {
            this.mMedalText.htmlText = this.mApp.locManager.GetLocString("UI_TOP_MEDAL");
         }
         else
         {
            tmpStr = this.mApp.locManager.GetLocString("UI_NEXT_MEDAL");
            tmpStr = tmpStr.replace("%s","" + next / 1000);
            this.mMedalText.htmlText = tmpStr;
         }
         this.mMedalText.width = this.mMedalText.textWidth + 5;
         this.mMedalText.height = this.mMedalText.textHeight;
      }
      
      private function Animate(startTime:int, endTime:int, currentTime:int, startPos:Number, endPos:Number) : Number
      {
         var elapsed:Number = currentTime - startTime;
         var span:Number = endTime - startTime;
         var percent:Number = elapsed / span;
         return Number(startPos + (endPos - startPos) * percent);
      }
   }
}
