package com.popcap.flash.games.blitz3.ui.widgets.game.sidebar
{
   import com.popcap.flash.games.blitz3.Blitz3App;
   import flash.display.Sprite;
   import flash.filters.GlowFilter;
   import flash.geom.Rectangle;
   import flash.text.TextField;
   import flash.text.TextFormat;
   import flash.text.TextFormatAlign;
   
   public class SpeedBonusWidget extends Sprite
   {
      
      public static const BULGE_TIME:int = 25;
      
      public static const FADE_TIME:int = 100;
      
      public static const TEXTFIELD_PADDING:int = 5;
       
      
      private var mApp:Blitz3App;
      
      private var mNormalBulgeSprite:Sprite;
      
      private var mNormalTextSprite:Sprite;
      
      private var mNormalLevelText:TextField;
      
      private var mNormalBonusText:TextField;
      
      private var mBlazeBulgeSprite:Sprite;
      
      private var mBlazeTextSprite:Sprite;
      
      private var mBlazeLevelText:TextField;
      
      private var mBlazeBonusText:TextField;
      
      private var mLastLevel:int = 0;
      
      private var mBulgeTimer:int = 0;
      
      private var mFadeTimer:int = 0;
      
      private var mShadeGlow:GlowFilter;
      
      private var mBrightGlow:GlowFilter;
      
      private var mScrollRect:Rectangle;
      
      public function SpeedBonusWidget(app:Blitz3App)
      {
         this.mShadeGlow = new GlowFilter(0,1,2,2);
         this.mBrightGlow = new GlowFilter(16777215,1,2,2);
         this.mScrollRect = new Rectangle(0,0,0,100);
         super();
         this.mApp = app;
      }
      
      public function Init() : void
      {
         var levelFormat:TextFormat = new TextFormat();
         levelFormat.font = Blitz3Fonts.BLITZ_STANDARD;
         levelFormat.size = 14;
         levelFormat.align = TextFormatAlign.CENTER;
         this.mNormalLevelText = new TextField();
         this.mBlazeLevelText = new TextField();
         this.mNormalLevelText.embedFonts = true;
         this.mNormalLevelText.textColor = 16777215;
         this.mNormalLevelText.defaultTextFormat = levelFormat;
         this.mNormalLevelText.htmlText = this.mApp.locManager.GetLocString("GAMEPLAY_BONUS_SPEED") + 1000;
         this.mNormalLevelText.filters = [this.mShadeGlow];
         this.mNormalLevelText.width = this.mNormalLevelText.textWidth + TEXTFIELD_PADDING;
         this.mNormalLevelText.height = this.mNormalLevelText.textHeight + TEXTFIELD_PADDING;
         this.mNormalLevelText.x = 0;
         this.mNormalLevelText.y = 0;
         this.mBlazeLevelText.embedFonts = true;
         this.mBlazeLevelText.textColor = 16777215;
         this.mBlazeLevelText.defaultTextFormat = levelFormat;
         this.mBlazeLevelText.filters = [this.mShadeGlow];
         this.mBlazeLevelText.htmlText = this.mNormalLevelText.text;
         this.mBlazeLevelText.width = this.mBlazeLevelText.textWidth + TEXTFIELD_PADDING;
         this.mBlazeLevelText.height = this.mBlazeLevelText.textHeight + TEXTFIELD_PADDING;
         this.mBlazeLevelText.x = 0;
         this.mBlazeLevelText.y = 0;
         var bonusFormat:TextFormat = new TextFormat();
         bonusFormat.font = Blitz3Fonts.BLITZ_STANDARD;
         bonusFormat.size = 14;
         bonusFormat.align = TextFormatAlign.CENTER;
         this.mNormalBonusText = new TextField();
         this.mNormalBonusText.embedFonts = true;
         this.mNormalBonusText.textColor = 16777215;
         this.mNormalBonusText.defaultTextFormat = bonusFormat;
         this.mNormalBonusText.filters = [this.mShadeGlow];
         this.mNormalBonusText.width = 80;
         this.mNormalBonusText.height = 22;
         this.mNormalBonusText.x = 0;
         this.mNormalBonusText.y = 0;
         this.mBlazeBonusText = new TextField();
         this.mBlazeBonusText.embedFonts = true;
         this.mBlazeBonusText.textColor = 16777215;
         this.mBlazeBonusText.defaultTextFormat = bonusFormat;
         this.mBlazeBonusText.filters = [this.mShadeGlow];
         this.mBlazeBonusText.width = 80;
         this.mBlazeBonusText.height = 22;
         this.mBlazeBonusText.x = 0;
         this.mBlazeBonusText.y = 0;
         this.mNormalTextSprite = new Sprite();
         this.mNormalTextSprite.addChild(this.mNormalLevelText);
         this.mNormalTextSprite.x = -this.mNormalLevelText.width / 2;
         this.mNormalTextSprite.y = -this.mNormalLevelText.height / 2;
         this.mBlazeTextSprite = new Sprite();
         this.mBlazeTextSprite.addChild(this.mBlazeLevelText);
         this.mBlazeTextSprite.x = -this.mBlazeLevelText.width / 2;
         this.mBlazeTextSprite.y = -this.mBlazeLevelText.height / 2;
         this.mScrollRect.width = this.mBlazeTextSprite.width;
         this.mScrollRect.height = 44;
         this.mBlazeTextSprite.scrollRect = this.mScrollRect;
         this.mNormalBulgeSprite = new Sprite();
         this.mNormalBulgeSprite.addChild(this.mNormalTextSprite);
         this.mNormalBulgeSprite.x = this.mNormalTextSprite.width / 2;
         this.mNormalBulgeSprite.y = this.mNormalTextSprite.height / 2;
         this.mBlazeBulgeSprite = new Sprite();
         this.mBlazeBulgeSprite.addChild(this.mBlazeTextSprite);
         this.mBlazeBulgeSprite.x = this.mBlazeTextSprite.width / 2;
         this.mBlazeBulgeSprite.y = this.mBlazeTextSprite.height / 2;
         addChild(this.mNormalBulgeSprite);
         addChild(this.mBlazeBulgeSprite);
      }
      
      public function Reset() : void
      {
         this.mFadeTimer = 0;
         this.mLastLevel = 0;
         this.mBulgeTimer = 0;
         this.mNormalBulgeSprite.visible = false;
         this.mBlazeBulgeSprite.visible = false;
      }
      
      public function Update() : void
      {
         if(this.mApp.logic.timerLogic.IsPaused())
         {
            return;
         }
         if(this.mApp.logic.speedBonus.GetLevel() > this.mLastLevel)
         {
            this.mLastLevel = this.mApp.logic.speedBonus.GetLevel();
            this.mBulgeTimer = BULGE_TIME;
         }
         if(this.mApp.logic.speedBonus.GetLevel() < this.mLastLevel && this.mLastLevel > 0)
         {
            --this.mFadeTimer;
            if(this.mFadeTimer == 0)
            {
               this.mLastLevel = 0;
            }
            this.mNormalBonusText.visible = false;
            this.mBlazeBonusText.visible = false;
         }
         else
         {
            this.mFadeTimer = FADE_TIME;
            this.mNormalBonusText.visible = true;
            this.mBlazeBonusText.visible = true;
         }
         if(this.mLastLevel == 0)
         {
            this.mNormalBulgeSprite.visible = false;
            this.mBlazeBulgeSprite.visible = false;
         }
         else
         {
            this.mNormalBulgeSprite.visible = true;
            this.mBlazeBulgeSprite.visible = true;
         }
         if(this.mBulgeTimer > 0)
         {
            --this.mBulgeTimer;
         }
         this.mNormalLevelText.htmlText = this.mApp.locManager.GetLocString("GAMEPLAY_BONUS_SPEED") + this.mApp.logic.speedBonus.GetBonus();
         this.mBlazeLevelText.htmlText = this.mApp.locManager.GetLocString("GAMEPLAY_BONUS_SPEED") + this.mApp.logic.speedBonus.GetBonus();
      }
      
      public function Draw() : void
      {
         var bulgePercent:Number = 1 - this.mBulgeTimer / BULGE_TIME;
         var mod:Number = Math.sin(bulgePercent * Math.PI);
         var scale:Number = mod * 0.2;
         this.mNormalBulgeSprite.scaleX = 1 + scale;
         this.mNormalBulgeSprite.scaleY = 1 + scale;
         this.mBlazeBulgeSprite.scaleX = 1 + scale;
         this.mBlazeBulgeSprite.scaleY = 1 + scale;
         this.mBrightGlow.blurX = mod * 8;
         this.mBrightGlow.blurY = mod * 8;
         if(this.mBulgeTimer == 0)
         {
            this.mNormalBonusText.filters = [this.mShadeGlow];
            this.mBlazeBonusText.filters = [this.mShadeGlow];
         }
         else
         {
            this.mNormalBonusText.filters = [this.mShadeGlow,this.mBrightGlow];
            this.mBlazeBonusText.filters = [this.mShadeGlow,this.mBrightGlow];
         }
         var alphaPercent:Number = this.mFadeTimer / FADE_TIME;
         this.mNormalBulgeSprite.alpha = alphaPercent;
         this.mBlazeBulgeSprite.alpha = alphaPercent;
         this.mNormalLevelText.textColor = 16777215;
         this.mNormalBonusText.textColor = 16777215;
         var blazeMin:Number = this.mApp.logic.blazingSpeedBonus.GetPercent();
         var blazePercent:Number = Math.max(0,(blazeMin - 0.5) / (1 - 0.5));
         var blazeColor:uint = 16742144;
         this.mScrollRect.width = 104 * blazePercent;
         this.mBlazeTextSprite.scrollRect = this.mScrollRect;
         this.mBlazeLevelText.textColor = blazeColor;
         this.mBlazeBonusText.textColor = blazeColor;
      }
   }
}
