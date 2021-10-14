package com.popcap.flash.bejeweledblitz.friendscore.view.meter
{
   import com.popcap.flash.framework.App;
   import com.popcap.flash.games.blitz3game.resources.Blitz3GameFonts;
   import com.popcap.flash.games.friendscore.resources.FriendscoreImages;
   import com.popcap.flash.games.friendscore.resources.FriendscoreLoc;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.filters.GlowFilter;
   import flash.filters.GradientGlowFilter;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   import flash.text.TextFormat;
   import flash.text.TextFormatAlign;
   
   public class PayoutText extends Sprite
   {
      
      protected static const COIN_TEXT_FILTERS:Array = [new GradientGlowFilter(-7,90,[16777215,16773721],[0,1],[0,255],10,10,3),new GlowFilter(4334336,1,3,3,8.76),new GlowFilter(5589557,1,4,4,1.64)];
       
      
      private var m_App:App;
      
      public var payoutText:TextField;
      
      public var checkMark:Bitmap;
      
      private var m_CoinEffect:CoinEffect;
      
      public function PayoutText(app:App, value:int)
      {
         super();
         this.m_App = app;
         this.payoutText = new TextField();
         var format:TextFormat = new TextFormat(Blitz3GameFonts.FONT_BLITZ_STANDARD,15,16236548);
         format.align = TextFormatAlign.CENTER;
         this.payoutText.defaultTextFormat = format;
         this.payoutText.autoSize = TextFieldAutoSize.CENTER;
         this.payoutText.embedFonts = true;
         this.payoutText.selectable = false;
         this.payoutText.mouseEnabled = false;
         this.payoutText.multiline = false;
         var content:String = this.m_App.TextManager.GetLocString(FriendscoreLoc.LOC_PAYOUT);
         if(value > 1000)
         {
            value /= 1000;
            content = content.replace("%s",this.m_App.TextManager.GetLocString(FriendscoreLoc.LOC_MILLIONS_ABREVIATION));
         }
         else
         {
            content = content.replace("%s",this.m_App.TextManager.GetLocString(FriendscoreLoc.LOC_THOUSANDS_ABREVIATION));
         }
         content = content.replace("%s",value);
         this.payoutText.htmlText = content;
         this.payoutText.filters = COIN_TEXT_FILTERS;
         this.payoutText.x = 0;
         this.payoutText.y = 0;
         addChild(this.payoutText);
         this.checkMark = new Bitmap(this.m_App.ImageManager.getBitmapData(FriendscoreImages.IMAGE_CHECK));
         this.checkMark.x = this.payoutText.x + this.payoutText.textWidth;
         this.checkMark.y = this.payoutText.y + this.payoutText.textHeight * 0.5 - this.checkMark.height * 0.5;
         addChild(this.checkMark);
         this.m_CoinEffect = new CoinEffect(this.m_App);
         this.m_CoinEffect.x = this.checkMark.x + this.checkMark.width * 0.75;
         this.m_CoinEffect.y = this.checkMark.y + this.checkMark.height * 0.5;
         addChild(this.m_CoinEffect);
         this.checkMark.visible = false;
      }
      
      public function Init() : void
      {
         this.m_CoinEffect.Init();
      }
      
      public function Update(dt:Number) : void
      {
         this.m_CoinEffect.Update(dt);
      }
      
      public function SetCheckVisible(isVisible:Boolean) : void
      {
         if(!this.checkMark.visible && isVisible)
         {
            this.m_CoinEffect.Start();
         }
         this.checkMark.visible = isVisible;
      }
   }
}
