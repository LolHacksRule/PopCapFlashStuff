package com.popcap.flash.games.bej3.boosts
{
   import com.popcap.flash.games.bej3.Board;
   import com.popcap.flash.games.bej3.Gem;
   import com.popcap.flash.games.blitz3.Blitz3App;
   
   public class ScrambleBoostLogic implements IBoost
   {
      
      public static const ID:String = "Scramble";
      
      public static const NUM_ID:int = 4;
      
      public static const ORDERING_ID:int = 2;
       
      
      private var mApp:Blitz3App;
      
      public function ScrambleBoostLogic(app:Blitz3App)
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
         var scramble:Gem = this.mApp.logic.board.GetGemAt(Board.BOTTOM,Board.RIGHT);
         scramble.upgrade(Gem.TYPE_SCRAMBLE,true);
         scramble.color = Gem.COLOR_NONE;
         scramble.isImmune = true;
         scramble.uses = 2;
         scramble.autoHint = true;
      }
   }
}
