package com.popcap.flash.bejeweledblitz.logic.boosts
{
   import com.popcap.flash.bejeweledblitz.logic.Board;
   import com.popcap.flash.bejeweledblitz.logic.Gem;
   
   public class ScrambleBoostLogic extends BaseBoost
   {
      
      public static const ID:String = "Scramble";
      
      public static const NUM_ID:int = 4;
      
      public static const ORDERING_ID:int = 2;
       
      
      public function ScrambleBoostLogic()
      {
         super();
      }
      
      public function DoScrambleActivated() : void
      {
         DispatchBoostActivated();
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
         super.OnStartGame();
         var scramble:Gem = logic.board.GetGemAt(Board.BOTTOM,Board.RIGHT);
         scramble.upgrade(Gem.TYPE_SCRAMBLE,true);
         scramble.color = Gem.COLOR_NONE;
         scramble.isImmune = true;
         scramble.uses = 2;
         scramble.autoHint = true;
      }
   }
}
