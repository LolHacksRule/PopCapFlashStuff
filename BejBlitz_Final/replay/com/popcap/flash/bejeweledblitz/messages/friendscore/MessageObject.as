package com.popcap.flash.bejeweledblitz.messages.friendscore
{
   import com.popcap.flash.bejeweledblitz.messages.common.MessageHeader;
   import com.popcap.flash.framework.App;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.filters.GlowFilter;
   import flash.geom.ColorTransform;
   
   public class MessageObject extends Sprite
   {
       
      
      private var m_App:App;
      
      private var m_Config:Object;
      
      private var m_Header:MessageHeader;
      
      private var m_Icon:Bitmap;
      
      public function MessageObject(app:App, config:Object)
      {
         super();
         this.m_App = app;
         this.m_Config = config;
         this.m_Header = new MessageHeader(this.m_App,this.m_Config["headerLocId"]);
         this.m_Header.y = 70;
         addChild(this.m_Header);
         this.m_Icon = new Bitmap(this.m_App.ImageManager.getBitmapData(this.m_Config["icon"]));
         this.m_Icon.x = 0.5 * (this.m_Header.getTextWidth() - this.m_Icon.width);
         this.m_Icon.y = 150;
         this.m_Icon.filters = [new GlowFilter(16777113,1,4,4,2)];
         addChild(this.m_Icon);
      }
      
      public function getMessageText() : String
      {
         return this.m_App.TextManager.GetLocString(this.m_Config["shareMessage"]);
      }
      
      public function setHeaderText(text:String) : void
      {
         this.m_Header.setHeaderText(text);
      }
      
      public function getHeaderText() : String
      {
         return this.m_App.TextManager.GetLocString(this.m_Config["headerLocId"]);
      }
      
      public function getHeaderWidth() : Number
      {
         return this.m_Header.getTextWidth();
      }
      
      public function colorBackgroundAnim(backgroundAnim:MovieClip) : void
      {
         var ct:ColorTransform = new ColorTransform();
         ct.blueOffset = -102;
         backgroundAnim.transform.colorTransform = ct;
      }
   }
}
