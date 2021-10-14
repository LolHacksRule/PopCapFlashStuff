package com.popcap.flash.games.zuma2.logic
{
   import com.popcap.flash.framework.utils.StringUtils;
   import com.popcap.flash.games.zuma2.widgets.GameBoardWidget;
   import flash.display.Bitmap;
   import flash.display.SimpleButton;
   import flash.events.MouseEvent;
   import flash.filters.GlowFilter;
   import flash.net.URLRequest;
   import flash.net.navigateToURL;
   import flash.text.AntiAliasType;
   import flash.text.TextField;
   import flash.text.TextFormat;
   import flash.text.TextFormatAlign;
   
   public class StatsScreen
   {
       
      
      public var mBoard:GameBoardWidget;
      
      public var mContinueButton:SimpleButton;
      
      public var mBackground:Bitmap;
      
      public var mGapShotText:TextField;
      
      public var mUpsellButton:SimpleButton;
      
      public var mChainText:TextField;
      
      public var mComboText:TextField;
      
      public var mHighScoreText:TextField;
      
      public var mApp:Zuma2App;
      
      public var mScoreText:TextField;
      
      public var mFruitText:TextField;
      
      public function StatsScreen(param1:Zuma2App, param2:GameBoardWidget, param3:int, param4:int, param5:int, param6:int, param7:int, param8:int)
      {
         super();
         this.mApp = param1;
         this.mBoard = param2;
         var _loc9_:Bitmap = new Bitmap(this.mApp.imageManager.getBitmapData(Zuma2Images.IMAGE_STAT_SCREEN_PLAYAGAIN_BUTTON_UP));
         var _loc10_:Bitmap = new Bitmap(this.mApp.imageManager.getBitmapData(Zuma2Images.IMAGE_STAT_SCREEN_PLAYAGAIN_BUTTON_DOWN));
         var _loc11_:Bitmap = new Bitmap(this.mApp.imageManager.getBitmapData(Zuma2Images.IMAGE_STAT_SCREEN_PLAYAGAIN_BUTTON_OVER));
         var _loc12_:Bitmap = new Bitmap(this.mApp.imageManager.getBitmapData(Zuma2Images.IMAGE_STAT_SCREEN_UPSELL_BUTTON_UP));
         this.mContinueButton = new SimpleButton(_loc9_,_loc11_,_loc10_,_loc10_);
         this.mContinueButton.addEventListener(MouseEvent.CLICK,this.handlePlayagain);
         this.mContinueButton.x = 280;
         this.mContinueButton.y = 215;
         this.mUpsellButton = new SimpleButton(_loc12_,_loc12_,_loc12_,_loc12_);
         this.mUpsellButton.addEventListener(MouseEvent.CLICK,this.handleUpsell);
         this.mUpsellButton.x = 275;
         this.mUpsellButton.y = 355;
         var _loc13_:TextFormat;
         (_loc13_ = new TextFormat()).font = "TimeUpText";
         _loc13_.align = TextFormatAlign.CENTER;
         _loc13_.color = 15030548;
         _loc13_.size = 16;
         var _loc14_:GlowFilter = new GlowFilter(7354630,1,2,2,10,5);
         this.mComboText = new TextField();
         this.mComboText.embedFonts = true;
         this.mComboText.defaultTextFormat = _loc13_;
         this.mComboText.filters = [_loc14_];
         this.mComboText.width = 120;
         this.mComboText.height = 100;
         this.mComboText.x = 280;
         this.mComboText.y = 80;
         this.mComboText.alpha = 1;
         this.mComboText.selectable = false;
         this.mComboText.multiline = false;
         this.mComboText.wordWrap = false;
         this.mComboText.text = "x" + param3.toString();
         this.mComboText.antiAliasType = AntiAliasType.ADVANCED;
         this.mChainText = new TextField();
         this.mChainText.embedFonts = true;
         this.mChainText.defaultTextFormat = _loc13_;
         this.mChainText.filters = [_loc14_];
         this.mChainText.width = 120;
         this.mChainText.height = 100;
         this.mChainText.x = 280;
         this.mChainText.y = 100;
         this.mChainText.alpha = 1;
         this.mChainText.selectable = false;
         this.mChainText.multiline = false;
         this.mChainText.wordWrap = false;
         this.mChainText.text = "x" + param4.toString();
         this.mGapShotText = new TextField();
         this.mGapShotText.embedFonts = true;
         this.mGapShotText.defaultTextFormat = _loc13_;
         this.mGapShotText.filters = [_loc14_];
         this.mGapShotText.width = 120;
         this.mGapShotText.height = 100;
         this.mGapShotText.x = 410;
         this.mGapShotText.y = 80;
         this.mGapShotText.alpha = 1;
         this.mGapShotText.selectable = false;
         this.mGapShotText.multiline = false;
         this.mGapShotText.wordWrap = false;
         this.mGapShotText.text = "x" + param5.toString();
         this.mFruitText = new TextField();
         this.mFruitText.embedFonts = true;
         this.mFruitText.defaultTextFormat = _loc13_;
         this.mFruitText.filters = [_loc14_];
         this.mFruitText.width = 120;
         this.mFruitText.height = 100;
         this.mFruitText.x = 410;
         this.mFruitText.y = 100;
         this.mFruitText.alpha = 1;
         this.mFruitText.selectable = false;
         this.mFruitText.multiline = false;
         this.mFruitText.wordWrap = false;
         this.mFruitText.text = "x" + param6.toString();
         this.mHighScoreText = new TextField();
         this.mHighScoreText.embedFonts = true;
         this.mHighScoreText.defaultTextFormat = _loc13_;
         this.mHighScoreText.filters = [_loc14_];
         this.mHighScoreText.width = 120;
         this.mHighScoreText.height = 100;
         this.mHighScoreText.x = 340;
         this.mHighScoreText.y = 125;
         this.mHighScoreText.alpha = 1;
         this.mHighScoreText.selectable = false;
         this.mHighScoreText.multiline = false;
         this.mHighScoreText.wordWrap = false;
         this.mHighScoreText.text = StringUtils.InsertNumberCommas(param7);
         _loc13_.color = 16777215;
         _loc13_.size = 30;
         _loc14_ = new GlowFilter(6305831,1,2,2,10,5);
         this.mScoreText = new TextField();
         this.mScoreText.embedFonts = true;
         this.mScoreText.defaultTextFormat = _loc13_;
         this.mScoreText.filters = [_loc14_];
         this.mScoreText.width = 250;
         this.mScoreText.height = 100;
         this.mScoreText.x = 280;
         this.mScoreText.y = 153;
         this.mScoreText.alpha = 1;
         this.mScoreText.selectable = false;
         this.mScoreText.multiline = false;
         this.mScoreText.wordWrap = false;
         this.mScoreText.text = StringUtils.InsertNumberCommas(param8);
         this.mBackground = new Bitmap(this.mApp.imageManager.getBitmapData(Zuma2Images.IMAGE_STAT_SCREEN_BACKGROUND));
         this.mApp.mLayers[4].mBackground.addChild(this.mBackground);
         this.mApp.mLayers[4].mForeground.addChild(this.mComboText);
         this.mApp.mLayers[4].mForeground.addChild(this.mChainText);
         this.mApp.mLayers[4].mForeground.addChild(this.mGapShotText);
         this.mApp.mLayers[4].mForeground.addChild(this.mFruitText);
         this.mApp.mLayers[4].mForeground.addChild(this.mHighScoreText);
         this.mApp.mLayers[4].mForeground.addChild(this.mScoreText);
         this.mApp.mLayers[4].mForeground.addChild(this.mContinueButton);
         this.mApp.mLayers[4].mForeground.addChild(this.mUpsellButton);
      }
      
      public function handlePlayagain(param1:MouseEvent) : void
      {
         this.mApp.soundManager.playSound(Zuma2Sounds.SOUND_BUTTON_CLICK);
         this.Clear();
         this.mBoard.RestartLevel();
      }
      
      public function Clear() : void
      {
         this.mApp.mLayers[4].mBackground.removeChild(this.mBackground);
         this.mApp.mLayers[4].mForeground.removeChild(this.mComboText);
         this.mApp.mLayers[4].mForeground.removeChild(this.mChainText);
         this.mApp.mLayers[4].mForeground.removeChild(this.mGapShotText);
         this.mApp.mLayers[4].mForeground.removeChild(this.mFruitText);
         this.mApp.mLayers[4].mForeground.removeChild(this.mHighScoreText);
         this.mApp.mLayers[4].mForeground.removeChild(this.mScoreText);
         this.mApp.mLayers[4].mForeground.removeChild(this.mContinueButton);
         this.mApp.mLayers[4].mForeground.removeChild(this.mUpsellButton);
         this.mBackground = null;
         this.mComboText = null;
         this.mChainText = null;
         this.mGapShotText = null;
         this.mFruitText = null;
         this.mHighScoreText = null;
         this.mScoreText = null;
         this.mContinueButton = null;
         this.mUpsellButton = null;
      }
      
      public function handleUpsell(param1:MouseEvent) : void
      {
         var _loc2_:URLRequest = new URLRequest("http://ad.doubleclick.net/adi/wt.onlinegame.nav/attexit;sz=1x1;ord=0123456789");
         navigateToURL(_loc2_,"_blank");
      }
   }
}
