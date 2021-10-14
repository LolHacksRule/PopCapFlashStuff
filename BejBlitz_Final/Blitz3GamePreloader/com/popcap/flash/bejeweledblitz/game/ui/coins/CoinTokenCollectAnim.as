package com.popcap.flash.bejeweledblitz.game.ui.coins
{
   import com.popcap.flash.bejeweledblitz.game.Blitz3App;
   
   public class CoinTokenCollectAnim
   {
       
      
      protected var m_App:Blitz3App;
      
      public var coinSprite:CoinSprite;
      
      protected var isDone:Boolean;
      
      public function CoinTokenCollectAnim(param1:Blitz3App, param2:CoinSprite)
      {
         super();
         this.m_App = param1;
         this.coinSprite = param2;
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
