package com.popcap.flash.bejeweledblitz.game.ui.raregems.phoenixprism
{
   import com.popcap.flash.bejeweledblitz.game.Blitz3App;
   import flash.display.*;
   import flash.events.*;
   import flash.geom.*;
   
   public class JackpotExplosion extends Sprite
   {
       
      
      private var m_App:Blitz3App;
      
      private var m_Coins:Vector.<JackpotCoin>;
      
      public function JackpotExplosion(app:Blitz3App)
      {
         super();
         this.m_App = app;
         this.m_Coins = new Vector.<JackpotCoin>(50);
      }
      
      public function Init() : void
      {
         var coin:JackpotCoin = null;
         for(var i:int = 0; i < this.m_Coins.length; i++)
         {
            coin = new JackpotCoin(this.m_App);
            this.m_Coins[i] = coin;
            addChild(coin);
         }
      }
      
      public function Update() : void
      {
         var coin:JackpotCoin = null;
         for each(coin in this.m_Coins)
         {
            coin.Update();
         }
      }
      
      public function Reset() : void
      {
         var coin:JackpotCoin = null;
         for each(coin in this.m_Coins)
         {
            coin.Reset();
         }
      }
   }
}
