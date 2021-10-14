package com.popcap.flash.games.bej3.boosts
{
   import com.popcap.flash.games.bej3.Gem;
   import com.popcap.flash.games.blitz3.Blitz3App;
   
   public class FreeMultiplierBoostLogic implements IBoost
   {
      
      public static const ID:String = "FreeMult";
      
      public static const NUM_ID:int = 1;
      
      public static const ORDERING_ID:int = 4;
       
      
      private var mApp:Blitz3App;
      
      public function FreeMultiplierBoostLogic(app:Blitz3App)
      {
         super();
         this.mApp = app;
      }
      
      public function GetStringID() : String
      {
         return ID;
      }
      
      public function GetIntID() : int
      {
         return NUM_ID;
      }
      
      public function GetOrderingID() : int
      {
         return ORDERING_ID;
      }
      
      public function OnStartGame() : void
      {
         var row:int = 0;
         var col:int = 0;
         var multi:Gem = null;
         var multiTryCount:int = 0;
         while(multi == null || multi.type != Gem.TYPE_STANDARD || multi.mHasMove || multi.mIsMatchee || multiTryCount == 100)
         {
            row = this.mApp.logic.random.Int(5,7);
            col = this.mApp.logic.random.Int(8);
            multi = this.mApp.logic.board.GetGemAt(row,col);
            multiTryCount++;
         }
         this.mApp.logic.multiLogic.SpawnGem(multi);
      }
   }
}
