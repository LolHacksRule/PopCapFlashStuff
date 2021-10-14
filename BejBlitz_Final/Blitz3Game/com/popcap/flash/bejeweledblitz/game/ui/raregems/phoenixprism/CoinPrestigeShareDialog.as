package com.popcap.flash.bejeweledblitz.game.ui.raregems.phoenixprism
{
   import com.popcap.flash.bejeweledblitz.game.Blitz3App;
   import com.popcap.flash.bejeweledblitz.game.ui.buttons.AcceptButtonFramed;
   import com.popcap.flash.bejeweledblitz.game.ui.buttons.DeclineButtonFramed;
   import com.popcap.flash.games.blitz3game.resources.Blitz3GameFonts;
   import com.popcap.flash.games.blitz3game.resources.Blitz3GameImages;
   import com.popcap.flash.games.blitz3game.resources.Blitz3GameLoc;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.filters.DropShadowFilter;
   import flash.filters.GlowFilter;
   import flash.filters.GradientGlowFilter;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   import flash.text.TextFormat;
   import flash.text.TextFormatAlign;
   
   public class CoinPrestigeShareDialog extends Sprite
   {
       
      
      private var m_App:Blitz3App;
      
      private var m_Prestige:PhoenixPrismPrestige;
      
      private var m_FrameLeft:Bitmap;
      
      private var m_FrameRight:Bitmap;
      
      private var m_Title:TextField;
      
      private var m_Message:TextField;
      
      private var m_AcceptButton:AcceptButtonFramed;
      
      private var m_DeclineButton:DeclineButtonFramed;
      
      public function CoinPrestigeShareDialog(param1:Blitz3App, param2:PhoenixPrismPrestige)
      {
         super();
         this.m_App = param1;
         this.m_Prestige = param2;
         this.m_FrameLeft = new Bitmap();
         this.m_FrameRight = new Bitmap();
         this.m_Title = new TextField();
         this.m_Message = new TextField();
         this.m_AcceptButton = new AcceptButtonFramed(param1);
         this.m_DeclineButton = new DeclineButtonFramed(param1);
      }
      
      public function Init() : void
      {
         addChild(this.m_FrameLeft);
         addChild(this.m_FrameRight);
         addChild(this.m_Title);
         addChild(this.m_Message);
         addChild(this.m_AcceptButton);
         addChild(this.m_DeclineButton);
         this.m_FrameLeft.bitmapData = this.m_App.ImageManager.getBitmapData(Blitz3GameImages.IMAGE_PP_PRESTIGE_GOLD_FRAME);
         this.m_FrameLeft.x = -this.m_FrameLeft.width + 0.5;
         this.m_FrameRight.bitmapData = this.m_App.ImageManager.getBitmapData(Blitz3GameImages.IMAGE_PP_PRESTIGE_GOLD_FRAME);
         this.m_FrameRight.scaleX = -1;
         this.m_FrameRight.x = this.m_FrameRight.width - 0.5;
         var _loc1_:TextFormat = new TextFormat(Blitz3GameFonts.FONT_BLITZ_STANDARD,null,16737792);
         _loc1_.align = TextFormatAlign.CENTER;
         this.m_Title.defaultTextFormat = _loc1_;
         this.m_Title.autoSize = TextFieldAutoSize.CENTER;
         this.m_Title.embedFonts = true;
         this.m_Title.selectable = false;
         this.m_Title.multiline = false;
         this.m_Title.wordWrap = false;
         this.m_Title.mouseEnabled = false;
         this.m_Title.filters = [new DropShadowFilter(2,45,0,0.5),new GradientGlowFilter(-10,85,[14079702,14624561],[0,1],[0,255],22,22,2),new GlowFilter(16764057,1,2.5,2.5,2,1,true),new GlowFilter(3342336,1,1.2,1.2,10,1,false),new GlowFilter(6697728,1,6,6,1,1,false)];
         this.m_Title.htmlText = this.m_App.TextManager.GetLocString(Blitz3GameLoc.LOC_PHOENIX_PRISM_BONUS_SHARE_TITLE);
         this.m_Title.x = this.m_Title.width * -0.5;
         this.m_Title.y = 10;
         var _loc2_:TextFormat = new TextFormat(Blitz3GameFonts.FONT_BLITZ_STANDARD,null,4269332);
         _loc2_.align = TextFormatAlign.CENTER;
         this.m_Message.defaultTextFormat = _loc2_;
         this.m_Message.autoSize = TextFieldAutoSize.CENTER;
         this.m_Message.embedFonts = true;
         this.m_Message.selectable = false;
         this.m_Message.multiline = true;
         this.m_Message.wordWrap = false;
         this.m_Message.mouseEnabled = false;
         this.m_Message.htmlText = this.m_App.TextManager.GetLocString(Blitz3GameLoc.LOC_PHOENIX_PRISM_BONUS_SHARE_MESSAGE);
         this.m_Message.x = this.m_Message.width * -0.5;
         this.m_Message.y = 64;
         this.m_AcceptButton.Init();
         this.m_AcceptButton.SetText(this.m_App.TextManager.GetLocString(Blitz3GameLoc.LOC_PHOENIX_PRISM_BONUS_SHARE_CONFIRM));
         this.m_AcceptButton.addEventListener(MouseEvent.CLICK,this.ShareConfirmed,false,0,true);
         this.m_DeclineButton.Init();
         this.m_DeclineButton.SetText(this.m_App.TextManager.GetLocString(Blitz3GameLoc.LOC_PHOENIX_PRISM_BONUS_SHARE_DECLINE));
         this.m_DeclineButton.addEventListener(MouseEvent.CLICK,this.ShareDeclined,false,0,true);
         var _loc3_:int = (this.m_AcceptButton.width + this.m_DeclineButton.width) * 0.3;
         this.m_DeclineButton.x = -_loc3_ + this.m_DeclineButton.width * -0.5;
         this.m_DeclineButton.y = 140;
         this.m_AcceptButton.x = _loc3_ + this.m_AcceptButton.width * -0.5;
         this.m_AcceptButton.y = 140;
         this.Reset();
      }
      
      public function Reset() : void
      {
         visible = false;
         y = -height;
      }
      
      public function Update() : Boolean
      {
         visible = true;
         if(y < 0)
         {
            y += 5;
            return true;
         }
         y = 0;
         return false;
      }
      
      private function ShareConfirmed(param1:Event) : void
      {
         this.m_App.network.SharePhoenixPayout();
         this.m_Prestige.Done();
      }
      
      private function ShareDeclined(param1:Event) : void
      {
         this.m_Prestige.Done();
      }
   }
}
