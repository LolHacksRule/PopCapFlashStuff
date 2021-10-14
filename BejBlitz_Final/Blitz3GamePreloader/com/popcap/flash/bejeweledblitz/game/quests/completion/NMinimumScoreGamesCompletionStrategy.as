package com.popcap.flash.bejeweledblitz.game.quests.completion
{
   public class NMinimumScoreGamesCompletionStrategy extends NGamesCompletionStrategy
   {
       
      
      private var m_TargetScore:int;
      
      public function NMinimumScoreGamesCompletionStrategy(param1:Blitz3Game, param2:int, param3:String, param4:String, param5:String, param6:int)
      {
         super(param1,param2,param3,param4,param5);
         this.m_TargetScore = param6;
      }
      
      override public function GetProgressString() : String
      {
         return super.GetProgressString().replace("%min%",this.m_TargetScore);
      }
      
      override public function HandleGameEnd() : void
      {
         if(m_Logic.GetScoreKeeper().GetScore() >= this.m_TargetScore)
         {
            super.HandleGameEnd();
         }
      }
   }
}
