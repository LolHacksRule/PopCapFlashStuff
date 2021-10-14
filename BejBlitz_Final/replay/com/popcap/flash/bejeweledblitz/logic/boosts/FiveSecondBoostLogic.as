package com.popcap.flash.bejeweledblitz.logic.boosts
{
   public class FiveSecondBoostLogic extends BaseBoost
   {
      
      public static const ID:String = "5Sec";
      
      public static const NUM_ID:int = 0;
      
      public static const ORDERING_ID:int = 3;
       
      
      public function FiveSecondBoostLogic()
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
         super.OnStartGame();
         logic.timerLogic.AddExtraTime(500);
      }
   }
}
