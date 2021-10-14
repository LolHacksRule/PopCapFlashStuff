package com.popcap.flash.bejeweledblitz.logic.boosts
{
   import com.popcap.flash.bejeweledblitz.logic.Gem;
   
   public class MultiplierBoostLogic extends BaseBoost
   {
      
      public static const ID:String = "FreeMult";
      
      public static const NUM_ID:int = 1;
      
      public static const ORDERING_ID:int = 4;
       
      
      public function MultiplierBoostLogic()
      {
         super();
      }
      
      override public function GetStringID() : String
      {
         return ID;
      }
      
      override public function GetIntID() : int
      {
         return NUM_ID;
      }
      
      override public function GetOrderingID() : int
      {
         return ORDERING_ID;
      }
      
      override public function OnStartGame() : void
      {
         var row:int = 0;
         var col:int = 0;
         super.OnStartGame();
         var multi:Gem = null;
         var multiTryCount:int = 0;
         while(multi == null || multi.type != Gem.TYPE_STANDARD || multi.mHasMove || multi.mIsMatchee || multiTryCount == 100)
         {
            row = logic.random.Int(5,7);
            col = logic.random.Int(0,8);
            multi = logic.board.GetGemAt(row,col);
            multiTryCount++;
         }
         logic.multiLogic.SpawnGem(multi);
      }
   }
}
