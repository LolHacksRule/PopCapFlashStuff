package com.popcap.flash.bejeweledblitz.game.quests.reward
{
   import com.popcap.flash.bejeweledblitz.game.quests.Quest;
   import com.popcap.flash.bejeweledblitz.game.quests.QuestConstants;
   
   public class CompoundRewardStrategy implements IQuestRewardStrategy
   {
       
      
      private var m_Strategies:Vector.<IQuestRewardStrategy>;
      
      private var m_Separator:String;
      
      public function CompoundRewardStrategy(param1:Vector.<IQuestRewardStrategy>, param2:String = "<br>")
      {
         super();
         this.m_Strategies = param1;
         this.m_Separator = param2;
      }
      
      public function SetQuest(param1:Quest) : void
      {
         var _loc2_:IQuestRewardStrategy = null;
         for each(_loc2_ in this.m_Strategies)
         {
            _loc2_.SetQuest(param1);
         }
      }
      
      public function DoQuestComplete(param1:Boolean) : void
      {
         var _loc2_:IQuestRewardStrategy = null;
         for each(_loc2_ in this.m_Strategies)
         {
            _loc2_.DoQuestComplete(param1);
         }
      }
      
      public function GetRewardString() : String
      {
         var _loc2_:IQuestRewardStrategy = null;
         var _loc3_:String = null;
         var _loc1_:String = "";
         for each(_loc2_ in this.m_Strategies)
         {
            _loc3_ = _loc2_.GetRewardString();
            if(_loc3_ != "")
            {
               if(_loc1_ != "")
               {
                  _loc1_ += this.m_Separator;
               }
               _loc1_ += _loc3_;
            }
         }
         return _loc1_;
      }
      
      public function getRewardType() : String
      {
         return QuestConstants.QUEST_REWARD_TYPE_COMPOUND;
      }
   }
}
