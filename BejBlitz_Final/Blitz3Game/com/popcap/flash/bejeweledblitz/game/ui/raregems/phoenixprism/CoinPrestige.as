package com.popcap.flash.bejeweledblitz.game.ui.raregems.phoenixprism
{
   import com.popcap.flash.bejeweledblitz.game.Blitz3App;
   import com.popcap.flash.bejeweledblitz.game.ui.MainWidgetGame;
   import com.popcap.flash.games.blitz3game.resources.Blitz3GameImages;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   
   public class CoinPrestige extends Sprite
   {
       
      
      private var m_App:Blitz3App;
      
      private var m_AshPileAndBaby:Sprite;
      
      private var m_BabyPhoenix:BabyPhoenix;
      
      private var m_AshPileTop:Bitmap;
      
      private var m_AshPile:Bitmap;
      
      private var m_ShareDialog:CoinPrestigeShareDialog;
      
      private var m_JackpotExplosion:JackpotExplosion;
      
      private var yD:Number;
      
      public function CoinPrestige(param1:Blitz3App, param2:PhoenixPrismPrestige)
      {
         super();
         this.m_App = param1;
         this.m_AshPileAndBaby = new Sprite();
         this.m_BabyPhoenix = new BabyPhoenix(param1,param2);
         this.m_AshPileTop = new Bitmap();
         this.m_AshPile = new Bitmap();
         this.m_ShareDialog = new CoinPrestigeShareDialog(param1,param2);
         this.m_JackpotExplosion = new JackpotExplosion(param1);
      }
      
      public function Init() : void
      {
         this.m_AshPileAndBaby.addChild(this.m_AshPileTop);
         this.m_AshPileAndBaby.addChild(this.m_BabyPhoenix);
         this.m_AshPileAndBaby.addChild(this.m_AshPile);
         addChild(this.m_AshPileAndBaby);
         addChild(this.m_ShareDialog);
         addChild(this.m_JackpotExplosion);
         this.m_BabyPhoenix.Init();
         this.m_BabyPhoenix.x = -12 + this.m_BabyPhoenix.width * -0.5;
         this.m_AshPileTop.bitmapData = this.m_App.ImageManager.getBitmapData(Blitz3GameImages.IMAGE_PP_PRESTIGE_PHOENIX_ASH_PILE_TOP);
         this.m_AshPile.bitmapData = this.m_App.ImageManager.getBitmapData(Blitz3GameImages.IMAGE_PP_PRESTIGE_PHOENIX_ASH_PILE);
         this.m_AshPileTop.x = 54 + this.m_AshPileTop.width * -0.5;
         this.m_AshPileTop.y = -46 + this.m_AshPileTop.height * -0.5;
         this.m_AshPile.x = 74 + this.m_AshPile.width * -0.5;
         this.m_AshPile.y = -2 + this.m_AshPile.height * -0.5;
         this.m_AshPileAndBaby.x = 50 + this.m_AshPileAndBaby.width * 0.5;
         this.m_ShareDialog.Init();
         this.m_ShareDialog.x = (this.m_App.ui as MainWidgetGame).game.PPrismAlignmentAnchor.x + this.m_ShareDialog.width * 0.5;
         this.m_JackpotExplosion.Init();
         this.m_JackpotExplosion.x = 320;
         this.m_JackpotExplosion.y = 280;
         this.Reset();
      }
      
      public function Reset() : void
      {
         visible = false;
         this.m_AshPileAndBaby.y = 580;
         this.yD = 3;
         this.m_ShareDialog.y = -this.m_ShareDialog.height;
         this.m_BabyPhoenix.Reset();
         this.m_ShareDialog.Reset();
         this.m_JackpotExplosion.Reset();
      }
      
      public function Update() : void
      {
         visible = true;
         if(this.m_AshPileAndBaby.y > 380)
         {
            this.m_AshPileAndBaby.y -= this.yD;
            if(this.yD > 1)
            {
               this.yD -= 0.1;
            }
         }
         else
         {
            this.m_BabyPhoenix.Update();
         }
      }
      
      public function ExplodeCoins() : void
      {
         this.m_JackpotExplosion.Update();
      }
      
      public function OfferShare() : void
      {
         if(!this.m_ShareDialog.Update())
         {
            this.m_BabyPhoenix.DustOff();
         }
      }
   }
}
