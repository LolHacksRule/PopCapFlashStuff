package com.popcap.flash.games.bej3.boosts
{
   import com.popcap.flash.games.blitz3.Blitz3App;
   
   public class FiveSecondBoostLogic implements IBoost
   {
      
      public static const ID:String = "5Sec";
      
      public static const NUM_ID:int = 0;
      
      public static const ORDERING_ID:int = 3;
       
      
      private var mApp:Blitz3App;
      
      public function FiveSecondBoostLogic(app:Blitz3App)
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
         this.mApp.logic.timerLogic.AddExtraTime(500);
      }
   }
}
