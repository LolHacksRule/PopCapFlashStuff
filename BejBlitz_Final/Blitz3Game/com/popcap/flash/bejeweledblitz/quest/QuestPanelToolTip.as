package com.popcap.flash.bejeweledblitz.quest
{
   import com.popcap.flash.bejeweledblitz.game.Blitz3App;
   import com.popcap.flash.games.blitz3game.resources.Blitz3GameFonts;
   import com.popcap.flash.games.blitz3game.resources.Blitz3GameImages;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.geom.Matrix;
   import flash.text.TextField;
   import flash.text.TextFormat;
   import flash.text.TextFormatAlign;
   
   public class QuestPanelToolTip extends Sprite
   {
      
      public static const LEFT:String = "left";
      
      public static const RIGHT:String = "right";
      
      public static const CENTER:String = "center";
       
      
      private var m_App:Blitz3App;
      
      private var m_Background:Bitmap;
      
      private var m_Title:TextField;
      
      private var m_Body:TextField;
      
      public function QuestPanelToolTip(param1:Blitz3App)
      {
         super();
         this.m_App = param1;
         this.m_Title = new TextField();
         var _loc2_:TextFormat = new TextFormat(Blitz3GameFonts.FONT_BLITZ_STANDARD,16,3082058);
         _loc2_.align = TextFormatAlign.CENTER;
         this.m_Title.defaultTextFormat = _loc2_;
         this.m_Title.embedFonts = true;
         this.m_Title.htmlText = "";
         this.m_Title.width = 221;
         this.m_Title.height = 30.05;
         this.m_Title.selectable = false;
         this.m_Body = new TextField();
         _loc2_ = new TextFormat(Blitz3GameFonts.FONT_BLITZ_STANDARD,12,3082058);
         _loc2_.leading = -4;
         _loc2_.align = TextFormatAlign.CENTER;
         this.m_Body.defaultTextFormat = _loc2_;
         this.m_Body.embedFonts = true;
         this.m_Body.htmlText = "";
         this.m_Body.width = 224;
         this.m_Body.height = 60;
         this.m_Body.selectable = false;
         this.m_Body.multiline = true;
         this.m_Body.wordWrap = true;
         this.m_Background = new Bitmap();
         this.m_Background.scaleY = -1;
         addChild(this.m_Background);
         this.m_Title.y = -96;
         this.m_Body.y = this.m_Title.y + 17;
         addChild(this.m_Title);
         addChild(this.m_Body);
         mouseEnabled = false;
         mouseChildren = false;
      }
      
      public function setContent(param1:String, param2:String, param3:String) : void
      {
         this.SetTitle(param1);
         this.SetBody(param2);
         this.SetCaret(param3);
      }
      
      private function SetCaret(param1:String) : void
      {
         switch(param1)
         {
            case LEFT:
               this.LayoutLeft();
               break;
            case CENTER:
               this.LayoutCenter();
               break;
            case RIGHT:
               this.LayoutRight();
         }
      }
      
      private function SetTitle(param1:String) : void
      {
         this.m_Title.htmlText = param1;
      }
      
      private function SetBody(param1:String) : void
      {
         this.m_Body.htmlText = param1;
      }
      
      private function LayoutLeft() : void
      {
         this.m_Title.x = -18;
         this.m_Body.x = -18 - 8;
         this.m_Background.bitmapData = this.m_App.ImageManager.getBitmapData(Blitz3GameImages.IMAGE_TOOLTIP_BG_SIDE);
         var _loc2_:Matrix = this.m_Background.transform.matrix;
         _loc2_.a = 1;
         this.m_Background.transform.matrix = _loc2_;
         this.m_Background.x = -18 - 27;
      }
      
      private function LayoutRight() : void
      {
         this.m_Title.x = -188;
         this.m_Body.x = -189;
         this.m_Background.bitmapData = this.m_App.ImageManager.getBitmapData(Blitz3GameImages.IMAGE_TOOLTIP_BG_SIDE);
         var _loc1_:Matrix = this.m_Background.transform.matrix;
         _loc1_.a = -1;
         this.m_Background.transform.matrix = _loc1_;
         this.m_Background.x = 54;
      }
      
      private function LayoutCenter() : void
      {
         this.m_Title.x = -112;
         this.m_Body.x = -113;
         this.m_Background.bitmapData = this.m_App.ImageManager.getBitmapData(Blitz3GameImages.IMAGE_TOOLTIP_BG_MIDDLE);
         var _loc1_:Matrix = this.m_Background.transform.matrix;
         _loc1_.a = 1;
         this.m_Background.transform.matrix = _loc1_;
         this.m_Background.x = -132;
      }
   }
}
