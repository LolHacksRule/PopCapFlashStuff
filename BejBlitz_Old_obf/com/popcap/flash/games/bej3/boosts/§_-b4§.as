package com.popcap.flash.games.bej3.boosts
{
   import com.popcap.flash.games.blitz3.§_-0Z§;
   
   public class §_-b4§ implements IBoost
   {
      
      public static const §_-oj§:int = 0;
      
      public static const §_-Ad§:int = 3;
      
      public static const §_-aB§:String = "5Sec";
       
      
      private var mApp:§_-0Z§;
      
      public function §_-b4§(param1:§_-0Z§)
      {
         super();
         this.mApp = param1;
      }
      
      public function §_-Iu§() : int
      {
         return §_-Ad§;
      }
      
      public function §_-eA§() : String
      {
         return §_-aB§;
      }
      
      public function IsRareGem() : Boolean
      {
         return false;
      }
      
      public function §_-TR§() : void
      {
         this.mApp.logic.§_-U2§ = 500;
      }
      
      public function §_-dW§() : int
      {
         return §_-oj§;
      }
   }
}
