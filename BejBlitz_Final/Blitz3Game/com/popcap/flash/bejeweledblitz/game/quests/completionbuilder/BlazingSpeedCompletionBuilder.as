package com.popcap.flash.bejeweledblitz.game.quests.completionbuilder
{
   import com.popcap.flash.bejeweledblitz.game.quests.QuestConstants;
   import com.popcap.flash.bejeweledblitz.game.quests.completion.BlazingSpeedCompletionStrategy;
   import com.popcap.flash.bejeweledblitz.game.quests.completion.IQuestCompletionStrategy;
   
   public class BlazingSpeedCompletionBuilder extends BaseCompletionBuilder
   {
      
      public static const ID:String = "GetBlazingSpeed";
       
      
      public function BlazingSpeedCompletionBuilder(param1:Blitz3Game)
      {
         super(param1);
      }
      
      override public function BuildQuestCompletionStrategy(param1:Object, param2:String) : IQuestCompletionStrategy
      {
         var _loc5_:String = null;
         if(!CanHandle(param1,ID))
         {
            return null;
         }
         var _loc3_:int = parseInt(param1[QuestConstants.KEY_COMPLETION_VAL1]);
         if(_loc3_ == 1)
         {
            _loc5_ = "Get <font color=\'#b0017d\'>%max%</font> Blazing Speed in one game";
         }
         else
         {
            _loc5_ = "Get <font color=\'#b0017d\'>%max%</font> Blazing Speeds in one game";
         }
         var _loc6_:String = m_App.questManager.GetConfigIdFromQuestId(param2);
         return new BlazingSpeedCompletionStrategy(m_App.logic,m_App.sessionData.configManager,_loc3_,_loc6_,"%cur% of %max%",_loc5_);
      }
   }
}
