package com.popcap.flash.bejeweledblitz.game.quests.completion
{
   import com.popcap.flash.bejeweledblitz.game.quests.QuestConstants;
   import com.popcap.flash.bejeweledblitz.game.session.config.ConfigManager;
   import com.popcap.flash.bejeweledblitz.logic.game.BlitzLogic;
   import com.popcap.flash.framework.utils.StringUtils;
   
   public class ScoreRangeCompletionStrategy extends MinimumScoreCompletionStrategy
   {
       
      
      private var m_CeilingScore:int;
      
      public function ScoreRangeCompletionStrategy(param1:BlitzLogic, param2:ConfigManager, param3:int, param4:int, param5:String, param6:String, param7:String)
      {
         super(param1,param2,param3,param5,param6,param7);
         this.m_CeilingScore = param4;
         var _loc8_:String = StringUtils.InsertNumberCommas(this.m_CeilingScore);
         m_GoalString = m_GoalString.replace(/%max%/g,_loc8_);
      }
      
      override public function ForceCompletion() : void
      {
         m_CurScore = m_TargetScore;
         m_IsComplete = true;
         var _loc1_:Object = QuestConstants.SanitizeQuestObject(m_ConfigManager.GetObj(m_QuestConfigId));
         _loc1_[QuestConstants.KEY_IS_COMPLETE] = m_IsComplete;
         _loc1_[QuestConstants.KEY_PROGRESS] = "" + GetProgress();
         m_ConfigManager.SetObj(m_QuestConfigId,_loc1_);
      }
      
      override public function UpdateCompletionState() : void
      {
         m_CurScore = m_Logic.GetScoreKeeper().GetScore();
         if(m_CurScore >= m_TargetScore && m_CurScore <= this.m_CeilingScore)
         {
            m_IsComplete = true;
         }
      }
      
      override public function HandleGameEnd() : void
      {
         m_CurScore = m_Logic.GetScoreKeeper().GetScore();
         if(m_CurScore >= m_TargetScore && m_CurScore <= this.m_CeilingScore)
         {
            super.HandleGameEnd();
         }
      }
   }
}
