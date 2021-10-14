package com.popcap.flash.games.bej3.boosts
{
   import com.popcap.flash.games.bej3.Gem;
   import com.popcap.flash.games.bej3.§_-2j§;
   import com.popcap.flash.games.blitz3.§_-0Z§;
   
   public class §_-ia§ implements IBoost
   {
      
      public static const §_-oj§:int = 4;
      
      public static const §_-Ad§:int = 2;
      
      public static const §_-aB§:String = "Scramble";
       
      
      private var mApp:§_-0Z§;
      
      public function §_-ia§(param1:§_-0Z§)
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
         var _loc1_:Gem = this.mApp.logic.board.§_-9K§(§_-2j§.§_-dp§,§_-2j§.RIGHT);
         _loc1_.§_-PT§(Gem.§_-nT§,true);
         _loc1_.color = Gem.§_-aK§;
         _loc1_.§_-af§ = true;
         _loc1_.§_-F6§ = 2;
         _loc1_.§_-Wh§ = true;
      }
      
      public function §_-dW§() : int
      {
         return §_-oj§;
      }
   }
}
