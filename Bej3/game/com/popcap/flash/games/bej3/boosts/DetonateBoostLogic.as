package com.popcap.flash.games.bej3.boosts
{
   import com.popcap.flash.games.bej3.Board;
   import com.popcap.flash.games.bej3.Gem;
   import com.popcap.flash.games.blitz3.Blitz3App;
   
   public class DetonateBoostLogic implements IBoost
   {
      
      public static const ID:String = "Detonate";
      
      public static const NUM_ID:int = 3;
      
      public static const ORDERING_ID:int = 1;
       
      
      private var mApp:Blitz3App;
      
      public function DetonateBoostLogic(app:Blitz3App)
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
         var detonate:Gem = this.mApp.logic.board.GetGemAt(Board.BOTTOM,Board.LEFT);
         detonate.upgrade(Gem.TYPE_DETONATE,true);
         detonate.color = Gem.COLOR_NONE;
         detonate.isImmune = true;
         detonate.autoHint = true;
      }
   }
}
