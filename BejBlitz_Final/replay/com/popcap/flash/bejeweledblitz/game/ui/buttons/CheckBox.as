package com.popcap.flash.bejeweledblitz.game.ui.buttons
{
   import com.popcap.flash.framework.App;
   import com.popcap.flash.games.blitz3game.resources.Blitz3GameFonts;
   import com.popcap.flash.games.blitz3game.resources.Blitz3GameImages;
   import com.popcap.flash.games.blitz3game.resources.Blitz3GameSounds;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.filters.GlowFilter;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   import flash.text.TextFormat;
   import flashx.textLayout.formats.TextAlign;
   
   public class CheckBox extends Sprite
   {
       
      
      protected var m_App:App;
      
      protected var m_Box:Bitmap;
      
      protected var m_Mark:Bitmap;
      
      protected var m_IsChecked:Boolean = false;
      
      public function CheckBox(app:App)
      {
         super();
         this.m_App = app;
         useHandCursor = true;
         buttonMode = true;
         this.m_Box = new Bitmap(this.m_App.ImageManager.getBitmapData(Blitz3GameImages.IMAGE_CHECK_BOX));
         this.m_Mark = new Bitmap(this.m_App.ImageManager.getBitmapData(Blitz3GameImages.IMAGE_CHECK_MARK));
         addChild(this.m_Box);
         addChild(this.m_Mark);
         this.UpdateState();
         addEventListener(MouseEvent.CLICK,this.HandleClick);
      }
      
      public function IsChecked() : Boolean
      {
         return this.m_IsChecked;
      }
      
      public function SetChecked(checked:Boolean) : void
      {
         this.m_IsChecked = checked;
         this.UpdateState();
      }
      
      public function addLabel(label:String) : void
      {
         var textField:TextField = null;
         textField = new TextField();
         var tf:TextFormat = new TextFormat(Blitz3GameFonts.FONT_BLITZ_STANDARD,16,16777215,true);
         tf.align = TextAlign.CENTER;
         textField.defaultTextFormat = tf;
         textField.embedFonts = true;
         textField.multiline = true;
         textField.selectable = false;
         textField.autoSize = TextFieldAutoSize.CENTER;
         textField.filters = [new GlowFilter(0,1,2,2,4)];
         textField.htmlText = label;
         textField.x = width;
         addChild(textField);
      }
      
      protected function UpdateState() : void
      {
         this.m_Mark.visible = this.m_IsChecked;
      }
      
      protected function HandleClick(event:MouseEvent) : void
      {
         this.m_IsChecked = !this.m_IsChecked;
         this.UpdateState();
         this.m_App.SoundManager.playSound(Blitz3GameSounds.SOUND_BUTTON_RELEASE);
      }
   }
}
