package com.popcap.flash.bejeweledblitz.logic.tokens
{
   import com.popcap.flash.bejeweledblitz.logic.Gem;
   import com.popcap.flash.framework.pool.IPoolObject;
   import flash.display.MovieClip;
   
   public class CoinToken implements IPoolObject
   {
      
      public static const KEY:String = "Coin";
       
      
      public var id:int;
      
      public var host:Gem;
      
      public var isCollected:Boolean;
      
      public var autoCollect:int;
      
      public var collectPoints:int;
      
      public var value:int;
      
      public var isBonus:Boolean;
      
      public var container:MovieClip;
      
      public function CoinToken()
      {
         super();
         this.Reset();
      }
      
      public function Set(param1:int) : void
      {
         this.value = param1;
      }
      
      public function Reset() : void
      {
         this.value = 0;
         this.id = -1;
         this.host = null;
         this.isCollected = false;
         this.autoCollect = -1;
         this.collectPoints = 0;
         this.isBonus = false;
      }
   }
}
