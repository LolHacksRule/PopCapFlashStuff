package com.popcap.flash.bejeweledblitz.game.quests.completion
{
   import com.popcap.flash.bejeweledblitz.game.session.config.ConfigManager;
   import com.popcap.flash.bejeweledblitz.logic.game.BlitzLogic;
   
   public class StarMedalCompletionStrategy extends ScoreRangeCompletionStrategy
   {
       
      
      public function StarMedalCompletionStrategy(param1:ConfigManager, param2:BlitzLogic, param3:int, param4:int, param5:int, param6:String, param7:String, param8:String)
      {
         super(param2,param1,param3,param4,param6,param7,param8);
      }
   }
}
