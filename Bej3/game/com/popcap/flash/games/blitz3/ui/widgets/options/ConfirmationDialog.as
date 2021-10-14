package com.popcap.flash.games.blitz3.ui.widgets.options
{
   import com.popcap.flash.games.blitz3.Blitz3App;
   import com.popcap.flash.games.blitz3.ui.sprites.GenericButton;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import flash.text.TextFormat;
   import flash.text.TextFormatAlign;
   
   public class ConfirmationDialog extends Sprite
   {
      
      [Embed(source="/../resources/images/dialog_endgame_bckgrnd.png")]
      private static const CONFIRMATION:Class = ConfirmationDialog_CONFIRMATION;
       
      
      private var m_background:Bitmap;
      
      private var m_title:TextField;
      
      private var m_message:TextField;
      
      private var m_btnYes:GenericButton;
      
      private var m_btnNo:GenericButton;
      
      private var m_optionMenu:OptionMenuWidget;
      
      private var m_app:Blitz3App;
      
      public function ConfirmationDialog(app:Blitz3App, optionMenu:OptionMenuWidget)
      {
         super();
         this.m_app = app;
         this.m_optionMenu = optionMenu;
         this.m_background = new CONFIRMATION();
         var aFormat:TextFormat = new TextFormat();
         aFormat.align = TextFormatAlign.CENTER;
         aFormat.font = Blitz3Fonts.BLITZ_STANDARD;
         aFormat.size = 20;
         aFormat.color = 16777215;
         this.m_title = this.GetTextField(aFormat,this.m_app.locManager.GetLocString("CONFIRMATION_TITLE"),57,20);
         this.m_title.width = 150;
         this.m_title.height = 30;
         aFormat.size = 16;
         aFormat.color = 16777215;
         this.m_message = this.GetTextField(aFormat,this.m_app.locManager.GetLocString("CONFIRMATION_BODY"),50,65);
         this.m_message.width = 170;
         this.m_message.height = 90;
         this.m_btnYes = new GenericButton(app,14);
         this.m_btnYes.SetText(this.m_app.locManager.GetLocString("CONFIRMATION_YES"),-14,-7,40);
         this.m_btnYes.SetDimensions(40,18);
         this.m_btnYes.RecenterText();
         this.m_btnYes.x = 40;
         this.m_btnYes.y = 135;
         this.m_btnYes.addEventListener(MouseEvent.CLICK,this.HandleYesClicked);
         this.m_btnNo = new GenericButton(app,14);
         this.m_btnNo.SetText(this.m_app.locManager.GetLocString("CONFIRMATION_NO"),-4,-7,40);
         this.m_btnNo.SetDimensions(40,18);
         this.m_btnNo.RecenterText();
         this.m_btnNo.x = 130;
         this.m_btnNo.y = 135;
         this.m_btnNo.addEventListener(MouseEvent.CLICK,this.HandleNoClicked);
         addChild(this.m_background);
         addChild(this.m_title);
         addChild(this.m_message);
         addChild(this.m_btnNo);
         addChild(this.m_btnYes);
         this.visible = false;
      }
      
      private function GetTextField(format:TextFormat, text:String, x:Number, y:Number) : TextField
      {
         var tf:TextField = new TextField();
         tf.x = x;
         tf.y = y;
         tf.defaultTextFormat = format;
         tf.embedFonts = true;
         tf.selectable = false;
         tf.mouseEnabled = false;
         tf.wordWrap = true;
         tf.multiline = true;
         tf.htmlText = text;
         return tf;
      }
      
      public function Show() : void
      {
         this.visible = true;
      }
      
      public function Hide() : void
      {
         this.visible = false;
      }
      
      public function HandleNoClicked(e:MouseEvent) : void
      {
         this.Hide();
         this.m_optionMenu.ConfirmShow();
      }
      
      public function HandleYesClicked(e:MouseEvent) : void
      {
         this.m_app.mAdAPI.SetScore(this.m_app.logic.GetScore());
         this.m_app.mAdAPI.ScoreSubmit();
         this.m_app.mAdAPI.GameEnd();
         this.Hide();
         this.m_optionMenu.MainMenuConfirm();
         this.m_app.logic.Quit();
      }
   }
}
