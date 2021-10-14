package com.popcap.flash.bejeweledblitz.game.ui.game.sidebar
{
   import com.popcap.flash.bejeweledblitz.game.Blitz3App;
   import com.popcap.flash.bejeweledblitz.logic.raregems.CatseyeRGLogic;
   import com.popcap.flash.bejeweledblitz.logic.raregems.IRareGem;
   import com.popcap.flash.bejeweledblitz.logic.raregems.MoonstoneRGLogic;
   import com.popcap.flash.bejeweledblitz.logic.raregems.PhoenixPrismRGLogic;
   import com.popcap.flash.games.blitz3game.resources.Blitz3GameImages;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.Sprite;
   
   public class RareGemWidget extends Sprite
   {
       
      
      private var m_App:Blitz3App;
      
      private var m_Image:Bitmap;
      
      private var m_Icons:Vector.<BitmapData>;
      
      public function RareGemWidget(app:Blitz3App)
      {
         super();
         this.m_App = app;
         this.m_Image = new Bitmap();
         this.m_Icons = new Vector.<BitmapData>();
         this.m_Icons[MoonstoneRGLogic.ORDERING_ID] = this.m_App.ImageManager.getBitmapData(Blitz3GameImages.IMAGE_RG_ICON_MOONSTONE);
         this.m_Icons[CatseyeRGLogic.ORDERING_ID] = this.m_App.ImageManager.getBitmapData(Blitz3GameImages.IMAGE_RG_ICON_CATSEYE);
         this.m_Icons[PhoenixPrismRGLogic.ORDERING_ID] = this.m_App.ImageManager.getBitmapData(Blitz3GameImages.IMAGE_RG_ICON_PHOENIXPRISM);
      }
      
      public function Init() : void
      {
      }
      
      public function Clear() : void
      {
         if(this.m_Image != null && contains(this.m_Image))
         {
            removeChild(this.m_Image);
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
         this.m_Image.x = this.m_Image.width * -0.5;
         addChild(this.m_Image);
      }
   }
}
