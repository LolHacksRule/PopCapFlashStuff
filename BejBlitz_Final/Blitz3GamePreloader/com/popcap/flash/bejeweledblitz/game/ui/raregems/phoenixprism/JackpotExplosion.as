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
      
      public function JackpotExplosion(param1:Blitz3App)
      {
         super();
         this.m_App = param1;
         this.m_Coins = new Vector.<JackpotCoin>(50);
      }
      
      public function Init() : void
      {
         var _loc2_:JackpotCoin = null;
         var _loc1_:int = 0;
         while(_loc1_ < this.m_Coins.length)
         {
            _loc2_ = new JackpotCoin(this.m_App);
            this.m_Coins[_loc1_] = _loc2_;
            addChild(_loc2_);
            _loc1_++;
         }
      }
      
      public function Update() : void
      {
         var _loc1_:JackpotCoin = null;
         for each(_loc1_ in this.m_Coins)
         {
            _loc1_.Update();
         }
      }
      
      public function Reset() : void
      {
         var _loc1_:JackpotCoin = null;
         for each(_loc1_ in this.m_Coins)
         {
            _loc1_.Reset();
         }
      }
   }
}
