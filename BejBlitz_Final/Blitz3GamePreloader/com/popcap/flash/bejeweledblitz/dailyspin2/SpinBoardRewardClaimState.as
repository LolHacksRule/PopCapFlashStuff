package com.popcap.flash.bejeweledblitz.dailyspin2
{
   public class SpinBoardRewardClaimState
   {
      
      public static const ClaimStateNotInitiated:uint = 0;
      
      public static const ClaimStateInitiated:uint = 1;
      
      public static const ClaimStateSuccess:uint = 2;
      
      public static const ClaimStateSpinBoardExpired:uint = 3;
      
      public static const ClaimStateOutOfSpins:uint = 4;
      
      public static const ClaimStateFreeSpinAlreadyRedeemed:uint = 5;
      
      public static const ClaimStateFailed:uint = 6;
      
      public static const ClaimAlreadyProcessed:uint = 7;
      
      public static const ClaimSpinBoardNotActive:uint = 8;
      
      public static const ClaimSpinBoardInvalidClaimTimeStamp:uint = 9;
      
      public static const ClaimSpinBoardInvalidRequest:uint = 10;
       
      
      public function SpinBoardRewardClaimState()
      {
         super();
      }
   }
}
