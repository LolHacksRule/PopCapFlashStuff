package com.popcap.flash.games.bej3.boosts
{
   import com.popcap.flash.games.bej3.Gem;
   import com.popcap.flash.games.blitz3.§_-0Z§;
   
   public class §_-FA§ implements IBoost
   {
      
      protected static const §_-mi§:int = 3;
      
      public static const §_-oj§:int = 5;
      
      public static const §_-Ad§:int = 5;
      
      public static const §_-aB§:String = "Moonstone";
       
      
      private var mApp:§_-0Z§;
      
      public function §_-FA§(param1:§_-0Z§)
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
         return true;
      }
      
      public function §_-TR§() : void
      {
         var _loc2_:Gem = null;
         var _loc1_:int = 0;
         while(_loc1_ < §_-mi§)
         {
            _loc2_ = null;
            do
            {
               _loc2_ = this.mApp.logic.board.§_-D1§();
            }
            while(_loc2_ == null || _loc2_.type != Gem.§_-Jz§);
            
            _loc2_.§_-PT§(Gem.§_-N3§,true);
            _loc1_++;
         }
      }
      
      public function §_-dW§() : int
      {
         return §_-oj§;
      }
   }
}
