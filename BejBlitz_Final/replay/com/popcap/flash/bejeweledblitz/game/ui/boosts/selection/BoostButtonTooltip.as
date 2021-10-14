package com.popcap.flash.bejeweledblitz.game.ui.boosts.selection
{
   import com.popcap.flash.bejeweledblitz.game.Blitz3App;
   import com.popcap.flash.bejeweledblitz.game.ui.coins.SmallCoinLabel;
   import com.popcap.flash.framework.utils.StringUtils;
   import com.popcap.flash.games.blitz3game.resources.Blitz3GameFonts;
   import com.popcap.flash.games.blitz3game.resources.Blitz3GameImages;
   import com.popcap.flash.games.blitz3game.resources.Blitz3GameLoc;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.filters.GlowFilter;
   import flash.geom.Matrix;
   import flash.text.TextField;
   import flash.text.TextFormat;
   import flash.text.TextFormatAlign;
   
   public class BoostButtonTooltip extends Sprite
   {
      
      public static const LEFT:String = "left";
      
      public static const RIGHT:String = "right";
      
      public static const CENTER:String = "center";
       
      
      private var m_App:Blitz3App;
      
      private var m_Background:Bitmap;
      
      private var m_Title:TextField;
      
      private var m_Body:TextField;
      
      private var m_Cost:SmallCoinLabel;
      
      public function BoostButtonTooltip(app:Blitz3App)
      {
         super();
         this.m_App = app;
         this.m_Title = new TextField();
         var format:TextFormat = new TextFormat(Blitz3GameFonts.FONT_BLITZ_STANDARD,16,16777215);
         format.align = TextFormatAlign.CENTER;
         this.m_Title.defaultTextFormat = format;
         this.m_Title.embedFonts = true;
         this.m_Title.htmlText = "";
         this.m_Title.width = 221;
         this.m_Title.height = 30.05;
         this.m_Title.selectable = false;
         this.m_Title.filters = [new GlowFilter(0,1,5,5,1)];
         this.m_Body = new TextField();
         format = new TextFormat(Blitz3GameFonts.FONT_BLITZ_STANDARD,12,16777215);
         format.align = TextFormatAlign.CENTER;
         this.m_Body.defaultTextFormat = format;
         this.m_Body.embedFonts = true;
         this.m_Body.htmlText = "";
         this.m_Body.width = 224;
         this.m_Body.height = 40.6;
         this.m_Body.selectable = false;
         this.m_Body.filters = [new GlowFilter(0,1,5,5,1)];
         this.m_Body.multiline = true;
         this.m_Body.wordWrap = true;
         this.m_Cost = new SmallCoinLabel(this.m_App);
         this.m_Cost.SetSize(221,21.3);
         this.m_Cost.x = -42;
         this.m_Cost.y = 70;
         this.m_Background = new Bitmap();
         addChild(this.m_Background);
         addChild(this.m_Title);
         addChild(this.m_Body);
         addChild(this.m_Cost);
         mouseEnabled = false;
         mouseChildren = false;
         visible = false;
      }
      
      public function SetContent(desc:BoostButtonDescriptor, caretSide:String) : void
      {
         this.SetPrice(desc.boostId);
         this.SetTitle(desc.tooltipTitle);
         this.SetBody(desc.tooltipBody);
         this.SetCaret(caretSide);
      }
      
      private function SetCaret(caretSide:String) : void
      {
         switch(caretSide)
         {
            case LEFT:
               this.LayoutLeft();
               break;
            case CENTER:
               this.LayoutCenter();
               break;
            case RIGHT:
               this.LayoutRight();
               break;
            default:
               trace("unknown caret position: " + caretSide);
         }
      }
      
      private function SetPrice(boostId:String) : void
      {
         var coins:int = 0;
         var moreNeeded:String = null;
         var price:int = this.m_App.sessionData.boostManager.GetBoostPrice(boostId);
         this.m_Cost.ShowCoin();
         this.m_Cost.SetText(this.m_App.TextManager.GetLocString(Blitz3GameLoc.LOC_BOOSTS_TIPS_BUY),StringUtils.InsertNumberCommas(price));
         if(this.m_App.sessionData.boostManager.IsBoostActive(boostId))
         {
            this.m_Cost.HideCoin();
            this.m_Cost.SetText("",this.m_App.TextManager.GetLocString(Blitz3GameLoc.LOC_BOOSTS_TIPS_IN_USE));
            if(this.m_App.sessionData.boostManager.CanSellBoost(boostId))
            {
               this.m_Cost.ShowCoin();
               this.m_Cost.SetText(this.m_App.TextManager.GetLocString(Blitz3GameLoc.LOC_BOOSTS_TIPS_SELL),StringUtils.InsertNumberCommas(price));
            }
         }
         else if(!this.m_App.sessionData.boostManager.CanBuyBoosts())
         {
            this.m_Cost.HideCoin();
            this.m_Cost.SetText("",this.m_App.TextManager.GetLocString(Blitz3GameLoc.LOC_BOOSTS_TIPS_LIMIT));
         }
         else if(!this.m_App.sessionData.boostManager.CanAffordBoost(boostId))
         {
            coins = this.m_App.sessionData.userData.GetCoins();
            moreNeeded = this.m_App.TextManager.GetLocString(Blitz3GameLoc.LOC_BOOSTS_TIPS_MORE_NEEDED);
            moreNeeded = moreNeeded.replace("%s",StringUtils.InsertNumberCommas(price - coins));
            this.m_Cost.SetText("",moreNeeded);
         }
      }
      
      private function SetTitle(titleString:String) : void
      {
         this.m_Title.htmlText = titleString;
      }
      
      private function SetBody(bodyText:String) : void
      {
         this.m_Body.htmlText = bodyText;
      }
      
      private function LayoutLeft() : void
      {
         this.m_Title.x = -32;
         this.m_Title.y = 15;
         this.m_Body.x = -33;
         this.m_Body.y = 35;
         this.m_Cost.x = -32;
         this.m_Cost.y = 70;
         this.m_Background.bitmapData = this.m_App.ImageManager.getBitmapData(Blitz3GameImages.IMAGE_TOOLTIP_BG_SIDE);
         var matrix:Matrix = this.m_Background.transform.matrix;
         matrix.a = 1;
         this.m_Background.transform.matrix = matrix;
         this.m_Background.x = -52;
         this.m_Background.y = -12;
      }
      
      private function LayoutRight() : void
      {
         this.m_Title.x = -188;
         this.m_Title.y = 15;
         this.m_Body.x = -189;
         this.m_Body.y = 35;
         this.m_Cost.x = -188;
         this.m_Cost.y = 70;
         this.m_Background.bitmapData = this.m_App.ImageManager.getBitmapData(Blitz3GameImages.IMAGE_TOOLTIP_BG_SIDE);
         var matrix:Matrix = this.m_Background.transform.matrix;
         matrix.a = -1;
         this.m_Background.transform.matrix = matrix;
         this.m_Background.x = 54;
         this.m_Background.y = -12;
      }
      
      private function LayoutCenter() : void
      {
         this.m_Title.x = -112;
         this.m_Title.y = 15;
         this.m_Body.x = -113;
         this.m_Body.y = 35;
         this.m_Cost.x = -112;
         this.m_Cost.y = 70;
         this.m_Background.bitmapData = this.m_App.ImageManager.getBitmapData(Blitz3GameImages.IMAGE_TOOLTIP_BG_MIDDLE);
         var matrix:Matrix = this.m_Background.transform.matrix;
         matrix.a = 1;
         this.m_Background.transform.matrix = matrix;
         this.m_Background.x = -132;
         this.m_Background.y = -12;
      }
   }
}
