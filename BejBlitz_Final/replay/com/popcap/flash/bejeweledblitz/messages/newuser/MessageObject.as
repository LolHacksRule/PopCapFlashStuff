package com.popcap.flash.bejeweledblitz.messages.newuser
{
   import com.popcap.flash.bejeweledblitz.game.Blitz3App;
   import com.popcap.flash.bejeweledblitz.game.ui.buttons.ButtonWidget;
   import com.popcap.flash.bejeweledblitz.messages.common.MessageHeader;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.geom.ColorTransform;
   
   public class MessageObject extends Sprite
   {
       
      
      protected var m_App:Blitz3App;
      
      protected var m_Header:MessageHeader;
      
      protected var m_Icon:Bitmap;
      
      protected var m_Buttons:ButtonWidget;
      
      protected var m_ButtonsVerticalPos:Number;
      
      protected var m_TextVerticalPos:Number;
      
      protected var m_MessageText:String;
      
      protected var m_TrackingId:String;
      
      public function MessageObject(app:Blitz3App)
      {
         super();
         this.m_App = app;
      }
      
      public function getButtons() : ButtonWidget
      {
         return this.m_Buttons;
      }
      
      public function getButtonsVerticalPosition() : Number
      {
         return this.m_ButtonsVerticalPos;
      }
      
      public function getMessageText() : String
      {
         return this.m_MessageText;
      }
      
      public function getMessageVerticalPosition() : Number
      {
         return this.m_TextVerticalPos;
      }
      
      public function getMessageTrackingId() : String
      {
         return this.m_TrackingId;
      }
      
      public function getHeaderWidth() : Number
      {
         return this.m_Header.getTextWidth();
      }
      
      public function colorBackgroundAnim(backgroundAnim:MovieClip) : void
      {
         backgroundAnim.transform.colorTransform = new ColorTransform();
      }
   }
}
