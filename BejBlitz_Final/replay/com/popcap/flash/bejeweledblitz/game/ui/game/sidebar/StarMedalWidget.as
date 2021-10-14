package com.popcap.flash.bejeweledblitz.game.ui.game.sidebar
{
   import com.popcap.flash.bejeweledblitz.game.Blitz3App;
   import com.popcap.flash.framework.resources.images.BaseImageManager;
   import com.popcap.flash.games.blitz3game.resources.Blitz3GameFonts;
   import com.popcap.flash.games.blitz3game.resources.Blitz3GameImages;
   import com.popcap.flash.games.blitz3game.resources.Blitz3GameLoc;
   import flash.display.Bitmap;
   import flash.display.Shape;
   import flash.display.Sprite;
   import flash.filters.GlowFilter;
   import flash.geom.Rectangle;
   import flash.text.TextField;
   import flash.text.TextFormat;
   import flash.text.TextFormatAlign;
   
   public class StarMedalWidget extends Sprite
   {
       
      
      private var m_App:Blitz3App;
      
      private var m_Timer:int;
      
      private var m_NextThreshold:int;
      
      private var m_MedalBitmap:Bitmap;
      
      private var m_RaysBitmap:Bitmap;
      
      private var m_MedalSprite:Sprite;
      
      private var m_RaysSprite:Sprite;
      
      private var m_MedalText:TextField;
      
      private var m_NewMedalText:TextField;
      
      private var m_TextMask:Shape;
      
      private var m_IsStarted:Boolean;
      
      public function StarMedalWidget(app:Blitz3App)
      {
         super();
         this.m_App = app;
      }
      
      public function Init() : void
      {
         var aGlow:GlowFilter = null;
         this.m_NextThreshold = this.m_App.starMedalTable.GetNextThreshold(0);
         var imgMan:BaseImageManager = this.m_App.ImageManager;
         this.m_RaysSprite = new Sprite();
         this.m_RaysBitmap = new Bitmap(imgMan.getBitmapData(Blitz3GameImages.IMAGE_STARMEDAL_RAYS));
         this.m_RaysBitmap.smoothing = true;
         this.m_RaysBitmap.x = -this.m_RaysBitmap.width * 0.5;
         this.m_RaysBitmap.y = -this.m_RaysBitmap.height * 0.5 + 4;
         this.m_RaysSprite.addChild(this.m_RaysBitmap);
         this.m_RaysSprite.scaleX = 1;
         this.m_RaysSprite.scaleY = 1;
         this.m_RaysSprite.x = this.m_RaysBitmap.width * 0.5;
         this.m_RaysSprite.y = this.m_RaysBitmap.height * 0.5;
         this.m_MedalSprite = new Sprite();
         this.m_MedalBitmap = new Bitmap(this.m_App.starMedalTable.GetStampedMedal(500000));
         this.m_MedalBitmap.smoothing = true;
         this.m_MedalBitmap.width = 60;
         this.m_MedalBitmap.height = 60;
         this.m_MedalBitmap.x = -this.m_MedalBitmap.width * 0.5;
         this.m_MedalBitmap.y = -this.m_MedalBitmap.height * 0.5;
         this.m_MedalBitmap.filters = [new GlowFilter(0,1,4,4,2)];
         var rect:Rectangle = this.m_RaysSprite.getRect(this);
         this.m_MedalSprite.x = rect.width * 0.5;
         this.m_MedalSprite.y = rect.height * 0.5;
         this.m_MedalSprite.addChild(this.m_MedalBitmap);
         var aFormat:TextFormat = new TextFormat(Blitz3GameFonts.FONT_BLITZ_STANDARD,12);
         aFormat.align = TextFormatAlign.CENTER;
         aGlow = new GlowFilter(0,1,4,4,2);
         this.m_MedalText = new TextField();
         this.m_MedalText.embedFonts = true;
         this.m_MedalText.textColor = 16777215;
         this.m_MedalText.defaultTextFormat = aFormat;
         this.m_MedalText.filters = [aGlow];
         this.m_MedalText.width = 0;
         this.m_MedalText.height = 0;
         this.m_MedalText.y = 74;
         this.m_MedalText.alpha = 1;
         this.m_MedalText.selectable = false;
         this.m_MedalText.cacheAsBitmap = true;
         this.m_NewMedalText = new TextField();
         this.m_NewMedalText.embedFonts = true;
         this.m_NewMedalText.textColor = 16777215;
         this.m_NewMedalText.defaultTextFormat = aFormat;
         this.m_NewMedalText.filters = [aGlow];
         this.m_NewMedalText.width = 0;
         this.m_NewMedalText.height = 0;
         this.m_NewMedalText.y = 20;
         this.m_NewMedalText.selectable = false;
         this.m_TextMask = new Shape();
         this.m_TextMask.graphics.beginFill(0);
         this.m_TextMask.graphics.drawRect(0,0,90,60);
         this.m_TextMask.graphics.endFill();
         this.m_TextMask.cacheAsBitmap = true;
         this.m_NewMedalText.mask = this.m_TextMask;
         this.m_NewMedalText.cacheAsBitmap = true;
         addChild(this.m_RaysSprite);
         addChild(this.m_MedalSprite);
         addChild(this.m_MedalText);
         addChild(this.m_NewMedalText);
         addChild(this.m_TextMask);
         this.Reset();
      }
      
      public function Reset() : void
      {
         visible = false;
         this.m_IsStarted = false;
         this.m_NextThreshold = this.m_App.starMedalTable.GetNextThreshold(0);
      }
      
      public function Update() : void
      {
         if(this.m_App.logic.timerLogic.IsPaused())
         {
            return;
         }
         var score:int = this.m_App.logic.scoreKeeper.GetScore();
         if(score >= this.m_NextThreshold && this.m_NextThreshold > 0)
         {
            this.ShowMedal(score,score > this.m_App.sessionData.userData.HighScore);
            this.m_NextThreshold = this.m_App.starMedalTable.GetNextThreshold(score);
            alpha = 1;
            visible = true;
         }
         if(!visible)
         {
            return;
         }
         ++this.m_Timer;
         if(this.m_Timer <= 4 * 4 && this.m_Timer >= 0)
         {
            this.m_MedalSprite.scaleX = this.Animate(1,4 * 4,this.m_Timer,2,1);
            this.m_MedalSprite.scaleY = this.Animate(1,4 * 4,this.m_Timer,0.1,1);
         }
         else if(this.m_Timer <= 8 * 4 && this.m_Timer > 4 * 4)
         {
            this.m_MedalSprite.scaleX = this.Animate(4 * 4 + 1,8 * 4,this.m_Timer,1,0.8);
            this.m_MedalSprite.scaleY = this.Animate(4 * 4 + 1,8 * 4,this.m_Timer,1,1.35);
         }
         else if(this.m_Timer <= 12 * 4 && this.m_Timer > 8 * 4)
         {
            this.m_MedalSprite.scaleX = this.Animate(8 * 4 + 1,12 * 4,this.m_Timer,0.8,1);
            this.m_MedalSprite.scaleY = this.Animate(8 * 4 + 1,12 * 4,this.m_Timer,1.35,1);
         }
         else
         {
            this.m_MedalSprite.scaleX = 1;
            this.m_MedalSprite.scaleY = 1;
         }
         if(this.m_Timer <= 48)
         {
            this.m_MedalText.alpha = this.Animate(1,48,this.m_Timer,0,1);
         }
         else
         {
            this.m_MedalText.alpha = 1;
         }
         if(this.m_Timer <= 12 * 4 && this.m_Timer > 4 * 4)
         {
            this.m_RaysSprite.scaleX = this.Animate(4 * 4 + 1,12 * 4,this.m_Timer,0,1.25);
            this.m_RaysSprite.scaleY = this.Animate(4 * 4 + 1,12 * 4,this.m_Timer,0,1.25);
         }
         if(this.m_Timer <= 48 * 4 && this.m_Timer > 4 * 4)
         {
            this.m_NewMedalText.x = this.Animate(4 * 4 + 1,48 * 4,this.m_Timer,100,-110);
         }
         if(this.m_Timer >= 300 && this.m_Timer < 500)
         {
            alpha = this.Animate(300,499,this.m_Timer,1,0);
            if(alpha <= 0)
            {
               visible = false;
            }
         }
      }
      
      private function ShowMedal(score:int, newMedal:Boolean) : void
      {
         var tmpStr:String = null;
         this.m_Timer = 0;
         this.m_MedalBitmap.bitmapData = this.m_App.starMedalTable.GetStampedMedal(score);
         this.m_NewMedalText.htmlText = !!newMedal ? this.m_App.TextManager.GetLocString(Blitz3GameLoc.LOC_UI_NEW_MEDAL) : "";
         this.m_NewMedalText.width = this.m_NewMedalText.textWidth + 5;
         this.m_NewMedalText.height = this.m_NewMedalText.textHeight + 2;
         var next:int = this.m_App.starMedalTable.GetNextThreshold(score);
         if(next < score)
         {
            this.m_MedalText.htmlText = this.m_App.TextManager.GetLocString(Blitz3GameLoc.LOC_UI_TOP_MEDAL);
         }
         else
         {
            tmpStr = this.m_App.TextManager.GetLocString(Blitz3GameLoc.LOC_UI_NEXT_MEDAL);
            tmpStr = tmpStr.replace("%s","" + next * 0.001);
            this.m_MedalText.htmlText = tmpStr;
         }
         this.m_MedalText.width = this.m_MedalText.textWidth + 5;
         this.m_MedalText.height = this.m_MedalText.textHeight + 2;
         this.m_MedalText.x = this.m_MedalSprite.x - this.m_MedalText.width * 0.5;
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
