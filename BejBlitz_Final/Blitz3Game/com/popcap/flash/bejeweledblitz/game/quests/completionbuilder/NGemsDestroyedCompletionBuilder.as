package com.popcap.flash.bejeweledblitz.game.quests.completionbuilder
{
   import com.popcap.flash.bejeweledblitz.game.quests.QuestConstants;
   import com.popcap.flash.bejeweledblitz.game.quests.completion.IQuestCompletionStrategy;
   import com.popcap.flash.bejeweledblitz.game.quests.completion.NColoredGemsDestroyedCompletionStrategy;
   
   public class NGemsDestroyedCompletionBuilder extends BaseCompletionBuilder
   {
      
      public static const IDS:Vector.<String> = new Vector.<String>();
      
      {
         IDS.push("DestroyGems");
         IDS.push("DestroyGemsAny");
      }
      
      public function NGemsDestroyedCompletionBuilder(param1:Blitz3Game)
      {
         super(param1);
      }
      
      override public function BuildQuestCompletionStrategy(param1:Object, param2:String) : IQuestCompletionStrategy
      {
         var _loc6_:String = null;
         if(!CanHandleList(param1,IDS))
         {
            return null;
         }
         var _loc3_:int = parseInt(param1[QuestConstants.KEY_COMPLETION_VAL1]);
         var _loc4_:int = QuestConstants.gemColorAsInt(param1[QuestConstants.KEY_COMPLETION_VAL2]);
         if(param1[QuestConstants.KEY_COMPLETION_TYPE].indexOf("Any") > 0)
         {
            _loc6_ = "Destroy <font color=\'#b0017d\'>%max%</font> total gems";
         }
         else
         {
            _loc6_ = "Destroy <font color=\'#b0017d\'>%max%</font> %color% gems";
         }
         var _loc7_:String = m_App.questManager.GetConfigIdFromQuestId(param2);
         return new NColoredGemsDestroyedCompletionStrategy(m_App,m_App.logic,m_App.sessionData.configManager,_loc3_,_loc4_,_loc7_,"%cur% of %max%",_loc6_);
      }
   }
}
