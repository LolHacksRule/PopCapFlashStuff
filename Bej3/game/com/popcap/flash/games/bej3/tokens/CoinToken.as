package com.popcap.flash.games.bej3.tokens
{
   import com.popcap.flash.games.bej3.Gem;
   
   public class CoinToken
   {
      
      public static const KEY:String = "Coin";
       
      
      public var id:int = -1;
      
      public var host:Gem = null;
      
      public var isCollected:Boolean = false;
      
      public var autoCollect:int = -1;
      
      public var collectPoints:int = 0;
      
      public function CoinToken()
      {
         super();
      }
   }
}
