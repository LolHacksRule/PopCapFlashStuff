package com.popcap.flash.games.blitz3.ui.widgets.univdialog
{
   import com.popcap.flash.games.blitz3.Blitz3App;
   import com.popcap.flash.games.blitz3.ui.sprites.AcceptButton;
   import com.popcap.flash.games.blitz3.ui.sprites.DeclineButton;
   import com.popcap.flash.games.blitz3.ui.sprites.ResizableBackground;
   import flash.display.Sprite;
   import flash.filters.DropShadowFilter;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   import flash.text.TextFormat;
   import flash.text.TextFormatAlign;
   
   public class TwoButtonDialog extends Sprite
   {
      
      protected static const HORIZ_BUFFER_PERCENT:Number = 0.1;
       
      
      protected var m_App:Blitz3App;
      
      protected var m_Background:ResizableBackground;
      
      protected var m_TxtTitle:TextField;
      
      protected var m_TxtBody:TextField;
      
      protected var m_BtnAccept:AcceptButton;
      
      protected var m_BtnDecline:DeclineButton;
      
      public function TwoButtonDialog(app:Blitz3App)
      {
         super();
         this.m_App = app;
         this.m_TxtTitle = new TextField();
         var titleFormat:TextFormat = new TextFormat(Blitz3Fonts.BLITZ_STANDARD,26,16774487);
         titleFormat.align = TextFormatAlign.CENTER;
         this.m_TxtTitle.defaultTextFormat = titleFormat;
         this.m_TxtTitle.embedFonts = true;
         this.m_TxtTitle.selectable = false;
         this.m_TxtTitle.autoSize = TextFieldAutoSize.CENTER;
         this.m_TxtTitle.multiline = true;
         this.m_TxtTitle.wordWrap = true;
         this.m_TxtTitle.mouseEnabled = false;
         this.m_TxtTitle.filters = [new DropShadowFilter(2,45,0,0.5)];
         this.m_TxtBody = new TextField();
         var bodyFormat:TextFormat = new TextFormat(Blitz3Fonts.BLITZ_STANDARD,14,16777215);
         bodyFormat.align = TextFormatAlign.LEFT;
         this.m_TxtBody.defaultTextFormat = bodyFormat;
         this.m_TxtBody.embedFonts = true;
         this.m_TxtBody.selectable = false;
         this.m_TxtBody.autoSize = TextFieldAutoSize.LEFT;
         this.m_TxtBody.multiline = true;
         this.m_TxtBody.wordWrap = true;
         this.m_TxtBody.mouseEnabled = false;
         this.m_TxtBody.filters = [new DropShadowFilter(2,45,0,0.5)];
      }
      
      public function Init() : void
      {
      }
      
      public function Reset() : void
      {
      }
      
      public function Update() : void
      {
      }
      
      public function SetContent(title:String, body:String, acceptLabel:String, declineLabel:String, maxWidth:Number = -1) : void
      {
      }
      
      public function AddAcceptButtonHandler(handler:Function) : void
      {
      }
      
      public function AddDeclineButtonHandler(handler:Function) : void
      {
      }
   }
}
