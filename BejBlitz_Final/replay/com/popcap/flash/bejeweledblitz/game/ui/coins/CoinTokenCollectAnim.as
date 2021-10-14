package com.popcap.flash.bejeweledblitz.game.ui.coins
{
   import com.popcap.flash.bejeweledblitz.game.Blitz3App;
   
   public class CoinTokenCollectAnim
   {
       
      
      protected var m_App:Blitz3App;
      
      public var coinSprite:CoinSprite;
      
      protected var isDone:Boolean;
      
      public function CoinTokenCollectAnim(app:Blitz3App, coin:CoinSprite)
      {
         super();
         this.m_App = app;
         this.coinSprite = coin;
         this.isDone = false;
      }
      
      public function Update() : void
      {
      }
      
      public function IsDone() : Boolean
      {
         return this.isDone;
      }
   }
}
