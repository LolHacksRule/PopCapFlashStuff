package com.popcap.flash.bejeweledblitz.game.ui.dialogs
{
   import com.popcap.flash.bejeweledblitz.game.Blitz3App;
   import com.popcap.flash.bejeweledblitz.game.ui.buttons.AcceptButtonFramed;
   import com.popcap.flash.bejeweledblitz.game.ui.buttons.DeclineButtonFramed;
   import com.popcap.flash.games.blitz3game.resources.Blitz3GameFonts;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.filters.BitmapFilterQuality;
   import flash.filters.DropShadowFilter;
   import flash.filters.GlowFilter;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   import flash.text.TextFormat;
   import flash.text.TextFormatAlign;
   
   public class TwoButtonDialog extends Sprite
   {
       
      
      protected var m_App:Blitz3App;
      
      protected var m_Background:ResizableDialog;
      
      protected var m_TxtTitle:TextField;
      
      protected var m_TxtBody:TextField;
      
      protected var m_ButtonAccept:AcceptButtonFramed;
      
      protected var m_ButtonDecline:DeclineButtonFramed;
      
      public function TwoButtonDialog(param1:Blitz3App, param2:int = 18)
      {
         super();
         this.m_App = param1;
         this.m_Background = new ResizableDialog(this.m_App);
         this.m_TxtTitle = new TextField();
         this.m_TxtTitle.defaultTextFormat = new TextFormat(Blitz3GameFonts.FONT_FLARE_GOTHIC,28,16764239,null,null,null,null,null,TextFormatAlign.CENTER);
         this.m_TxtTitle.autoSize = TextFieldAutoSize.CENTER;
         this.m_TxtTitle.embedFonts = true;
         this.m_TxtTitle.multiline = true;
         this.m_TxtTitle.selectable = false;
         this.m_TxtTitle.mouseEnabled = false;
         this.m_TxtTitle.filters = [new GlowFilter(10838300,1,7,7,1.65,BitmapFilterQuality.HIGH,true),new DropShadowFilter(-1,90,16776103,1,2,2,2.07,BitmapFilterQuality.HIGH,true),new DropShadowFilter(1,77,2754823,1,4,4,10,BitmapFilterQuality.HIGH),new GlowFilter(854298,1,38,38,0.81,BitmapFilterQuality.HIGH)];
         this.m_TxtBody = new TextField();
         this.m_TxtBody.defaultTextFormat = new TextFormat(Blitz3GameFonts.FONT_BLITZ_STANDARD,14,16777215,null,null,null,null,null,TextFormatAlign.CENTER);
         this.m_TxtBody.autoSize = TextFieldAutoSize.CENTER;
         this.m_TxtBody.embedFonts = true;
         this.m_TxtBody.multiline = true;
         this.m_TxtBody.wordWrap = true;
         this.m_TxtBody.selectable = false;
         this.m_TxtBody.mouseEnabled = false;
         this.m_TxtBody.filters = [new GlowFilter(0,1,2,2,4),new DropShadowFilter(2,45,0,0.5)];
         this.m_ButtonAccept = new AcceptButtonFramed(this.m_App,param2);
         this.m_ButtonDecline = new DeclineButtonFramed(this.m_App,param2);
      }
      
      public function Init() : void
      {
         addChild(this.m_Background);
         addChild(this.m_TxtTitle);
         addChild(this.m_TxtBody);
         addChild(this.m_ButtonAccept);
         addChild(this.m_ButtonDecline);
         this.m_ButtonAccept.Init();
         this.m_ButtonDecline.Init();
      }
      
      public function Reset() : void
      {
         this.m_ButtonAccept.Reset();
         this.m_ButtonDecline.Reset();
      }
      
      public function SetDimensions(param1:Number, param2:Number) : void
      {
         this.m_Background.SetDimensions(param1,param2);
      }
      
      public function SetContent(param1:String, param2:String, param3:String, param4:String) : void
      {
         this.m_TxtTitle.htmlText = param1;
         this.m_TxtTitle.width = this.m_Background.width * 0.8;
         this.m_TxtTitle.x = this.m_Background.width * 0.5 - this.m_TxtTitle.width * 0.5;
         this.m_TxtTitle.y = 20;
         if(param2.length == 0)
         {
            removeChild(this.m_TxtBody);
            this.m_TxtBody.y = this.m_TxtTitle.y + this.m_TxtTitle.height;
         }
         else
         {
            this.m_TxtBody.htmlText = param2;
            this.m_TxtBody.width = this.m_Background.width * 0.8;
            this.m_TxtBody.x = this.m_Background.width * 0.5 - this.m_TxtBody.width * 0.5;
            this.m_TxtBody.y = this.m_TxtTitle.y + this.m_TxtTitle.height + 12;
         }
         this.m_ButtonAccept.SetText(param3);
         this.m_ButtonDecline.SetText(param4);
         var _loc5_:Number = this.m_Background.width - this.m_ButtonAccept.width - this.m_ButtonDecline.width;
         this.m_ButtonDecline.x = _loc5_ * 0.33;
         this.m_ButtonDecline.y = this.m_TxtBody.y + this.m_TxtBody.height + 12;
         this.m_ButtonAccept.x = this.m_ButtonDecline.x + this.m_ButtonDecline.width + _loc5_ * 0.33;
         this.m_ButtonAccept.y = this.m_TxtBody.y + this.m_TxtBody.height + 12;
      }
      
      public function AddAcceptButtonHandler(param1:Function) : void
      {
         this.m_ButtonAccept.addEventListener(MouseEvent.CLICK,param1);
      }
      
      public function AddDeclineButtonHandler(param1:Function) : void
      {
         this.m_ButtonDecline.addEventListener(MouseEvent.CLICK,param1);
      }
   }
}
