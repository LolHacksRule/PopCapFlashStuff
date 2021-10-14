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
   import flash.text.TextFormatAlign;
   
   public class CheckBox extends Sprite
   {
       
      
      protected var m_App:App;
      
      protected var m_Box:Bitmap;
      
      protected var m_Mark:Bitmap;
      
      protected var m_IsChecked:Boolean = false;
      
      public function CheckBox(param1:App)
      {
         super();
         this.m_App = param1;
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
      
      public function SetChecked(param1:Boolean) : void
      {
         this.m_IsChecked = param1;
         this.UpdateState();
      }
      
      public function addLabel(param1:String) : void
      {
         var _loc2_:TextField = null;
         _loc2_ = new TextField();
         var _loc3_:TextFormat = new TextFormat(Blitz3GameFonts.FONT_BLITZ_STANDARD,16,16777215,true);
         _loc3_.align = TextFormatAlign.CENTER;
         _loc2_.defaultTextFormat = _loc3_;
         _loc2_.embedFonts = true;
         _loc2_.multiline = true;
         _loc2_.selectable = false;
         _loc2_.autoSize = TextFieldAutoSize.CENTER;
         _loc2_.filters = [new GlowFilter(0,1,2,2,4)];
         _loc2_.htmlText = param1;
         _loc2_.x = width;
         addChild(_loc2_);
      }
      
      protected function UpdateState() : void
      {
         this.m_Mark.visible = this.m_IsChecked;
      }
      
      protected function HandleClick(param1:MouseEvent) : void
      {
         this.m_IsChecked = !this.m_IsChecked;
         this.UpdateState();
         this.m_App.SoundManager.playSound(Blitz3GameSounds.SOUND_BUTTON_RELEASE);
      }
   }
}
