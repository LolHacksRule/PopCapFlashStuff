package com.popcap.flash.bejeweledblitz.game.ui.gameover.message.messages
{
   import com.popcap.flash.bejeweledblitz.Dimensions;
   import com.popcap.flash.bejeweledblitz.game.Blitz3App;
   import com.popcap.flash.games.blitz3game.resources.Blitz3GameFonts;
   import flash.display.Shape;
   import flash.display.Sprite;
   import flash.filters.DropShadowFilter;
   import flash.filters.GlowFilter;
   import flash.filters.GradientGlowFilter;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   import flash.text.TextFormat;
   import flash.text.TextFormatAlign;
   
   public class PostGameMessage extends Sprite
   {
       
      
      protected var m_App:Blitz3App;
      
      private var m_Msg:String;
      
      protected var background:Shape;
      
      protected var txtMessage:TextField;
      
      public function PostGameMessage(app:Blitz3App, msg:String = "")
      {
         super();
         this.m_App = app;
         this.m_Msg = msg;
         this.BuildComponents();
         this.LayoutComponents();
         useHandCursor = true;
         buttonMode = true;
      }
      
      protected function BuildComponents() : void
      {
         this.BuildBackground();
         this.BuildMessage(this.m_Msg);
      }
      
      protected function BuildBackground() : void
      {
         var backWidth:Number = Dimensions.GAME_WIDTH * 0.95;
         var backHeight:Number = Dimensions.GAME_HEIGHT * 0.17;
         this.background = new Shape();
         this.background.graphics.beginFill(0,0.5);
         this.background.graphics.drawRoundRect(0,0,backWidth,backHeight,4);
         this.background.cacheAsBitmap = true;
         addChild(this.background);
      }
      
      protected function BuildMessage(msg:String) : void
      {
         this.txtMessage = new TextField();
         var format:TextFormat = new TextFormat(Blitz3GameFonts.FONT_BLITZ_STANDARD,16,15246080);
         format.align = TextFormatAlign.CENTER;
         this.txtMessage.defaultTextFormat = format;
         this.txtMessage.embedFonts = true;
         this.txtMessage.selectable = false;
         this.txtMessage.autoSize = TextFieldAutoSize.CENTER;
         this.txtMessage.multiline = true;
         this.txtMessage.htmlText = msg;
         this.txtMessage.filters = [new GradientGlowFilter(-9,45,[16777215,16767294],[0,0.92],[0,255],9,9,3.49),new GlowFilter(0,1,3.5,3.5,8.76),new DropShadowFilter(2,61,0,1,4,4)];
         addChild(this.txtMessage);
      }
      
      protected function LayoutComponents() : void
      {
         this.txtMessage.x = this.background.x + this.background.width * 0.5 - this.txtMessage.textWidth * 0.5;
         this.txtMessage.y = this.background.y + this.background.height * 0.5 - this.txtMessage.textHeight * 0.5;
      }
   }
}
