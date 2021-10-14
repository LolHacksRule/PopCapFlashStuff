package com.popcap.flash.games.bej3.boosts
{
   import com.popcap.flash.games.bej3.Gem;
   import com.popcap.flash.games.blitz3.§_-0Z§;
   
   public class §_-kT§ implements IBoost
   {
      
      public static const §_-oj§:int = 2;
      
      public static const §_-Ad§:int = 0;
      
      public static const §_-aB§:String = "Mystery";
       
      
      private var mApp:§_-0Z§;
      
      public function §_-kT§(param1:§_-0Z§)
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
         var _loc1_:Gem = null;
         var _loc2_:Array = [Gem.§_-Q3§,Gem.§_-N3§,Gem.§_-l0§];
         var _loc3_:int = _loc2_[this.mApp.logic.random.§_-Nn§(_loc2_.length)];
         while(_loc1_ == null || _loc1_.type != Gem.§_-Jz§)
         {
            _loc1_ = this.mApp.logic.board.§_-D1§();
         }
         _loc1_.§_-PT§(_loc3_);
      }
      
      public function §_-dW§() : int
      {
         return §_-oj§;
      }
   }
}
