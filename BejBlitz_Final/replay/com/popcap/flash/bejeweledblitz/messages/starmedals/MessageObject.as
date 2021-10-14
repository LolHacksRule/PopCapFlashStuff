package com.popcap.flash.bejeweledblitz.messages.starmedals
{
   import com.popcap.flash.bejeweledblitz.game.Blitz3App;
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
      
      public function MessageObject(app:Blitz3App)
      {
         super();
         this.m_App = app;
      }
      
      public function getHeaderText() : String
      {
         return this.m_Header.getHeaderText();
      }
      
      public function setHeaderText(text:String) : void
      {
         this.m_Header.setHeaderText(text);
      }
      
      public function getHeaderWidth() : Number
      {
         return this.m_Header.getTextWidth();
      }
      
      public function setIcon(score:int) : void
      {
      }
      
      public function colorBackgroundAnim(backgroundAnim:MovieClip) : void
      {
         backgroundAnim.transform.colorTransform = new ColorTransform();
      }
   }
}
