package com.popcap.flash.bejeweledblitz.game.ui.gameover
{
   import com.popcap.flash.bejeweledblitz.game.Blitz3App;
   import com.popcap.flash.bejeweledblitz.logic.boosts.DetonateBoostLogic;
   import com.popcap.flash.bejeweledblitz.logic.boosts.FiveSecondBoostLogic;
   import com.popcap.flash.bejeweledblitz.logic.boosts.IBoost;
   import com.popcap.flash.bejeweledblitz.logic.boosts.MultiplierBoostLogic;
   import com.popcap.flash.bejeweledblitz.logic.boosts.MysteryGemBoostLogic;
   import com.popcap.flash.bejeweledblitz.logic.boosts.ScrambleBoostLogic;
   import com.popcap.flash.bejeweledblitz.logic.raregems.CatseyeRGLogic;
   import com.popcap.flash.bejeweledblitz.logic.raregems.IRareGem;
   import com.popcap.flash.bejeweledblitz.logic.raregems.MoonstoneRGLogic;
   import com.popcap.flash.bejeweledblitz.logic.raregems.PhoenixPrismRGLogic;
   import com.popcap.flash.games.blitz3game.resources.Blitz3GameImages;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   
   public class StatsBoostIconBar extends Sprite
   {
      
      protected static var BUFFER:Number = 2;
       
      
      protected var m_App:Blitz3App;
      
      protected var m_Icons:Vector.<Bitmap>;
      
      protected var m_RareGems:Vector.<Bitmap>;
      
      public function StatsBoostIconBar(app:Blitz3App)
      {
         super();
         this.m_App = app;
         this.m_Icons = new Vector.<Bitmap>(5);
         this.m_RareGems = new Vector.<Bitmap>(3);
      }
      
      public function Init() : void
      {
         this.m_Icons[FiveSecondBoostLogic.ORDERING_ID] = new Bitmap(this.m_App.ImageManager.getBitmapData(Blitz3GameImages.IMAGE_BOOST_ICON_5SECOND));
         this.m_Icons[DetonateBoostLogic.ORDERING_ID] = new Bitmap(this.m_App.ImageManager.getBitmapData(Blitz3GameImages.IMAGE_BOOST_ICON_DETONATE));
         this.m_Icons[ScrambleBoostLogic.ORDERING_ID] = new Bitmap(this.m_App.ImageManager.getBitmapData(Blitz3GameImages.IMAGE_BOOST_ICON_SCRAMBLE));
         this.m_Icons[MultiplierBoostLogic.ORDERING_ID] = new Bitmap(this.m_App.ImageManager.getBitmapData(Blitz3GameImages.IMAGE_BOOST_ICON_MULTIPLIER));
         this.m_Icons[MysteryGemBoostLogic.ORDERING_ID] = new Bitmap(this.m_App.ImageManager.getBitmapData(Blitz3GameImages.IMAGE_BOOST_ICON_MYSTERY));
         this.m_RareGems[MoonstoneRGLogic.ORDERING_ID] = new Bitmap(this.m_App.ImageManager.getBitmapData(Blitz3GameImages.IMAGE_RG_ICON_MOONSTONE));
         this.m_RareGems[CatseyeRGLogic.ORDERING_ID] = new Bitmap(this.m_App.ImageManager.getBitmapData(Blitz3GameImages.IMAGE_RG_ICON_CATSEYE));
         this.m_RareGems[PhoenixPrismRGLogic.ORDERING_ID] = new Bitmap(this.m_App.ImageManager.getBitmapData(Blitz3GameImages.IMAGE_RG_ICON_PHOENIXPRISM));
      }
      
      public function Clear() : void
      {
         while(numChildren > 0)
         {
            removeChildAt(0);
         }
      }
      
      public function Reset() : void
      {
         var i:int = 0;
         var boost:IBoost = null;
         var id:int = 0;
         var icon:Bitmap = null;
         this.Clear();
         var boosts:Vector.<IBoost> = this.m_App.logic.boostLogic.currentBoosts;
         var numBoosts:int = boosts.length;
         var numIcons:int = this.m_Icons.length;
         var activeBoosts:Vector.<Boolean> = new Vector.<Boolean>(numIcons);
         for(i = 0; i < numIcons; i++)
         {
            activeBoosts[i] = false;
         }
         var prevIcon:Bitmap = null;
         for(i = 0; i < numBoosts; i++)
         {
            boost = boosts[i];
            id = boost.GetOrderingID();
            activeBoosts[id] = true;
         }
         for(i = 0; i < numIcons; i++)
         {
            if(activeBoosts[i])
            {
               icon = this.m_Icons[i];
               if(icon != null)
               {
                  addChild(icon);
                  if(!prevIcon)
                  {
                     icon.x = 0;
                     icon.y = 0;
                     prevIcon = icon;
                  }
                  else
                  {
                     icon.x = prevIcon.x + prevIcon.width * 0.5 - icon.width * 0.5;
                     icon.y = prevIcon.y + prevIcon.height + BUFFER;
                     prevIcon = icon;
                  }
               }
            }
         }
         var rareGem:IRareGem = this.m_App.logic.rareGemLogic.currentRareGem;
         if(rareGem != null)
         {
            id = rareGem.GetOrderingID();
            icon = this.m_RareGems[id];
            if(icon)
            {
               addChild(icon);
               if(!prevIcon)
               {
                  icon.x = 0;
                  icon.y = 0;
                  prevIcon = icon;
               }
               icon.x = prevIcon.x + prevIcon.width * 0.5 - icon.width * 0.5 - 1;
               icon.y = prevIcon.y + prevIcon.height + BUFFER;
               prevIcon = icon;
            }
         }
      }
   }
}
