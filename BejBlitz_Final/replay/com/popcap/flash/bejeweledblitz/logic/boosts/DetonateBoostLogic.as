package com.popcap.flash.bejeweledblitz.logic.boosts
{
   import com.popcap.flash.bejeweledblitz.logic.Board;
   import com.popcap.flash.bejeweledblitz.logic.Gem;
   
   public class DetonateBoostLogic extends BaseBoost
   {
      
      public static const ID:String = "Detonate";
      
      public static const NUM_ID:int = 3;
      
      public static const ORDERING_ID:int = 1;
       
      
      public function DetonateBoostLogic()
      {
         super();
      }
      
      public function DoDetonateActivated() : void
      {
         DispatchBoostActivated();
      }
      
      public function DoDetonateFailed() : void
      {
         DispatchBoostFailed();
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
         var detonate:Gem = logic.board.GetGemAt(Board.BOTTOM,Board.LEFT);
         detonate.upgrade(Gem.TYPE_DETONATE,true);
         detonate.color = Gem.COLOR_NONE;
         detonate.isImmune = true;
         detonate.uses = 1;
         detonate.autoHint = true;
      }
   }
}
