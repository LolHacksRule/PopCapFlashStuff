package com.popcap.flash.games.blitz3.ui.widgets.game.sidebar
{
   import com.popcap.flash.games.bej3.raregems.IRareGem;
   import com.popcap.flash.games.blitz3.Blitz3App;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.Sprite;
   
   public class RareGemWidget extends Sprite
   {
      
      public static const DEFAULT_WIDTH:Number = 28;
      
      public static const DEFAULT_HEIGHT:Number = 29;
       
      
      private var m_App:Blitz3App;
      
      private var m_Image:Bitmap;
      
      private var m_Icons:Vector.<BitmapData>;
      
      private var m_Width:Number = 0;
      
      private var m_Height:Number = 0;
      
      public function RareGemWidget(app:Blitz3App, w:Number = 28, h:Number = 29)
      {
         super();
         this.m_App = app;
         this.m_Width = w;
         this.m_Height = h;
         this.m_Image = new Bitmap();
         this.m_Icons = new Vector.<BitmapData>();
      }
      
      public function Init() : void
      {
      }
      
      public function Clear() : void
      {
         if(this.m_Image)
         {
            if(this.m_Image.parent && this.m_Image.parent == this)
            {
               removeChild(this.m_Image);
            }
         }
      }
      
      public function Reset() : void
      {
         this.Clear();
         var curRareGem:IRareGem = this.m_App.logic.rareGemLogic.currentRareGem;
         if(!curRareGem)
         {
            return;
         }
         this.m_Image.bitmapData = this.m_Icons[curRareGem.GetOrderingID()];
         this.m_Image.scaleX = this.m_Width / this.m_Image.width;
         this.m_Image.scaleY = this.m_Height / this.m_Image.height;
         addChild(this.m_Image);
      }
   }
}
