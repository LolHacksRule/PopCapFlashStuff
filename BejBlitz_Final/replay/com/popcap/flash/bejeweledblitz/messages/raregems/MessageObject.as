package com.popcap.flash.bejeweledblitz.messages.raregems
{
   import com.popcap.flash.bejeweledblitz.messages.common.MessageHeader;
   import com.popcap.flash.framework.App;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.filters.GlowFilter;
   
   public class MessageObject extends Sprite
   {
       
      
      protected var m_App:App;
      
      protected var m_Config:Object;
      
      protected var m_Header:MessageHeader;
      
      protected var m_Icon:Bitmap;
      
      public function MessageObject(app:App, config:Object)
      {
         super();
         this.m_App = app;
         this.m_Config = config;
         this.m_Header = new MessageHeader(this.m_App,this.m_Config["headerLocId"]);
         this.m_Header.y = 58;
         addChild(this.m_Header);
         this.m_Icon = new Bitmap(this.m_App.ImageManager.getBitmapData(this.m_Config["icon"]));
         this.m_Icon.x = 0.5 * (this.m_Header.getTextWidth() - this.m_Icon.width);
         this.m_Icon.y = 156;
         this.m_Icon.filters = [new GlowFilter(16777215,1,4,4,2)];
         addChild(this.m_Icon);
      }
      
      public function getMessageText() : String
      {
         return this.m_App.TextManager.GetLocString(this.m_Config["shareMessage"]);
      }
      
      public function getOfferEventId() : String
      {
         return this.m_Config["offerEventId"];
      }
      
      public function getShareEventId() : String
      {
         return this.m_Config["shareEventId"];
      }
      
      public function getHeaderWidth() : Number
      {
         return this.m_Header.getTextWidth();
      }
   }
}
