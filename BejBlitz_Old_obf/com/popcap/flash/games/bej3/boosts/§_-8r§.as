package com.popcap.flash.games.bej3.boosts
{
   import com.popcap.flash.games.bej3.Gem;
   import com.popcap.flash.games.blitz3.§_-0Z§;
   
   public class §_-8r§ implements IBoost
   {
      
      public static const §_-oj§:int = 1;
      
      public static const §_-Ad§:int = 4;
      
      public static const §_-aB§:String = "FreeMult";
       
      
      private var mApp:§_-0Z§;
      
      public function §_-8r§(param1:§_-0Z§)
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
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc1_:Gem = null;
         var _loc2_:int = 0;
         while(_loc1_ == null || _loc1_.type != Gem.§_-Jz§ || _loc1_.§_-DQ§ || _loc1_.mIsMatchee || _loc2_ == 100)
         {
            _loc3_ = this.mApp.logic.random.§_-Nn§(5,7);
            _loc4_ = this.mApp.logic.random.§_-Nn§(8);
            _loc1_ = this.mApp.logic.board.§_-9K§(_loc3_,_loc4_);
            _loc2_++;
         }
         this.mApp.logic.multiLogic.SpawnGem(_loc1_);
      }
      
      public function §_-dW§() : int
      {
         return §_-oj§;
      }
   }
}
