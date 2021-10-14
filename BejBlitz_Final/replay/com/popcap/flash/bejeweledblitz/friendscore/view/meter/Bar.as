package com.popcap.flash.bejeweledblitz.friendscore.view.meter
{
   import com.popcap.flash.framework.App;
   import com.popcap.flash.games.friendscore.resources.FriendscoreImages;
   import flash.display.Bitmap;
   import flash.display.Shape;
   import flash.display.Sprite;
   
   public class Bar extends Sprite
   {
       
      
      protected var m_App:App;
      
      protected var m_Background:Bitmap;
      
      protected var m_Fill:Bitmap;
      
      protected var m_FillMask:Shape;
      
      protected var m_PercentFull:Number;
      
      public function Bar(app:App)
      {
         super();
         this.m_App = app;
         this.m_Background = new Bitmap();
         this.m_Fill = new Bitmap();
         this.m_FillMask = new Shape();
         this.m_PercentFull = 0;
      }
      
      public function Init() : void
      {
         addChild(this.m_Background);
         addChild(this.m_Fill);
         addChild(this.m_FillMask);
         this.m_Background.bitmapData = this.m_App.ImageManager.getBitmapData(FriendscoreImages.IMAGE_METER_EMPTY);
         this.m_Background.smoothing = true;
         this.m_Fill.bitmapData = this.m_App.ImageManager.getBitmapData(FriendscoreImages.IMAGE_METER_FULL);
         this.m_Fill.smoothing = true;
         this.SetFillPercent(0);
         this.UpdateMask();
         this.m_Fill.mask = this.m_FillMask;
         this.m_Fill.cacheAsBitmap = true;
      }
      
      public function SetFillPercent(percent:Number) : void
      {
         this.m_PercentFull = percent;
         this.UpdateMask();
      }
      
      public function GetCurrentPercentFull() : Number
      {
         return this.m_PercentFull;
      }
      
      public function UpdateMask() : void
      {
         this.m_FillMask.graphics.clear();
         this.m_FillMask.graphics.beginFill(0,1);
         var maskWidth:Number = Meter.HORIZ_BUFF + (this.m_Fill.width - Meter.HORIZ_BUFF) * this.m_PercentFull;
         var maskHeight:Number = this.m_Fill.height;
         this.m_FillMask.graphics.drawRect(0,0,maskWidth,maskHeight);
         this.m_FillMask.graphics.endFill();
         this.m_FillMask.cacheAsBitmap = true;
      }
   }
}
